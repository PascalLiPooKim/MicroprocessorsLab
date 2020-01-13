	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start
	movlw 	0x0
	movwf	TRISB, ACCESS	    ; Port C all outputs
	bra 	test
loop	movff 	0x06, PORTB
	incf 	0x06, W, ACCESS
test	movwf	0x06, ACCESS	    ; Test for end of loop condition
	
	
	; delay speed of counter
	movlw	0x10
	movwf	0x20, ACCESS
	call	delay
	
	
	movlw 	0x63
	cpfsgt 	0x06, ACCESS
	bra 	loop
	
	
	
	
			    ; Not yet finished goto start of loop again
	
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
	
	goto 	0x0		    ; Re-run program from start
	
	end
