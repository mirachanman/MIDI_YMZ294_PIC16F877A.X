;*******************************************************************************
;
;   Filename:
;   Date:           SEP.18.2021
;   Latest Date:    Jan.22.2022
;   File Version:   0.4
;   Author:	    mira721
;   Description:
;   Encoding:	    SHIFT-JIS
;   
;   Pin assignment between PIC16F877A to YMZ294 
;   RD7 = WR
;   RD6 = CS (should mean the chip selector)
;   RD5 = A0
;   RE0 = Reset (keep this pin high)
;   RB0 = D0
;   RB1 = D1
;   RB2 = D2
;   RB3 = D3
;   RB4 = D4
;   RB5 = D5
;   RB6 = D6
;   RB7 = D7
;   
;*******************************************************************************
    LIST     P=PIC16F877A
    INCLUDE  P16F877A.INC
    __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF

;define

;data escaping
W_TEMP	    equ 0x6d
STATUS_TEMP equ 0x6e
PCLATH_TEMP equ 0x6f

LN_ONE_BEFORE equ 0x73
LN_STATUS equ 0x74
YMZ_LN_ADRESS equ 0x75
DELAYTIME1  equ 0x76
DELAYTIME2  equ 0x77
YMZ_ADDRESS equ 0x78
YMZ_DATA    equ 0x79
MIDI_FLAGS equ 0x7a
;bit discription
;-7-6-5-4-3-2-1-0(LSB)
;-0-0-0-0-0-0-0-0-:stand-by
;-0-0-0-0-0-0-0-1-:getting 0x90
;-0-0-0-1-0-0-0-0-:getting 0x80

;To avoid confusion with a MIDI channel,
;the YMZ channel is labeled 'Lane' A,B and C
;CH-0 -> MIDI piano
;CH-9 -> MIDI drum
;Lane-A -> a YMZ294 channel
;Lane-B -> a YMZ294 channel
;Lane-C -> a YMZ294 channel
 
RX_DATA	    equ 0x7b	;UART RX data
RX_DATA_SCALE equ 0x7c  ;converted to the scale address
LN_A_VALUE equ 0x7d  ;just MIDI 8bit
LN_B_VALUE equ 0x7e  ;
LN_C_VALUE equ 0x7f  ;
	    
FSR_ADDRESS equ 0xed	;Bank1 ;is it required?
SCALE_TEMP  equ 0xee	;Bank1
COUNT_NUM   equ 0xef	;Bank1
   
;scale data Bank0 and Bank1
SC_L_E1	    equ 0x20
SC_H_E1	    equ 0xa0
SC_L_F1	    equ 0x21
SC_H_F1	    equ 0xa1	    
SC_L_F1sh   equ 0x22
SC_H_F1sh   equ 0xa2
SC_L_G1	    equ 0x23
SC_H_G1	    equ 0xa3
SC_L_G1sh   equ 0x24
SC_H_G1sh   equ 0xa4
SC_L_A1	    equ 0x25
SC_H_A1	    equ 0xa5
SC_L_A1sh   equ 0x26
SC_H_A1sh   equ 0xa6
SC_L_B1	    equ 0x27
SC_H_B1	    equ 0xa7

SC_L_C2	    equ 0x28
SC_H_C2	    equ 0xa8
SC_L_C2sh   equ 0x29
SC_H_C2sh   equ 0xa9
SC_L_D2	    equ 0x2a
SC_H_D2	    equ 0xaa
SC_L_D2sh   equ 0x2b
SC_H_D2sh   equ 0xab
SC_L_E2	    equ 0x2c
SC_H_E2	    equ 0xac
SC_L_F2	    equ 0x2d
SC_H_F2	    equ 0xad	    
SC_L_F2sh   equ 0x2e
SC_H_F2sh   equ 0xae
SC_L_G2	    equ 0x2f
SC_H_G2	    equ 0xaf
SC_L_G2sh   equ 0x30
SC_H_G2sh   equ 0xb0
SC_L_A2	    equ 0x31
SC_H_A2	    equ 0xb1
SC_L_A2sh   equ 0x32
SC_H_A2sh   equ 0xb2
SC_L_B2	    equ 0x33
SC_H_B2	    equ 0xb3

SC_L_C3	    equ 0x34
SC_H_C3	    equ 0xb4
SC_L_C3sh   equ 0x35
SC_H_C3sh   equ 0xb5
SC_L_D3	    equ 0x36
SC_H_D3	    equ 0xb6
SC_L_D3sh   equ 0x37
SC_H_D3sh   equ 0xb7
SC_L_E3	    equ 0x38
SC_H_E3	    equ 0xb8
SC_L_F3	    equ 0x39
SC_H_F3	    equ 0xb9
SC_L_F3sh   equ 0x3a
SC_H_F3sh   equ 0xba
SC_L_G3	    equ 0x3b
SC_H_G3	    equ 0xbb
SC_L_G3sh   equ 0x3c
SC_H_G3sh   equ 0xbc
SC_L_A3	    equ 0x3d
SC_H_A3	    equ 0xbd
SC_L_A3sh   equ 0x3e
SC_H_A3sh   equ 0xbe
SC_L_B3	    equ 0x3f
SC_H_B3	    equ 0xbf

SC_L_C4	    equ 0x40
SC_H_C4	    equ 0xc0
SC_L_C4sh   equ 0x41
SC_H_C4sh   equ 0xc1
SC_L_D4	    equ 0x42
SC_H_D4	    equ 0xc2
SC_L_D4sh   equ 0x43
SC_H_D4sh   equ 0xc3
SC_L_E4	    equ 0x44
SC_H_E4	    equ 0xc4
SC_L_F4	    equ 0x45
SC_H_F4	    equ 0xc5
SC_L_F4sh   equ 0x46
SC_H_F4sh   equ 0xc6
SC_L_G4	    equ 0x47
SC_H_G4	    equ 0xc7
SC_L_G4sh   equ 0x48
SC_H_G4sh   equ 0xc8
SC_L_A4	    equ 0x49
SC_H_A4	    equ 0xc9
SC_L_A4sh   equ 0x4a
SC_H_A4sh   equ 0xca
SC_L_B4	    equ 0x4b
SC_H_B4	    equ 0xcb

SC_L_C5	    equ 0x4c
SC_H_C5	    equ 0xcc
SC_L_C5sh   equ 0x4d
SC_H_C5sh   equ 0xcd
SC_L_D5	    equ 0x4e
SC_H_D5	    equ 0xce
SC_L_D5sh   equ 0x4f
SC_H_D5sh   equ 0xcf
SC_L_E5	    equ 0x50
SC_H_E5	    equ 0xd0
SC_L_F5	    equ 0x51
SC_H_F5	    equ 0xd1
SC_L_F5sh   equ 0x52
SC_H_F5sh   equ 0xd2
SC_L_G5	    equ 0x53
SC_H_G5	    equ 0xd3
SC_L_G5sh   equ 0x54
SC_H_G5sh   equ 0xd4
SC_L_A5	    equ 0x55
SC_H_A5	    equ 0xd5
SC_L_A5sh   equ 0x56
SC_H_A5sh   equ 0xd6
SC_L_B5	    equ 0x57
SC_H_B5	    equ 0xd7

SC_L_C6	    equ 0x58
SC_H_C6	    equ 0xd8
SC_L_C6sh   equ 0x59
SC_H_C6sh   equ 0xd9
SC_L_D6	    equ 0x5a
SC_H_D6	    equ 0xda
SC_L_D6sh   equ 0x5b
SC_H_D6sh   equ 0xdb
SC_L_E6	    equ 0x5c
SC_H_E6	    equ 0xdc
SC_L_F6	    equ 0x5d
SC_H_F6	    equ 0xdd
SC_L_F6sh   equ 0x5e
SC_H_F6sh   equ 0xde
SC_L_G6	    equ 0x5f
SC_H_G6	    equ 0xdf
SC_L_G6sh   equ 0x60
SC_H_G6sh   equ 0xe0
SC_L_A6	    equ 0x61
SC_H_A6	    equ 0xe1
SC_L_A6sh   equ 0x62
SC_H_A6sh   equ 0xe2
SC_L_B6	    equ 0x63
SC_H_B6	    equ 0xe3

SC_L_C7	    equ 0x64
SC_H_C7	    equ 0xe4
SC_L_C7sh   equ 0x65
SC_H_C7sh   equ 0xe5
SC_L_D7	    equ 0x66
SC_H_D7	    equ 0xe6
SC_L_D7sh   equ 0x67
SC_H_D7sh   equ 0xe7
SC_L_E7	    equ 0x68
SC_H_E7	    equ 0xe8
SC_L_F7	    equ 0x69
SC_H_F7	    equ 0xe9
SC_L_F7sh   equ 0x6a
SC_H_F7sh   equ 0xea
SC_L_G7	    equ 0x6b
SC_H_G7	    equ 0xeb

;End define 
    
    ORG 0			;start memory	
    GOTO    START		;go to beginning of program

    ORG 0x4
    movwf W_TEMP
    swapf STATUS,w
    clrf STATUS
    movwf STATUS_TEMP
    movfw PCLATH
    movwf PCLATH_TEMP
    clrf PCLATH
    ;interrupt lootine here
    
    bcf STATUS, RP0		;Bank0
    bcf STATUS, RP1		;Bank0   
    
    movlw B'00000110'
    xorwf PORTE

    ;goto END_INTERRUPTION
    ;;;Start decodeing MIDI here   
MIDI_DECODE
    movf RCREG,w			;load the data if get something
    movwf RX_DATA		;save the data
    btfsc RCSTA, OERR		;if detect overrun error
    goto C_ERROR		;ignore the error
    
    ;--Modes--;
    
    ;Branch 1: idle
    movlw 0xfe
    subwf RX_DATA,w
    btfsc STATUS,Z  ;if Z=0,skip next order (skip next if TMPis not equal 0xfe)
    goto END_INTERRUPTION

    ;Branch 2: get 0x90 (means note on)
NOTE_ON_MODE
    movlw 0x90
    subwf RX_DATA,w ;see if RX_DATA matches to 0x90
    btfss STATUS,Z
    goto NOTE_OFF_MODE
NOTE_ON_FLAG
    clrf MIDI_FLAGS
    bsf MIDI_FLAGS,0 
    goto END_INTERRUPTION

    ;Branch 3: get 0x80,(0xNN,0x40)
NOTE_OFF_MODE
    movlw 0x80
    subwf RX_DATA,w
    btfss STATUS,Z  ;if Z=0(TMPis not equal 0x90),skip next order
    goto NEXT_LABEL;;tentative;;
NOTE_OFF_FLAG
    clrf MIDI_FLAGS
    bsf MIDI_FLAGS,4
    goto END_INTERRUPTION
    
    
NEXT_LABEL;;tentative;;
    
    ;--Flags--;
NOTE_ON_FLAG_CHECK;Branch 2-1: get the scale and input
    btfss MIDI_FLAGS,0
    goto NOTE_OFF_CHECK;3-1
INPUT_NOTE
    btfsc MIDI_FLAGS,1
    goto VOL_ON_FLAG_CHECK;if this flag is 1, goto 2-3
    bsf MIDI_FLAGS,1
CHECK_LN_A;Branch 2-2-1
    btfsc LN_STATUS,0
    goto CHECK_LN_A
    movf RX_DATA,w
    movwf LN_A_VALUE
    movlw B'00000000'
    movwf YMZ_ADDRESS
    call WRITE_YMZ
    bsf LN_STATUS,0
    bsf LN_ONE_BEFORE,0
    goto END_INTERRUPTION
CHECK_LN_A;Branch 2-2-2
    btfsc LN_STATUS,1
    goto CHECK_LN_A
    movf RX_DATA,w
    movwf LN_B_VALUE
    movlw B'00000010'
    movwf YMZ_ADDRESS
    call WRITE_YMZ
    bsf LN_STATUS,1
    bsf LN_ONE_BEFORE,1
    goto END_INTERRUPTION
CHECK_LN_A;Branch 2-2-3
    btfsc LN_STATUS,2
    goto END_INTERRUPTION;;;tentative;;;
    movf RX_DATA,w
    movwf LN_C_VALUE
    movlw B'00000100'
    movwf YMZ_ADDRESS
    call WRITE_YMZ
    bsf LN_STATUS,2
    bsf LN_ONE_BEFORE,2
    goto END_INTERRUPTION
    
VOL_ON_FLAG_CHECK;Branch 2-3: Volume on
    btfss MIDI_FLAGS,0
    goto END_INTERRUPTION;goto ERROR_END;;tentative;;
INPUT_VOLUME    
    btfss MIDI_FLAGS,1
    goto NOTE_OFF_CHECK
    bcf MIDI_FLAGS,1
VOL_ON_LN_A;Branch 2-3-1
    btfss LN_ONE_BEFORE,0
    goto VOL_ON_LN_B
    movlw B'00001000';08
    movwf YMZ_ADDRESS
    movlw B'00001100'
    movwf YMZ_DATA
    call SET_YMZ_REG
    clrf LN_ONE_BEFORE
    clrf RX_DATA
    goto END_INTERRUPTION
VOL_ON_LN_B;Branch 2-3-2
    btfss LN_ONE_BEFORE,1
    goto VOL_ON_LN_C
    movlw B'00001001';09
    movwf YMZ_ADDRESS
    movlw B'00001100'
    movwf YMZ_DATA
    ;call WAITMS
    call SET_YMZ_REG
    clrf LN_ONE_BEFORE
    clrf RX_DATA
    goto END_INTERRUPTION
VOL_ON_LN_C;Branch 2-3-3
    btfss LN_ONE_BEFORE,2
    goto NOTE_OFF_CHECK;;tentative
    movlw B'00001010';0a
    movwf YMZ_ADDRESS
    movlw B'00001100'
    movwf YMZ_DATA
    ;call WAITMS
    call SET_YMZ_REG
    clrf LN_ONE_BEFORE
    clrf RX_DATA
    goto END_INTERRUPTION


    ;Branch 3 get (0x80),0xNN,(0x40)
NOTE_OFF_CHECK;3-1
    btfss MIDI_FLAGS,4
    goto NOTE_OFF_END;goto ERROR_END;;tentative;;
    btfsc MIDI_FLAGS,5
    goto NOTE_OFF_END;goto ERROR_END;;tentative;;
CHECK_CURRENT_LN_A;Branch 3-2-1
    movf LN_A_VALUE,w
    subwf RX_DATA,w
    btfss STATUS,Z
    goto CHECK_CURRENT_LN_B
    movlw B'00001000'
    movwf YMZ_ADDRESS
    movlw B'00000000'
    movwf YMZ_DATA
    call SET_YMZ_REG
    bcf LN_STATUS,0
    bsf MIDI_FLAGS,5
    clrf LN_A_VALUE
    goto END_INTERRUPTION
CHECK_CURRENT_LN_B;Branch 3-2-2
    movf LN_B_VALUE,w
    subwf RX_DATA,w
    btfss STATUS,Z
    goto CHECK_CURRENT_LN_C
    movlw B'00001001'
    movwf YMZ_ADDRESS
    movlw B'00000000'
    movwf YMZ_DATA
    call SET_YMZ_REG
    bcf LN_STATUS,1
    bsf MIDI_FLAGS,5
    clrf LN_B_VALUE
    goto END_INTERRUPTION
CHECK_CURRENT_LN_C;Branch 3-2-3
    movf LN_C_VALUE,w
    subwf RX_DATA,w
    btfss STATUS,Z
    goto NOTE_OFF_END
    movlw B'00001010'
    movwf YMZ_ADDRESS
    movlw B'00000000'
    movwf YMZ_DATA
    call SET_YMZ_REG
    bcf LN_STATUS,2
    bsf MIDI_FLAGS,5
    clrf LN_C_VALUE
    goto END_INTERRUPTION
    
    ;Branch 3-3: get (0x80,0xNN),Final0x40
NOTE_OFF_END
    ;btfss MIDI_FLAGS,5
    ;goto END_INTERRUPTION;;tentative;;
    bcf MIDI_FLAGS,5
    goto END_INTERRUPTION
    
C_ERROR;Branch ERROR_01
    bcf RCSTA, CREN
    bcf RCSTA, CREN
    goto END_INTERRUPTION
    ;just clear an error, then go back to loop
    
    ;--functions below--

WRITE_YMZ:;
    movlw 0x04
    addwf RX_DATA,w	;Convert to the file resister address
    movwf RX_DATA_SCALE;and save the value to RX_DATA_SCALE
    movwf FSR		;input the file reg address
    movf INDF,w		;get the scale data (lower 8bit)
    movwf YMZ_DATA
    ;movf YMZ_LN_ADRESS,w
    ;movwf YMZ_ADDRESS
    call SET_YMZ_REG

    movlw 0x80
    addwf RX_DATA_SCALE,w	;??
    movwf RX_DATA_SCALE		;can be deleted
    bsf STATUS, RP0		;Bank1
    movwf FSR		;input the file reg address
    movf INDF,w		;get the scale data (higher 8bit)
    bcf STATUS, RP0		;Bank0   
    movwf YMZ_DATA	

    incf YMZ_ADDRESS,f
    call SET_YMZ_REG
    return

VOL_ON:
    movlw B'00001111';envelope disable, volume max
    movwf YMZ_DATA
    call SET_YMZ_REG    

    return

VOL_OFF:
    ;control the volume
    movlw B'00000000'
    movwf YMZ_DATA
    call SET_YMZ_REG

    return
    
;;;DONE MIDI WORKING;;;

;function to write the data into ymz294
SET_YMZ_REG:
    BCF STATUS, RP0
    BCF STATUS, RP1		;Set STATUS Bank0
    nop
    ;   RD7 = WR
    ;   RD6 = CS (should mean chip selector)
    ;   RD5 = A0
    movlw B'00000000'
    movwf PORTD		    ; WR:LOW, CS:LOW, A0:LOW
    nop

    movf YMZ_ADDRESS,w
    movwf PORTB		    ; set the address
    nop
    
    movlw B'11000000'
    movwf PORTD		    ; WR:HIGH, CS:HIGH, A0:LOW
    nop
    
    movlw B'00100000'
    movwf PORTD		    ;
    nop
    
    movf YMZ_DATA,w
    movwf PORTB		    ;
    nop
    
    movlw B'11100000'
    movwf PORTD		    ;

    return

ERROR_END;;tentative;; ;Branch ERROR_02
    clrf LN_STATUS
    clrf YMZ_LN_ADRESS
    clrf YMZ_ADDRESS
    clrf YMZ_DATA
    clrf MIDI_FLAGS
    clrf RX_DATA
    clrf RX_DATA_SCALE
    clrf LN_A_VALUE
    clrf LN_B_VALUE
    clrf LN_C_VALUE
    
END_INTERRUPTION
    ;end interruption
    movfw PCLATH_TEMP
    movwf PCLATH
    swapf STATUS_TEMP,w
    movwf STATUS
    clrf STATUS
    swapf W_TEMP,f
    swapf W_TEMP,w
    
    retfie

;-- initalization --
START
    ;-- Bank0 clearing PORT--
    BCF STATUS, RP0
    BCF STATUS, RP1		;Set STATUS Bank0
    
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE			;clear the resistor before the initalization
    
    ;-- Bank0 UART settings --
    bsf PIR1, RCIF
    movlw B'10010000' 
    movwf RCSTA			;configure RX

    ;-- Bank1 I/O PORT settings --
    BSF STATUS, RP0		;Bank1
    
    CLRF TRISA			;set PORTA output
    CLRF TRISB			;set PORTB output
    CLRF TRISD			;set PORTD output
    CLRF TRISE			;set PORTE output
    movlw B'10000000'
    movwf TRISC			;set PORTC output except RX
    
    ;-- Bank1 ADCON1 (in order to use PORTE) --
    movlw B'00000110'
    movwf ADCON1
    
    ;-- Bank1 UART --
    movlw D'31'			;at 16MHz, BRGH=1(multi16),SYNC=0, baud=31250
    movwf SPBRG			;configure Baud rate
    movlw B'00000110'
    movwf TXSTA			;configure TX
    
    ;-- Scale initalization --
SCALE_INIT
    bcf STATUS, RP0		;Bank0
    
    ;Bank0 lower 8bits
    ;movlw B'11101110'
    ;movwf SC_L_C1
    ;32.7Hz Ac:70.4
    ;movlw B'00011000'
    ;movwf SC_L_C1sh
    ;34.6Hz Ac:32.4
    ;movlw B'01001101'
    ;movwf SC_L_D1
    ;36.7Hz
    ;movlw B'10001110'
    ;movwf SC_L_D1sh
    ;36.7Hz
    movlw B'11011010'
    movwf SC_L_E1
    ;41.2Hz
    movlw B'00101111'
    movwf SC_L_F1
    ;43.7Hz
    movlw B'10001111'
    movwf SC_L_F1sh
    ;46.2Hz
    movlw B'11110111'
    movwf SC_L_G1
    ;49.0Hz
    movlw B'01101000'
    movwf SC_L_G1sh
    ;51.9Hz
    movlw B'11100001'
    movwf SC_L_A1
    ;55.0Hz
    movlw B'01100001'
    movwf SC_L_A1sh
    ;58.3Hz
    movlw B'11101001'
    movwf SC_L_B1
    ;61.7Hz
    movlw B'01110111'
    movwf SC_L_C2
    ;65.4Hz
    movlw B'00001100'
    movwf SC_L_C2sh
    ;69.3Hz
    movlw B'10100111'
    movwf SC_L_D2
    ;73.4Hz
    movlw B'01000111'
    movwf SC_L_D2sh
    ;77.8Hz
    movlw B'11101101'
    movwf SC_L_E2
    ;82.4Hz
    movlw B'10011000'
    movwf SC_L_F2
    ;87.3Hz
    movlw B'01000111'
    movwf SC_L_F2sh
    ;92.5Hz
    movlw B'11111100'
    movwf SC_L_G2
    ;98.0Hz
    movlw B'10110100'
    movwf SC_L_G2sh
    ;103Hz
    movlw B'01101111'
    movwf SC_L_A2
    ;110Hz
    movlw B'00110010'
    movwf SC_L_A2sh
    ;116Hz
    movlw B'11110100'
    movwf SC_L_B2
    ;123Hz
    movlw B'10111100'
    movwf SC_L_C3
    ;131Hz
    movlw B'10000110'
    movwf SC_L_C3sh
    ;139Hz
    movlw B'01010011'
    movwf SC_L_D3
    ;147Hz
    movlw B'00100100'
    movwf SC_L_D3sh
    ;155Hz
    movlw B'11110110'
    movwf SC_L_E3
    ;165Hz
    movlw B'11001100'
    movwf SC_L_F3
    ;175Hz
    movlw B'10100100'
    movwf SC_L_F3sh
    ;185Hz
    movlw B'01111110'
    movwf SC_L_G3
    ;196Hz
    movlw B'01011010'
    movwf SC_L_G3sh
    ;196Hz
    movlw B'00111000'
    movwf SC_L_A3
    ;220Hz
    movlw B'00011000'
    movwf SC_L_A3sh
    ;233Hz
    movlw B'11111010'
    movwf SC_L_B3
    ;247Hz
    movlw B'11011110'
    movwf SC_L_C4
    ;261Hz
    movlw B'11000011'
    movwf SC_L_C4sh
    ;Hz
    movlw B'10101010'
    movwf SC_L_D4
    ;Hz
    movlw B'10010010'
    movwf SC_L_D4sh
    ;Hz
    movlw B'01111011'
    movwf SC_L_E4
    ;Hz
    movlw B'01100110'
    movwf SC_L_F4
    ;Hz
    movlw B'01010010'
    movwf SC_L_F4sh
    ;Hz
    movlw B'00111111'
    movwf SC_L_G4
    ;Hz
    movlw B'00101101'
    movwf SC_L_G4sh
    ;Hz
    movlw B'00011100'
    movwf SC_L_A4
    ;Hz
    movlw B'00001100'
    movwf SC_L_A4sh
    ;Hz
    movlw B'11111101'
    movwf SC_L_B4
    ;Hz
    movlw B'11101111'
    movwf SC_L_C5
    ;Hz
    
    movlw B'11100001'
    movwf SC_L_C5sh
    ;Hz
    movlw B'11010101'
    movwf SC_L_D5
    ;Hz
    movlw B'11001001'
    movwf SC_L_D5sh
    ;Hz
    movlw B'10111110'
    movwf SC_L_E5
    ;Hz
    movlw B'10110011';
    movwf SC_L_F5
    ;Hz
    movlw B'10101001'
    movwf SC_L_F5sh
    ;Hz
    movlw B'10100000'
    movwf SC_L_G5
    ;Hz
    movlw B'10010111'
    movwf SC_L_G5sh
    ;Hz
    movlw B'10001110'
    movwf SC_L_A5
    ;880Hz, 826 sq
    movlw B'10000110'
    movwf SC_L_A5sh
    ;932.8Hz, 925Hz Sq
    movlw B'01111111'
    movwf SC_L_B5
    ;984Hz, 970.1Hz sq
    movlw B'01111000'
    movwf SC_L_C6
    ;1042Hz, 1031Hz sq
    
    movlw B'01110010'
    movwf SC_L_C6sh		;Hz
    movlw B'01101010'
    movwf SC_L_D6		;Hz
    movlw B'01100100'
    movwf SC_L_D6sh		;Hz
    movlw B'01011111'
    movwf SC_L_E6		;Hz
    movlw B'01011010'
    movwf SC_L_F6		;Hz
    movlw B'01010101'
    movwf SC_L_F6sh		;Hz
    movlw B'01001111'
    movwf SC_L_G6		;Hz
    movlw B'01001011'
    movwf SC_L_G6sh		;Hz
    movlw B'01000111'
    movwf SC_L_A6		;Hz
    movlw B'01000011'
    movwf SC_L_A6sh		;Hz
    movlw B'00111111'
    movwf SC_L_B6		;Hz
    movlw B'00111100'
    movwf SC_L_C7		;Hz
    movlw B'00111000'
    movwf SC_L_C7sh		;Hz
    movlw B'00110101'
    movwf SC_L_D7		;Hz
    movlw B'00110010'
    movwf SC_L_D7sh		;Hz
    movlw B'00101111'
    movwf SC_L_E7		;Hz
    movlw B'00101100'
    movwf SC_L_F7		;Hz
    movlw B'00101010'
    movwf SC_L_F7sh		;Hz ??
    
    bsf STATUS, RP0		;Bank1    
    ;Bank1 higher 4bits
    ;movlw B'00001110'
    ;movwf SC_H_C1		;32.7Hz
    ;movlw B'00001110'
    ;movwf SC_H_C1sh		;34.6Hz
    ;movlw B'00001101'
    ;movwf SC_H_D1		;36.7Hz
    ;movlw B'00001100'
    ;movwf SC_H_D1sh		;36.7Hz
    
    movlw B'00001011'
    movwf SC_H_E1		;41.2Hz
    movlw B'00001011'
    movwf SC_H_F1		;43.7Hz
    movlw B'00001010'
    movwf SC_H_F1sh		;46.2Hz
    movlw B'00001001'
    movwf SC_H_G1		;49.0Hz
    movlw B'00001001'
    movwf SC_H_G1sh		;51.9Hz
    movlw B'00001000'
    movwf SC_H_A1		;55.0Hz
    movlw B'00001000'
    movwf SC_H_A1sh		;58.3Hz
    movlw B'00000111'
    movwf SC_H_B1		;61.7Hz
    movlw B'00000111'
    movwf SC_H_C2		;65.4Hz
    movlw B'00000111'
    movwf SC_H_C2sh		;69.3Hz
    movlw B'00000110'
    movwf SC_H_D2		;73.4Hz
    movlw B'00000110'
    movwf SC_H_D2sh		;77.8Hz
    movlw B'00000101'
    movwf SC_H_E2		;82.4Hz
    movlw B'00000101'
    movwf SC_H_F2		;87.3Hz
    movlw B'00000101'
    movwf SC_H_F2sh		;92.5Hz
    movlw B'00000100'
    movwf SC_H_G2		;98.0Hz
    movlw B'00000100'
    movwf SC_H_G2sh		;103Hz
    movlw B'00000100'
    movwf SC_H_A2		;110Hz
    movlw B'00000100'
    movwf SC_H_A2sh		;116Hz    

B2toD3sh;mikansei
    movlw B'00000011'
    movwf SCALE_TEMP
    movlw SC_H_B2
    movwf FSR_ADDRESS
    movlw D'5'
    movwf COUNT_NUM
    call WRITE_FSR

E3toA3sh;mikansei
    movlw B'00000010'
    movwf SCALE_TEMP
    movlw D'7'
    movwf COUNT_NUM
    call WRITE_FSR
    
B3toA4sh;mikansei
    movlw B'00000001'
    movwf SCALE_TEMP
    movlw D'12'
    movwf COUNT_NUM
    call WRITE_FSR

B4toE7;mikansei
    movlw B'00000000'
    movwf SCALE_TEMP
    movlw D'30'
    movwf COUNT_NUM
    call WRITE_FSR
    
; end scale info
    goto YMZ_SETTINGS
    
WRITE_FSR:;mikansei
    movf FSR_ADDRESS,w
    movwf FSR
    movf SCALE_TEMP,w
    movwf INDF
    incf FSR_ADDRESS,f
    decfsz COUNT_NUM,f
    goto WRITE_FSR
    return

;INIT YMZ channel/volume settings (preliminary)
YMZ_SETTINGS;mikansei
    bcf STATUS, RP0		;Bank0
    bcf STATUS, RP1		;Bank0
    
    movlw B'00000011'
    movwf PORTE
    ;mixer  
    movlw B'00000111';07
    movwf YMZ_ADDRESS
    movlw B'00111000';tone enable (1 means disable)
    movwf YMZ_DATA
    call SET_YMZ_REG
    
    ;vol CH-A zero
    movlw B'00001000';08(CH-A)
    movwf YMZ_ADDRESS
    movlw B'00000000'
    movwf YMZ_DATA
    call SET_YMZ_REG
    
    ;vol CH-B zero
    movlw B'00001001';09(CH_B)
    movwf YMZ_ADDRESS
    movlw B'00000000'
    movwf YMZ_DATA
    call SET_YMZ_REG
    
    ;vol CH-C zero
    movlw B'00001001';10(CH_C)
    movwf YMZ_ADDRESS
    movlw B'00000000'
    movwf YMZ_DATA
    call SET_YMZ_REG
    
    ;envelope settings
    movlw B'00001011';0B
    movwf YMZ_ADDRESS
    movlw B'10000000';
    movwf YMZ_DATA
    call SET_YMZ_REG
    
    movlw B'00001100';0C
    movwf YMZ_ADDRESS
    movlw B'00000010';
    movwf YMZ_DATA
    call SET_YMZ_REG
    
    movlw B'00001101';0D
    movwf YMZ_ADDRESS
    movlw B'00001010';
    movwf YMZ_DATA
    call SET_YMZ_REG

INTERRUPTION_SETTINGS
    movlw B'11000000'
    movwf INTCON		;enable interruption
    
    bsf STATUS, RP0		;Set STATUS Bank1
    movlw B'00100000'
    movwf PIE1			;enable UART interruption
    bcf STATUS, RP0		;Set STATUS Bank0

;-- done initalization --
DONE_INIT
    clrf LN_STATUS
    clrf YMZ_LN_ADRESS
    clrf YMZ_ADDRESS
    clrf YMZ_DATA
    clrf MIDI_FLAGS
    clrf RX_DATA
    clrf RX_DATA_SCALE
    clrf LN_A_VALUE
    clrf LN_B_VALUE
    clrf LN_C_VALUE

    movlw B'11100000'
    movlw PORTB;;<---is this correct?

;-- main loop --
LOOP
    ;btfss PIR1, RCIF		;check if the device receives some data
    nop
    goto $-1

;-- Functions below--



;function
WAIT20C:
    ;20cycle should be 5us at 4MHz
    goto $+1
    goto $+1
    goto $+1
    goto $+1
    goto $+1
    goto $+1
    goto $+1
    goto $+1
    nop
    nop
    return

;function
WAIT250MS:
    ;close to 250ms
    movlw D'100' 
    movwf DELAYTIME2
DLOOP2:
    call WAITMS
    decfsz DELAYTIME2, f
    goto DLOOP2
    return

;function
WAITMS:
    ;5us * 200 = 1ms
    movlw D'200' 
    movwf DELAYTIME1
DLOOP1:
    call WAIT20C
    decfsz DELAYTIME1, f
    goto DLOOP1
    return
    
    END