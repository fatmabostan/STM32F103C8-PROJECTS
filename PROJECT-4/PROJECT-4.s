;Tim1 kullanarak PortA 8 numarali pinden 1Hz lik sinyal üreten programi yaziniz.
apb2enr equ 0x18
porta equ 0x40010800
crh equ 0x04
odr equ 0x0C
tim1 equ 0x40012C00
dier equ 0x0C
cr1 equ 0x00 ;0.bit timer start
ccmr1 equ 0x18 ;6. ve 5.bitler 1 olmali
ccer equ 0x20
bdtr equ 0x44 ;15.biti set et
cnt equ 0x24
psc equ 0x28
arr equ 0x2C
sr equ 0x10
iser equ 0xE000E100 ;25.bit timer1

	AREA deneme, CODE
	EXPORT __main
	ENTRY
__main

mov32 r0,#rcc
ldr r1,[r0,#apb2enr]
orr r1,#((1<<11)|(1<<2))
str r1,[r0,#apb2enr] ;tim1 ve porta set edildi

mov32 r0,#porta
ldr   r1,[r0,#crh]
and   r1,#~(0xf)
orr   r1,#((1<<3)|(1<<1)|(1)) ;push pull, 50mhz
str r1,[r0,#crh]
ldr r1,[r0,#odr]
orr r1,#(1<<8)
str r1,[r0,#odr]

mov32 r0, #tim1
ldr r1,[r0,#ccmr1]
orr r1,#((1<<6)|(1<<5))
str r1,[r0,#ccmr1]

ldr r1,[r0,#ccer]
orr r1,#(1)
str r1,[r0,#ccer]

ldr r1,[r0, #bdtr]
orr r1,#(1<<15)
str r1,[r0, #bdtr]

mov r1, #(9999)   ; 10000 degerini r1 kaydina yükle
str r1, [r0, #arr]   ; r1 kaydindaki degeri arr kaydina yaz

mov r1, #7119
str r1, [r0, #psc] ; 10000/(72000000/7200)=1sn=1hz

ldr r1,[r0,#cr1]
orr r1,#(1) ;0.bit set edildi
str r1,[r0,#cr1] ;timer start

loop	
	start
	ldr r1, [r0, #sr]
	tst r1, #1
	bne start
	and r1, #~(1)
b loop

	END