.section .text
.global stampa_low
.type stampa_low, @function

stampa_low:
    movb $76,(%edi,%eax)  
    incl %eax
    movb $79,(%edi,%eax)  
    incl %eax
    movb $87,(%edi,%eax)  
ret
