;Assignment 3
;Assignment 2 program but in AVR assembly
;By RAJESH    IS21MTECH11002
;
;



.nolist
.include "m328pdef.inc" ; Define device ATmega328P
.list

ldi r16,low(RAMEND) ; RAMEND address 0x08ff
 out SPL,r16        ; Stack Pointer Low SPL at i/o address 0x3d
 ldi r16,high(RAMEND)
 out SPH,r16

ldi r16,0b11111110
out DDRD,r16           ; pins D1 - D7 are set as output

ldi r16,0b00110000
out DDRB,r16

ldi r16, 0b00000101    ;  the last 3 bits define the prescaler, 101 => division by 1024
out TCCR0B, r16

ldi r18,0b00000000
out PortD,r18
ldi r25,0x07
load_table:
ldi r20, 0x08          ; conter register


ldi ZL, low(sev_seg<<1)
ldi ZH, high(sev_seg<<1)

loop:
    dec r20
   rcall DISPNUM
    brmi load_table

    rcall BITSEP

    and r21,r22           ; (XY)+(YZ)
    and r23,r22
    or r21,r23          ; final result in r21
    lsl r21
    lsl r21
    lsl r21
    lsl r21
    lsl r21

    rcall NAND1           ; NAND Equivalent
    rcall NAND2
    rcall NAND3           ; final result in r11
    lsl r11
    lsl r11
    lsl r11
    lsl r11


    or r21,r11
    out PortB,r21

    ldi r19, $32
    rcall DELAY

    rjmp loop

DELAY:         ;this is delay (function)
               ;times to run the loop = 64 for 1 second delay
    lp2:
        IN r16, TIFR0        ;tifr is timer interupt flag (8 bit timer runs 256 times)
        ldi r17, 0b00000010
        AND r16, r17         ;need second bit
        BREQ DELAY
        OUT TIFR0, r17       ;set tifr flag high
        dec r19
        brne lp2
    ret

DISPNUM:
    lpm r17, Z+
    out PortD,r17

ret


BITSEP:
    mov r21, r25     ;X LSB
    sub r21,r20
    andi r21,0x01
    mov r11,r21

    mov r22, r25     ;Y
    sub r22,r20
    andi r22,0x02
    lsr r22
    mov r12,r22

    mov r23, r25     ;Z MSB
    sub r23,r20
    andi r23,0x04
    lsr r23
    lsr r23
    mov r13,r23

    ret

NAND1:
and r11,r12
com r11

ret

NAND2:
and r13,r12
com r13
ret

NAND3:
and r11,r13
com r11
ret


ret
sev_seg: .DB  0x02, 0x9e, 0x24, 0x0c, 0x98, 0x48, 0x40, 0x1e, 0x00, 0x08, 0x10, 0xc0, 0x62, 0x84, 0x60, 0x70
