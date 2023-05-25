; 0x20000000 adresinden baslayarak RAM e istediginiz iki sayiyi (32bit uzunlugunda)kaydediniz. Takip eden sonraki RAM adreslerine kaydettiginiz sayilarin toplamini, �arpimini ve farkini kaydeden programi yaziniz.
	AREA deneme, CODE
	EXPORT __main
	ENTRY
__main
	mov32 R0,#0x20000000 
	mov R1,#5 ;R1 registerina 5 y�kledik
	STR R1,[R0] ;R1 RAMde R0a yazildi
	
	MOV R1,#20 ;R1e 20yazdik
	STR R1,[R0,#4] ;RAMin R0dan sonra gelen adresine R1 y�klendi
	
	LDR R2,[R0] ;RAMdeki R0 ve sonraki h�creden bilgiler R2 ve R3 registerina �ekildi
	LDR R3,[R0,#4] ;sonu� R0dan 1h�cre sonrasina yazildi
	
	ADD R4,R2,R3 ;toplama r4=r2+r3
	STR R4,[R0,#8] ;sonu� R0dan 2h�cre sonrasina yazildi
	
	MUL R4,R2,R3 ;�arpma r4=r2*r3
	STR R4,[R0,#12] ;sonu� R0dan 3h�cre sonrasina yazildi
	
	SUB R4,R3,R2 ;�ikarma r4=r3-r2
	STR R4,[R0,#16] ;sonu� R0dan 4h�cre sonrasina yazildi
	
	END