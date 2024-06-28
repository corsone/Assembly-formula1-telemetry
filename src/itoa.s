# converts an integer into a string

.section .data

	numstr: .ascii "00000000000"     # string output

	numtmp: .ascii "00000000000"     # temporary string


.section .text
.global itoa
.type itoa, @function
itoa:
	movl $10, %ebx             # carica 10 in EBX (usato per le divisioni)
	movl $0, %ecx              # azzera il contatore ECX

	leal numtmp, %esi          # carica l'indirizzo di 'numtmp' in ESI


continua_a_dividere:

	movl $0, %edx              # azzera il contenuto di EDX
	divl %ebx                  # divide per 10 il numero ottenuto

	addb $48, %dl              # aggiunge 48 al resto della divisione
	movb %dl, (%ecx,%esi,1)    # sposta il contenuto di DL in numtmp

	inc %ecx                   # incrementa il contatore ECX

	cmp $0, %eax               # controlla se il contenuto di EAX è 0

	jne continua_a_dividere


	movl $0, %ebx              # azzera un secondo contatore in EBX

	leal numstr, %edx          # carica l'indirizzo di 'numstr' in EDX

ribalta:

	movb -1(%ecx,%esi,1), %al  # carica in AL il contenuto dell'ultimo byte di 'numtmp'
	movb %al, (%ebx,%edx,1)    # carica nel primo byte di 'numstr' il contenuto di AL

	inc %ebx                   # incrementa il contatore EBX

	loop ribalta


stampa:

	movb $0, (%ebx,%edx,1)    # aggiunge il carattere '\0' in fondo a 'numstr'

	leal numstr, %edx


ret
