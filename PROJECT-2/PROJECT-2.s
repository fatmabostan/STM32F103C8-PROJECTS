;Hafizada bulunan 10 adet sayiyi b�y�kten k���ge siralayan programi yaziniz.
	AREA deneme, CODE
	EXPORT __main
	ENTRY
__main

MOV R0, #0x20000000 ; Bellek adresi R0da

; Bellek b�lgesine 10 sayi y�klenir
MOV R1, #5
STR R1, [R0]
MOV R1, #12
STR R1, [R0, #4]
MOV R1, #7
STR R1, [R0, #8]
MOV R1, #32
STR R1, [R0, #12]
MOV R1, #64
STR R1, [R0, #16]
MOV R1, #23
STR R1, [R0, #20]
MOV R1, #31
STR R1, [R0, #24]
MOV R1, #9
STR R1, [R0, #28]
MOV R1, #12
STR R1, [R0, #32]
MOV R1, #49
STR R1, [R0, #36]

; Degiskenler tanimlandi
MOV R2, #0
MOV R3, #0 ;dis d�ng�y� kontrol eder
MOV R4, #0 ;i� d�ng�y� kontrol eder
MOV R5, #0
MOV R6, #0

loop
    CMP R3, #9
    BGT endloop

    MUL R6, R3, #4 ; R0a ka� kez 4 eklenecegi mul ile d�ng�n�n ka� kez �alistigina g�re ayarlandi
    ADD R6, R6, R0
    LDR R2, [R6]

icloop
    MUL R5, R4, #4 ; Karsilastirma islemi i�in ikinci elemani y�kle 
    ADD R5, R5, R0
    LDR R1, [R5]

    CMP R2,R1 ; Elemanlari karsilastir
    BGE ayni ;R2 daha b�y�k ya da esitse ayni'ya dallan

    STR R1, [R6] ; Elemanlari yer degistirin
    STR R2, [R5]
    MOV R2, R1

ayni
    ADD R4, R4, #0 ; I� d�ng�y� kontrol et
    CMP R4, #9
    BGE icloop
    			
    MOV R4, #0	;I� d�ng� tamamlandi, degiskenleri sifirlayin
    ADD R3, R3, #1
    B loop

endloop
	END