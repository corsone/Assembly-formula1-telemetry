# compara i nomi dei piloti se sono diversi salva in %eax -1 altrimenti salva 0 in %eax

.section .text
.global compare
.type compare, @function


compare:
  xorl %ecx, %ecx
  id:
  movb (%edi, %ecx), %al
  movb (%esi, %ecx), %dl
  incl %ecx
  cmp $0, %al
  jne controllo
  cmp $10, %dl
  je ritorna2
  jmp ritorna1
  controllo:
  cmp %al, %dl
  jne ritorna1
  jmp id

ritorna1:
movl $-1, %eax

ret

ritorna2:
movl $0, %eax

ret
