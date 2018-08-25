	LIST P=16F84
	INCLUDE	P16F84.INC

;==================================================================
;                                                                 ;
;  25EC + 01AD = ? {25}{EC}+{01}{AD} TOPLAM 4 BAYT ADRES GEREKLI  ;
;  SONUC IKI BAYTTAN OLUSACAGI ICIN IKI ADRES SECILECEK           ;
;                                                                 ;
;==================================================================

SONUC1   EQU   H'0A'
SONUC2   EQU   H'0B'

ADRES1   EQU   H'0C'
ADRES2   EQU   H'0D'
ADRES3   EQU   H'0E'
ADRES4   EQU   H'0F'

   MOVLW   H'25'
	 MOVWF   ADRES1

	 MOVLW   H'EC'
	 MOVWF   ADRES2

	 MOVLW   H'01'
	 MOVWF   ADRES3

	 MOVLW   H'AD'
	 MOVWF   ADRES4

   BSF     STATUS,RP0
	 CLRF    TRISB
	 BCF     STATUS,RP0
	 
TOPLA
   MOVF    ADRES2,0  ; W = ADRES2
	 ADDWF   ADRES4,0  ; W = W + ADRES4
	 CALL    GOSTER
   MOVWF   SONUC2

	 BTFSC   STATUS,0  ; ELDE BITI OLUSTUMU KONTROL ET
	 INCF    ADRES1,1  ; VARSA ADRES1'I 1 ARTIR
	 MOVF    ADRES1,0
	 ADDWF   ADRES3,0
	 CALL    GOSTER
	 MOVWF   SONUC1
   GOTO    BITIS

GOSTER
   CLRF    PORTB
	 MOVWF   PORTB
	 RETURN

BITIS
   END
