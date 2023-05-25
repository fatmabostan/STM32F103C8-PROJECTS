;PC_13 e bagli olan ledi butona (PA_0) basildiginda yakip çekildiginde söndüren programi interrupt kullanarak yaziniz.
rcc 	equ	0x40021000
apb2enr	equ	0x18
porta	equ	0x40010800
portc	equ	0x40011000
exti	equ	0x40010400
afio	equ	0x40010000
nvic	equ	0xE000E100 
odr	equ	0x0c
idr	equ	0x08
crh	equ	0x4	
crl	equ	0x00

	AREA deneme, CODE
	EXPORT __main
__main PROC

mov32	r0,#rcc
ldr	r1,[r0,#apb2enr]
orr	r1,#((1<<4)|(1<<2)|(1)) ;portc, porta ve afio biti set edildi
str	r1,[r0,#apb2enr]

mov32	r2,#portc
ldr	r1,[r2,#crh] ;crh 
and	r1,#~(0xf<<20)
orr	r1,#(1<<21)
str	r1,[r2,#crh]
	
mov32	r2,#porta
ldr	r3,[r2,#crl]
and	r3,#~(0xf)
orr	r3,#(1<<3)
str	r3,[r2,#crl]
	
ldr	r3,[r2,#odr]
orr	r3,#1
str	r3,[r2,#odr]

;interrupt registerlarini ayarlama
mov32 R2,#afio
ldr R1,[R2,#0x08] ;AFIO_EXTICR1
and R1,#~(0xf) ;EXTI0[3:0] PA'nin 0.biti ayarlandi
str R1,[R2,#0x08]

mov32 R2,#exti
ldr R1,[R2,#0x00]
orr R1, #1 ;IMR 0.pin set edildi
str R1,[R2,#0x00]

;düsen kenar seçildi çünkü 13.pindeki led yanmazken 1, yanmasi için 0 olmasi lazim
ldr R1,[R2,0x0C] ;falling trigger adresi
orr R1, #1 ;falling trigger 0.bit set edildi
str R1,[R2,0x0C]

ldr R1,[R2,0x14] ;pending register
orr R1, #1
str R1,[R2,0x14]

ldr R1, #nvic ;interrupt aktif
orr R1, #(1<<6)
str R1, #nvic

mov32	r0,#portc
mov32	r1,#porta

;dügmeyi kontrol eder 
loop

loop1	
ldr	r3,[r1,#idr]
tst	r3,#1
bne	loop1

ldr 	r5,[r0,#odr]
orr	r5,#(1<<13)	
str 	r5,[r0,#odr];led söndü

loop2
ldr	r3,[r1,#idr]
tst	r3,#1
beq	loop2

b loop


EXTI0_IRQHandler PROC
	EXPORT EXTI0_IRQHandler
	
	ldr 	r5,[r0,#odr]
	and	r5,#~(1<<13)	
	str 	r5,[r0,#odr] ;led yanar
	
	ldr R1,[R2,0x14] ;pending register sifirlandi
	orr R1, #1
	str R1,[R2,0x14]

	BX lr
 ENDP 

END