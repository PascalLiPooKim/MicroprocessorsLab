	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start
	lfsr FSR0, 0x50    ; TODO: Create counter for this memory locationload address 0x06 into FSR0
			; load 0x10 into W
	movlw 	0x0
	movwf	TRISB, ACCESS	    ; Port C all outputs
	bra 	test
loop	movff 	0x06, PORTB
	incf 	0x06, W, ACCESS
test	movwf	0x06, ACCESS	    ; Test for end of loop condition
	
	;
	;movlw	0x00
	;movwf	0x08, ACCESS
	call save_fsr
	
	; delay speed of counter
	movlw	0x10
	movwf	0x20, ACCESS
	call	delay
	
	
	movlw 	0x63
	cpfsgt 	0x06, ACCESS
	bra 	loop	; Not yet finished goto start of loop again
	
	
	goto 	0x0		    ; Re-run program from start
	
	; a delay subroutine
delay	decfsz	0x20
	
	movlw	0x05
	movwf	0x30, ACCESS
	
	call extra_delay
	bra delay
	return
	
extra_delay decfsz  0x30
	    bra extra_delay
	    return
	    
save_fsr incf    PREINC0
			
	
	    ;incf INDF0, f  ; adds W to contents of address 0x140	    
	    incf    PREINC0 
	    
	    movlw   0x02
	    movwf   POSTINC0
	    
;	    movlw   0x03
;	    movwf   POSTINC0
;	    
;	    movlw   0x04
;	    movwf   POSTINC0
;	    ;addwf 0x60
	    
	 lfsr FSR1, 0x60
	    movff   INDF1,  0x65
	    ; puts result back into address 0x140
	    return
	
	
	end
