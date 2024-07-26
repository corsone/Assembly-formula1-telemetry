This is a project for the Computer Architecture course that I completed during the first year of my Bachelor's degree in Computer Science

# Project specifications
The program simulates the telemetry system of the F1 video game. 

## Run the program
The program must be run from the command line with two strings as parameters. 
The first string identifies the name of the .txt file to use as input, and the second one specifies the output file name: 
```
./telemetry input.txt output.txt
```

## Input 
The system takes as input the name of a driver to monitor, as well as raw data on engine RPM, engine temperature, 
and speed for all drivers in the race at every moment in time.

Each line of the input file is composed as follows:
> \<time\>,\<driver_id\>,\<speed\>,\<rpm\>,\<temperature\>

where driver_id represents a numeric value that uniquely identifies a driver.

## Output
The program (written in assembly) returns data related only to the driver specified in the first line of the file, based on the thresholds: **LOW**, **MEDIUM**, **HIGH**.
The output file reports these thresholds for all the moments in time when the driver is being monitored.

> If the specified driver name is not valid, the program returns the string "Invalid".

The thresholds for the monitored data are defined as follows:

- Engine RPM
  - LOW: rpm <= 5000
  - MEDIUM: 5000 < rpm <=10000
  - HIGH: rpm > 10000
- temperature
  - LOW: temp <= 90
  - MEDIUM: 90 < temp <= 110
  - HIGH: temp > 110
- speed
  - LOW: speed <= 100
  - MEDIUM: 100 < speed <= 250
  - HIGH: speed > 250

Each line of the output file is composed as follows:
> \<time\>,\<rpm level\>,\<temperature level\>,\<speed level\>

Additionally, at the end of the output file, a line is added containing the following statistics:
> \<max rpm\>,\<max temperature\>,\<max speed\>,\<average speed\>

# Design choices

## Variables
The variables used are:
- The 20 drivers, which are used for comparison with the driver to be monitored. If the input does not match any of these variables, "Invalid" will be printed.
- **Fine_trovata:** It is a support variable used to determine when to print the final line.
- **Max_rpm:** It is an integer variable initially set to 0, and it gets updated whenever a higher RPM value is encountered.
- **Max_temp:** It is an integer variable initially set to 0, and it gets updated whenever a higher temperature value is encountered.
- **Max_velocità:** It is an integer variable initially set to 0, and it gets updated whenever a higher speed value is encountered.
- **Somma_velocità:** It is initialized to 0 and each time a speed is found, it is added to this total.
- **N_velocità:** It counts the number of speed readings, which will then be divided into the total speed to compute the average.

## Functions
The functions used are:

- **atoi:** Used to convert a string to a number. In this case, the values of registers `eax` and `ebx` are set to 0, while the converted integer value is returned in `eax`.
- **compare:** Used to compare the driver name from the input file with those in the variables. The address of the input string containing the name is passed using register `esi`, while the address of the driver name in the variable is passed using register `edi`. If the two names match, the function returns 0 in `eax`; otherwise, it returns -1 in `eax`. These values are used to determine if the driver ID has been found or if another driver should be checked.
- **stampa_high:** Used to print the string "HIGH". In this case, the number to position in the output is passed in `eax`, and it is added to `edi`, which contains the pointer to the output file.
- **stampa_medium:** Used to print the string "MEDIUM". Similarly, the number for positioning in the output is passed in `eax`, and it is added to `edi`, which contains the pointer to the output file.
- **stampa_low:** Used to print the string "LOW". Again, the number for positioning in the output is passed in `eax`, and it is added to `edi`, which contains the pointer to the output file.
- **itoa:** Used to convert an integer to a string. The value to convert is passed through register `eax`, while the address of the resulting string is returned in register `edx`.

## Stack management
Since registers are limited and many variables are used, the program, in addition to using static variables, manages information storage through the stack. It does this by pushing the values that need to be saved onto the stack and then retrieving them by popping.

# Program logic
Once the program starts, to find the driver ID from the input file, the `compare` function is called to compare the driver name from the input file with those in the variables. If the names match, the function sets `eax` to 0, which means the driver name corresponding to the input file has been found and the program can proceed. If the names do not match, `eax` is set to -1, indicating that the input name does not match any in the variables, so the program must move on to check the next driver name. If, after checking all 19 drivers' names, no match is found, the program will print "invalid" and terminate.

After this process, the program continues and checks if the input character is 0 or not:
- If not, it means the program should continue.

  - First, it retrieves the input ID by searching for the first comma to skip the time and then starts from there to get the ID, continuing until another comma is found while converting the ID from a string to a number.

  - Then, for each line, it compares the input ID with the driver ID. If they are different, the current line is not needed and is skipped; otherwise, it continues. It skips the speed by finding the comma, records its position (since it will be the last in the output), and retrieves the RPM, converts it to an integer, and checks if it is greater than the previous maximum RPM. If it is, the current RPM is set as the maximum; otherwise, the maximum RPM remains unchanged. It then compares the RPM and prints whether its level is HIGH, MEDIUM, or LOW using the appropriate functions. The same procedure is followed for the temperature, checking if the end-of-string character is `\0` or `/n`.
  - If it is `\0`, it means the input file has ended. After printing the values, the program finishes. If it is `/n`, the program continues.
  - Finally, after retrieving the position of the speed in the line, it calculates the maximum speed and its average, printing its level as well. After processing and printing values for the line, the program starts again from the top until the end is reached.
- If the answer is affirmative, the program will proceed to the end and print the maximum RPM, maximum temperature, maximum speed, and average speed, then terminate the execution.