section .data
    msg db 'Hello, world!', 0xa
    len equ $ - msg

section .text
    global _start

_start:
    mov ecx,msg
    mov edx,len
    mov ebx,1
    mov eax,4 ; sys_write
    int 0x80

    mov eax,1 ; sys_exit
    int 0x80