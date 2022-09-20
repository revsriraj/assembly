.include "/home/meghana/m328Pdef.inc"

ldi r16, 0b00111100 ;identifying output pins 2,3,4,5
out DDRD,r16		;declaring pins as output



ldi r16,0b00000000	;initializing X
ldi r17,0b00000001	;initializing Y
ldi r18,0b00000000	;initializing Z

ldi r20,0b00000001  


AND r16,r17         ;g=x&&y
ldi r23,0b00000001
eor r23,r17        ;y!
AND r23,r16        ;s=g&&!y
ldi r24,0b00000001 
eor r24,r23        ;s=!(g&&!y)
AND r24,r17        ;l=s&&y
ldi r25,0b00000001
eor r25,r24        ; l=!(s&&y) 
ldi r26,0b00000001
eor r26,r18         ;!z
OR r23,r26         ;h=s||!z
ldi r27,0b00000001
eor r27,r23        ;h=!(s||!z)
OR r27,r25         ;a=(h||l)
ldi r28,0b00000001
eor r28,r27        ;a=!(h||l)


;following code is for displaying output
;shifting LSB in r16 to 2nd position
ldi r20, 0b00000010	;counter = 2

rcall loopw		;calling the loopw routine

out PORTD,r28		;writing output to pins 2,3,4,5


Start:
rjmp Start

;loop for bit shifting
loopw:	lsl r28			;left shift
	dec r20			;counter --
	brne loopw	;if counter != 0
	ret
