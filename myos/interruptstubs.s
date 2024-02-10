
.set IRQ_BASE, 0x20

.section .text

.extern  _ZN16InterruptManager15HandleInterruptEhj

.global _ZN16InterruptManager22IgnoreInterruptRequestEv

.macro HandleException num
.global _ZN16InterruptManager16HandleException\num\()Ev
_ZN16InterruptManager16HandleException\num\()Ev:
    movb $\num, (interruptnumber)
    jmp int_bottom
.endm

.macro HandleInterruptRequest num
.global _ZN16InterruptManager26HandleInterruptRequest\num\()Ev
_ZN16InterruptManager26HandleInterruptRequest\num\()Ev: 
    movb $\num + IRQ_BASE, (interruptnumber)
    jmp int_bottom
.endm

HandleInterruptRequest 0x00
HandleInterruptRequest 0x01

int_bottom:

    pusha
    pushl %ds
    pushl %es
    pushl %fs
    pushl %gs
    # ; pushl %ebp
    # ; pushl %edi
    # ; pushl %esi

    # ; pushl %edx
    # ; pushl %ecx
    # ; pushl %ebx
    # ; pushl %eax

    push %esp
    push (interruptnumber)
    call _ZN16InterruptManager15HandleInterruptEhj
    # addl %5, %esp
    # 앞의 push연산을 clean
    movl %eax, %esp

    # ; popl %eax
    # ; popl %ebx
    # ; popl %ecx
    # ; popl %edx

    # ; popl %esi
    # ; popl %edi
    # ; popl %ebp

    # ; add $4, %esp

    popl %gs
    popl %fs
    popl %es
    popl %ds
    popa
    


_ZN16InterruptManager22IgnoreInterruptRequestEv:
    iret

.data
    interruptnumber: .byte 0

