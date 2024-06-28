.section .data


pilot_0_str:
    .string   "Pierre Gasly\0"
pilot_1_str:
    .string   "Charles Leclerc\0"
pilot_2_str:
    .string   "Max Verstappen\0"
pilot_3_str:
    .string   "Lando Norris\0"
pilot_4_str:
    .string   "Sebastian Vettel\0"
pilot_5_str:
    .string   "Daniel Ricciardo\0"
pilot_6_str:
    .string   "Lance Stroll\0"
pilot_7_str:
    .string   "Carlos Sainz\0"
pilot_8_str:
    .string   "Antonio Giovinazzi\0"
pilot_9_str:
    .string   "Kevin Magnussen\0"
pilot_10_str:
    .string  "Alexander Albon\0"
pilot_11_str:
    .string  "Nicholas Latifi\0"
pilot_12_str:
    .string  "Lewis Hamilton\0"
pilot_13_str:
    .string  "Romain Grosjean\0"
pilot_14_str:
    .string  "George Russell\0"
pilot_15_str:
    .string  "Sergio Perez\0"
pilot_16_str:
    .string  "Daniil Kvyat\0"
pilot_17_str:
    .string  "Kimi Raikkonen\0"
pilot_18_str:
    .string  "Esteban Ocon\0"
pilot_19_str:
    .string  "Valtteri Bottas\0"


invalid_pilot_str:
.string "Invalid\n"
invalid_len:
.long . - invalid_pilot_str

fine_trovata:
.string "1"

max_rpm:
.long 0
max_velocita:
.long 0
max_temp:
.long 0

somma_velocita:
.long 0
n_velocita:
.long 0

.section .text
.global telemetry
.type telemetry, @function

telemetry:
    movl 4(%esp), %esi
    movl 8(%esp), %edi

    pushl %eax
    pushl %ebx
    pushl %ecx
    pushl %edx
    pushl %edi    # MI SALVO IL VALORE DI EDI PERCHE DOPO MI SERVE

    xorl %eax, %eax
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %edx, %edx

# confronto i nomi dei piloti e se il nome è scritto correttamente prosegue con l'esequzione altrimenti stampa invalid
trova_id:
  id0:
    leal pilot_0_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id1

  id1:
    leal pilot_1_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id2

  id2:
    leal pilot_2_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id3

  id3:
    leal pilot_3_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id4

  id4:
    leal pilot_4_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id5

  id5:
    leal pilot_5_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id6

  id6:
    leal pilot_6_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id7

  id7:
    leal pilot_7_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id8

  id8:
    leal pilot_8_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id9

  id9:
    leal pilot_9_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id10

  id10:
    leal pilot_10_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id11

  id11:
    leal pilot_11_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id12

  id12:
    leal pilot_12_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id13

  id13:
    leal pilot_13_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id14

  id14:
    leal pilot_14_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id15

  id15:
    leal pilot_15_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id16

  id16:
    leal pilot_16_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id17

  id17:
    leal pilot_17_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id18

    id18:
    leal pilot_18_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    incl %ebx
    jmp id19

    id19:
    leal pilot_19_str, %edi
    call compare
    cmp $-1,%eax
    jne continua
    jmp STAMPA_INVALID_PRE  # SE SONO DIVERSI SIGNIFICA CHE IL NOME MESSO NON ESISTE E SALTA ALLA STAMPA INVALIDA
# continua con l'esequzione del programma
continua:
    popl %edi   # INDIRIZZO A OUTPUT
    # INPUT: <tempo>,<id_pilota>,<velocità>,<rpm>,<temperatura>
    # OUTPUT: <tempo>,<livello rpm>,<livello temperatura>,<livello velocità>

    # Giri Motore LOW: rpm <= 5000 ||| MEDIUM: 5000 < rpm <=10000 ||| HIGH: rpm > 10000
    # Temperatura LOW: temp <= 90 ||| MEDIUM: 90 < temp <= 110 ||| HIGH: temp > 110
    # Velocità LOW: speed <= 100 ||| MEDIUM: 100< speed <=250 ||| HIGH: speed > 250

# trovo la fine del file di input
    TROVA_FINE:
      pushl %ecx
      cmpb $0,(%esi,%ecx)
      je fine
# ciclo fino a quando non trovo la virgola per trovare l'id
    TROVA_PRIMA_VIRGOLA:
      movb (%esi,%ecx),%dl
      incl %ecx
      cmpb $44,%dl
      je SALVA_VALORI
      jmp TROVA_PRIMA_VIRGOLA
# mi salvo i valori che mi serviranno dopo
    SALVA_VALORI:
      pushl %eax
      pushl %ebx
      movl $0,%ebx
      movl $0,%eax
      jmp VIRGOLA_TROVATA
# ho trovato la virgola quindi richiamo la funzione atoi per convertire l'id in intero
    VIRGOLA_TROVATA:
      call atoi
# controllo l'id della riga con l'id del pilota dato in input se è uguale stampo altrimenti salto la riga
    CONTROLLA_ID:
      popl %ebx   # MI RECUPERO VALORE ID VARIABILE
      cmpl %eax,%ebx    # DA QUA ID_INPUT QUINDI EAX NON MI SERVE PIU E POSSO USARE EAX PER MUOVERMI IN OUTPUT
      jne RIGA_SUCCESSIVA_PRE
      popl %eax
      popl %ecx   # IL PRIMO BYTE NELLA RIGA
# stampo il tempo
    STAMPA_TEMPO:
      movb (%esi,%ecx),%dl  # CONTIENE PRIMO BYTE
      movb %dl,(%edi,%eax)    # STAMPO CARATTERE IN OUTPUT
      incl %eax
      incl %ecx
      cmpb $44,%dl
      jne STAMPA_TEMPO
# salto l'id perche non devo stamparlo
    SALTA_ID:
      movb (%esi,%ecx),%dl
      incl %ecx
      cmpb $44,%dl
      jne SALTA_ID
      pushl %ecx    # SALVA VALORE PER STAMPARE VELOCTIA
# salto la velocità perchè devo stamparla dopo
    SALTA_VELOCITA:
      movb (%esi,%ecx),%dl
      incl %ecx
      cmpb $44,%dl
      jne SALTA_VELOCITA
      pushl %eax  # MI SALVO POSIZIONE OUTPUT
      xorl %eax,%eax
  # stampo RPM
    STAMPA_RPM:
      call atoi
      cmp %eax, max_rpm
      jl  MAX_RPM
      jmp CONTINUA_RPM
      MAX_RPM:
      movl %eax, max_rpm
      CONTINUA_RPM:
      cmpl $5000,%eax
      jle RPM_LOW
      cmpl $10000,%eax
      jle RPM_MEDIUM
      jmp RPM_HIGH

      RPM_LOW:
      popl %eax   # MI RIPRENDO POSIZIONE OUTPUT
      call stampa_low
      incl %eax
      movb $44,(%edi,%eax)
      incl %eax
      jmp STAMPA_TEMPERATURA_PRE
      RPM_MEDIUM:
      popl %eax   # MI RIPRENDO POSIZIONE OUTPUT
      call stampa_medium
      incl %eax
      movb $44,(%edi,%eax)
      incl %eax
      jmp STAMPA_TEMPERATURA_PRE

      RPM_HIGH:
      popl %eax   # MI RIPRENDO POSIZIONE OUTPUT
      call stampa_high
      incl %eax
      movb $44,(%edi,%eax)
      incl %eax
      jmp STAMPA_TEMPERATURA_PRE

# stampo la temperatura
    STAMPA_TEMPERATURA_PRE:
      pushl %eax  # MI SALVO POSIZIONE OUTPUT
      xorl %eax,%eax  # ME LO AZZERO PER RECUPERARE LA TEMPERATURA
      incl %ecx
      STAMPA_TEMPERATURA:
      # FACCIO UNA VERSIONE DELL'ATOI MODIFICATA
      movb (%esi,%ecx),%dl
      cmpb $10,%dl
      je TEMP_FINE_CAPO
      cmpb $0,%dl
      je TEMP_FINE_ZERO
      # MI PRENDO IL VALORE FACENDO LA CONVERSIONE A NUMERO
      subb $48,%dl
      pushl %edx   # MI SALVO IL VALORE DEL BYTE NELLO STACK
      movl $10,%edx  # PER MOLTIPLICARE
      mulb %dl  # EAX = EAX*10
      popl %edx  # MI RIPRENDO IL VALORE DEL CARATTERE
      addl %edx,%eax
      incl %ecx
      jmp STAMPA_TEMPERATURA
      TEMP_FINE_ZERO:
      cmp %eax, max_temp
      jl  MAX_TEMP1
      jmp CONTINUA_TEMP1
      MAX_TEMP1:
      movl %eax, max_temp
      CONTINUA_TEMP1:
      pushl %ecx    # ME LO SALVO PER POI RIPRENDERLO
      leal fine_trovata,%ecx    # CARICO DA MEMORIA LA VARIABILE
      movb $0,(%ecx)   # SE HO TROVATO LA FINE LA METTO A 0
      popl %ecx
      TEMP_FINE_CAPO:
      cmp %eax, max_temp
      jl  MAX_TEMP2
      jmp CONTINUA_TEMP2
      MAX_TEMP2:
      movl %eax, max_temp
      CONTINUA_TEMP2:
      cmpl $90,%eax
      jle TEMP_LOW
      cmpl $110,%eax
      jle TEMP_MEDIUM
      jmp TEMP_HIGH
      TEMP_LOW:
      popl %eax   # MI RIPRENDO POSIZIONE OUTPUT
      call stampa_low
      incl %eax
      movb $44,(%edi,%eax)
      incl %eax
      jmp POPPA_PUSHA
      TEMP_MEDIUM:
      popl %eax   # MI RIPRENDO POSIZIONE OUTPUT
      call stampa_medium
      incl %eax
      movb $44,(%edi,%eax)
      incl %eax
      jmp POPPA_PUSHA

      TEMP_HIGH:
      popl %eax   # MI RIPRENDO POSIZIONE OUTPUT
      call stampa_high
      incl %eax
      movb $44,(%edi,%eax)
      incl %eax
      jmp POPPA_PUSHA

      POPPA_PUSHA:
      popl %ecx   # MI RIPRENDO PER PUNTARE ALLA VELOCITA
      pushl %eax  # MI SALVO POSIZIONE OUTPUT
      xorl %eax,%eax  # ME LO AZZERO PER RECUPERARE LA TEMPERATURA
      movb $44,%dl
# stampo la velocità
    STAMPA_VELOCITA:
      call atoi
      addl %eax, somma_velocita
      addl $1, n_velocita
      cmp %eax, max_velocita
      jl  MAX_VELOCITA
      jmp CONTINUA_VELOCITA
      MAX_VELOCITA:
      movl %eax, max_velocita
      CONTINUA_VELOCITA:
      cmpl $100,%eax
      jle VEL_LOW
      cmpl $250,%eax
      jle VEL_MEDIUM
      jmp VEL_HIGH
      VEL_LOW:
      popl %eax
      call stampa_low
      incl %eax
      pushl %ecx    # ME LO SALVO PER POI RIPRENDERLO
      leal fine_trovata,%ecx    # CARICO DA MEMORIA LA VARIABILE
      cmpb $0,(%ecx)    # SE ECX E' UGUALE A 0 E' STATA TROVATA FINE
      jne NORM
      jmp fine
      NORM:
      popl %ecx
      jmp TROVA_FINE_PRE
      VEL_MEDIUM:
      popl %eax
      call stampa_medium
      incl %eax
      pushl %ecx    # ME LO SALVO PER POI RIPRENDERLO
      leal fine_trovata,%ecx    # CARICO DA MEMORIA LA VARIABILE
      cmpb $0,(%ecx)    # SE ECX E' UGUALE A 0 E' STATA TROVATA FINE
      jne NORM
      jmp fine
      VEL_HIGH:
      popl %eax
      call stampa_high
      incl %eax
      pushl %ecx    # ME LO SALVO PER POI RIPRENDERLO
      leal fine_trovata,%ecx    # CARICO DA MEMORIA LA VARIABILE
      cmpb $0,(%ecx)    # SE ECX E' UGUALE A 0 E' STATA TROVATA FINE
      jne NORM
      jmp fine
# stampo \n e controllo di non essere alla fine
    TROVA_FINE_PRE:
      movb $10,(%edi,%eax)
      incl %eax
      jmp TROVA_FINE
# poppo i valori che avevo salvato
    RIGA_SUCCESSIVA_PRE:
      popl %eax
      popl %ecx   # IL PRIMO BYTE NELLA RIGA
# se sono alla fine della riga controllo che non sia la fine del file altrimenti salto alla riga riga successiva
    RIGA_SUCCESSIVA:
      movb (%esi,%ecx),%dl
      incl %ecx
      cmpb $0,%dl
      je TROVA_FINE
      cmpb $10,%dl
      je TROVA_FINE
      jmp RIGA_SUCCESSIVA
# se il pilota nel file di input è sbagliato stampa la scritta invalid
    STAMPA_INVALID_PRE:
      popl %edi   # INDIRIZZO A OUTPUT
      leal invalid_pilot_str,%edx
      xorl %eax,%eax     # AZZERO PER SICUREZZA
      xorl %esi,%esi  # TANTO NON MI SERVE PIU MUOVERMI NELL'INPUT QUINDI LO USO
      xorl %ecx,%ecx
      STAMPA_INVALID:
      movb (%edx,%ecx),%al
      movb %al,(%edi,%esi)
      incl %esi
      incl %ecx
      cmpl invalid_len,%ecx
      jne STAMPA_INVALID

      jmp fine_invalid    # ALTIRMENTI FA UN POPL DI TROPPO

# stampo la riga finale
fine:
# stampa gli rpm massimi
  pushl %eax
  movl max_rpm, %eax
  call itoa
  popl %eax
  xorl %ecx, %ecx
  xorl %ebx, %ebx
  stampa_rpm_max:
  movb (%edx,%ecx),%bl
  movb %bl,(%edi,%eax)
  incl %eax
  incl %ecx
  cmp $0, %bl
  jne stampa_rpm_max

# stampa la virgola
  decl %eax
  movb $44, %bl
  movb %bl,(%edi,%eax)
  incl %eax

# stampa la temperatura massima
  pushl %eax
  movl max_temp, %eax
  call itoa
  popl %eax
  xorl %ecx, %ecx
  xorl %ebx, %ebx
  stampa_temp_max:
  movb (%edx,%ecx),%bl
  movb %bl,(%edi,%eax)
  incl %eax
  incl %ecx
  cmp $0, %bl
  jne stampa_temp_max

# stampa la virgola
  decl %eax
  movb $44, %bl
  movb %bl,(%edi,%eax)
  incl %eax

# stampa la velocità massima
  pushl %eax
  movl max_velocita, %eax
  call itoa
  popl %eax
  xorl %ecx, %ecx
  xorl %ebx, %ebx
  stampa_velocita_max:
  movb (%edx,%ecx),%bl
  movb %bl,(%edi,%eax)
  incl %eax
  incl %ecx
  cmp $0, %bl
  jne stampa_velocita_max

# stampa la virgola
  decl %eax
  movb $44, %bl
  movb %bl,(%edi,%eax)
  incl %eax

# stampa la media della velocità
  pushl %eax
  movl somma_velocita, %eax
  movl n_velocita, %ebx
  xorl %edx, %edx
  divl %ebx
  call itoa
  popl %eax
  xorl %ecx, %ecx
  xorl %ebx, %ebx
  stampa_media:
  movb (%edx,%ecx),%bl
  movb %bl,(%edi,%eax)
  incl %eax
  incl %ecx
  cmp $0, %bl
  jne stampa_media

# stampa l'acapo
  decl %eax
  movb $10, %bl
  movb %bl,(%edi,%eax)
  incl %eax

  popl %edx   # QUESTO LO FACCIO PERCHE E' DI TROPPO
# poppo i valori dei registri che avevo pushato all'inizio
fine_invalid:
  popl %edx
  popl %ecx
  popl %ebx
  popl %eax

ret
