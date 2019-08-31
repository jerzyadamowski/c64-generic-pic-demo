; C64
BASIC         = $0801

;==========================================================
; BASIC header
;==========================================================

* = BASIC

        !byte $0b, $08
        !byte $9A                     ; BASIC line number:  $029A = 666; $029B = 667     
        !byte $02, $9E
        !byte '0' + entry % 10000 / 1000        
        !byte '0' + entry %  1000 /  100        
        !byte '0' + entry %   100 /   10        
        !byte '0' + entry %    10             
        !byte $00, $00, $00           ; end of basic

entry
        sei
        jsr initscreen
        ;jsr inittext
        ldy #$7f
        sty $dc0d
        sty $dd0d
        lda $dc0d
        lda $dd0d
        lda #$01
        sta $d01a
        lda $d011
        and #$7f
        sta $d011
        lda #<irq
        ldx #>irq
        sta $0314
        stx $0315
        lda #$00
        sta $d012
        cli
end
        jmp end
;---------------------------------------
;irq routine

irq
        dec $d019
        ;jsr fontcolor
        jmp $ea81
;---------------------------------------
;clear screen to color

initscreen
        ldx #$00
        stx $d021
        stx $d020

clear
        lda #$20
        sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $06e8,x
        lda #$01
        sta $d800,x
        sta $d900,x
        sta $da00,x
        sta $dae8,x
        inx
        bne clear
        rts
;---------------------------------------
