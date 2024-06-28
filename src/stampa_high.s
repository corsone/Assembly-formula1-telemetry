.section .text
.global stampa_high
.type stampa_high, @function

stampa_high:
    movb $72,(%edi,%eax)  
    incl %eax
    movb $73,(%edi,%eax)  
    incl %eax
    movb $71,(%edi,%eax)  
    incl %eax
    movb $72,(%edi,%eax)  
ret
