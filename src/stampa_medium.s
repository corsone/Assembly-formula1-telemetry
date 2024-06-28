.section .text
.global stampa_medium
.type stampa_medium, @function

stampa_medium:
    movb $77,(%edi,%eax)  
    incl %eax
    movb $69,(%edi,%eax)  
    incl %eax
    movb $68,(%edi,%eax)  
    incl %eax
    movb $73,(%edi,%eax) 
    incl %eax
    movb $85,(%edi,%eax) 
    incl %eax
    movb $77,(%edi,%eax) 
ret
