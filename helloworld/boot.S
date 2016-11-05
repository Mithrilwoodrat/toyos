.section .data
string:
	.ascii "Hello OSworld\n"
string_end:
	.equ len, string_end - string

.globl start
start:
    .code16                                             # Assemble for 16-bit mode
    cli                                             # Disable interrupts
    cld                                             # String operations increment
    # Set up the important data segment registers (DS, ES, SS).
    xorw %ax, %ax                                   # Segment number zero
    movw %ax, %ds                                   # -> Data Segment
    movw %ax, %es                                   # -> Extra Segment
    movw %ax, %ss                                   # -> Stack Segment

.print:
    movw $string, %ax
    movw %ax, %bp
    movw $len, %cx
    movw $0x01301, %ax
    movw $0x000c , %bx
    mov $0, %dl
    int $0x10
	
.end:
    jmp .end
	
