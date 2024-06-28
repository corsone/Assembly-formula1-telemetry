.section .text
.global atoi
.type atoi, @function

atoi:
    movb (%esi,%ecx),%dl
    cmpb $44,%dl
    je FINE
    # MI PRENDO IL VALORE FACENDO LA CONVERSIONE A NUMERO
    subb $48,%dl
    pushl %edx   # MI SALVO IL VALORE DEL BYTE NELLO STACK
    movl $10,%edx  # PER MOLTIPLICARE
    mull %edx  # EAX = EAX*10
    popl %edx  # MI RIPRENDO IL VALORE DEL CARATTERE
    addl %edx,%eax
    incl %ecx
    jmp atoi

FINE:
ret
