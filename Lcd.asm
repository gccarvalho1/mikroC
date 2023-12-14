
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Lcd.mpas,35 :: 		begin
;Lcd.mpas,36 :: 		PIR1.RCIF:=0;
	BCF        PIR1+0, 5
;Lcd.mpas,37 :: 		PIR1.TMR1IF:=0;
	BCF        PIR1+0, 0
;Lcd.mpas,39 :: 		for g:= 0 to 49 do
	CLRF       _g+0
L__interrupt2:
;Lcd.mpas,41 :: 		mov[g]:= ADC_Read(0);
	MOVF       _g+0, 0
	ADDLW      _mov+0
	MOVWF      FLOC__interrupt+0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       FLOC__interrupt+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Lcd.mpas,42 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L__interrupt6:
	DECFSZ     R13+0, 1
	GOTO       L__interrupt6
	DECFSZ     R12+0, 1
	GOTO       L__interrupt6
	NOP
	NOP
;Lcd.mpas,43 :: 		end;
	MOVF       _g+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt5
	INCF       _g+0, 1
	GOTO       L__interrupt2
L__interrupt5:
;Lcd.mpas,44 :: 		end;
L_end_interrupt:
L__interrupt24:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Lcd.mpas,46 :: 		begin
;Lcd.mpas,49 :: 		txt1 := 'Terceiro Trabalho';
	MOVLW      84
	MOVWF      _txt1+0
	MOVLW      101
	MOVWF      _txt1+1
	MOVLW      114
	MOVWF      _txt1+2
	MOVLW      99
	MOVWF      _txt1+3
	MOVLW      101
	MOVWF      _txt1+4
	MOVLW      105
	MOVWF      _txt1+5
	MOVLW      114
	MOVWF      _txt1+6
	MOVLW      111
	MOVWF      _txt1+7
	MOVLW      32
	MOVWF      _txt1+8
	MOVLW      84
	MOVWF      _txt1+9
	MOVLW      114
	MOVWF      _txt1+10
	MOVLW      97
	MOVWF      _txt1+11
	MOVLW      98
	MOVWF      _txt1+12
	MOVLW      97
	MOVWF      _txt1+13
	MOVLW      108
	MOVWF      _txt1+14
	MOVLW      104
	MOVWF      _txt1+15
	MOVLW      111
	MOVWF      _txt1+16
	CLRF       _txt1+17
;Lcd.mpas,50 :: 		txt2 := 'MicroControlador';
	MOVLW      77
	MOVWF      _txt2+0
	MOVLW      105
	MOVWF      _txt2+1
	MOVLW      99
	MOVWF      _txt2+2
	MOVLW      114
	MOVWF      _txt2+3
	MOVLW      111
	MOVWF      _txt2+4
	MOVLW      67
	MOVWF      _txt2+5
	MOVLW      111
	MOVWF      _txt2+6
	MOVLW      110
	MOVWF      _txt2+7
	MOVLW      116
	MOVWF      _txt2+8
	MOVLW      114
	MOVWF      _txt2+9
	MOVLW      111
	MOVWF      _txt2+10
	MOVLW      108
	MOVWF      _txt2+11
	MOVLW      97
	MOVWF      _txt2+12
	MOVLW      100
	MOVWF      _txt2+13
	MOVLW      111
	MOVWF      _txt2+14
	MOVLW      114
	MOVWF      _txt2+15
	CLRF       _txt2+16
;Lcd.mpas,51 :: 		txt3 := '';
	CLRF       _txt3+0
;Lcd.mpas,52 :: 		txt4 := 'Exemplo';
	MOVLW      69
	MOVWF      _txt4+0
	MOVLW      120
	MOVWF      _txt4+1
	MOVLW      101
	MOVWF      _txt4+2
	MOVLW      109
	MOVWF      _txt4+3
	MOVLW      112
	MOVWF      _txt4+4
	MOVLW      108
	MOVWF      _txt4+5
	MOVLW      111
	MOVWF      _txt4+6
	CLRF       _txt4+7
;Lcd.mpas,54 :: 		PWM1_Init(5000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Lcd.mpas,55 :: 		j:= 0;
	CLRF       _j+0
;Lcd.mpas,56 :: 		i:= 0;
	CLRF       _i+0
;Lcd.mpas,57 :: 		TRISC :=0;
	CLRF       TRISC+0
;Lcd.mpas,58 :: 		PORTC := %00000000;
	CLRF       PORTC+0
;Lcd.mpas,59 :: 		ADC_Init();
	CALL       _ADC_Init+0
;Lcd.mpas,60 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Lcd.mpas,61 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;Lcd.mpas,62 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lcd.mpas,63 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lcd.mpas,64 :: 		LCD_Out(1,6,txt3);                 // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lcd.mpas,65 :: 		LCD_Out(2,6,txt4);                 // Write text in second row
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt4+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lcd.mpas,66 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L__main8:
	DECFSZ     R13+0, 1
	GOTO       L__main8
	DECFSZ     R12+0, 1
	GOTO       L__main8
	DECFSZ     R11+0, 1
	GOTO       L__main8
	NOP
;Lcd.mpas,67 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lcd.mpas,69 :: 		LCD_Out(1,1,txt1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lcd.mpas,70 :: 		Delay_ms(2000);                 // Write text in first row
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L__main9:
	DECFSZ     R13+0, 1
	GOTO       L__main9
	DECFSZ     R12+0, 1
	GOTO       L__main9
	DECFSZ     R11+0, 1
	GOTO       L__main9
	NOP
;Lcd.mpas,71 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lcd.mpas,73 :: 		TRISB :=0;
	CLRF       TRISB+0
;Lcd.mpas,74 :: 		PORTB := %00000000;
	CLRF       PORTB+0
;Lcd.mpas,75 :: 		g:= 0;
	CLRF       _g+0
;Lcd.mpas,79 :: 		INTCON.GIE:=1;
	BSF        INTCON+0, 7
;Lcd.mpas,80 :: 		INTCON.PEIE:=1;
	BSF        INTCON+0, 6
;Lcd.mpas,81 :: 		PIE1.RCIE:=1;
	BSF        PIE1+0, 5
;Lcd.mpas,82 :: 		TMR1H := 0;
	CLRF       TMR1H+0
;Lcd.mpas,83 :: 		TMR1L := 0;
	CLRF       TMR1L+0
;Lcd.mpas,84 :: 		T1CON := 0;
	CLRF       T1CON+0
;Lcd.mpas,87 :: 		while TRUE do                      // Endless loop
L__main11:
;Lcd.mpas,89 :: 		LCD_Out(2,1,txt2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lcd.mpas,90 :: 		i:= UART1_Read;
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _i+0
;Lcd.mpas,91 :: 		if i='L' then
	MOVF       R0+0, 0
	XORLW      76
	BTFSS      STATUS+0, 2
	GOTO       L__main16
;Lcd.mpas,93 :: 		for j:= 0 to 49 do
	CLRF       _j+0
L__main19:
;Lcd.mpas,95 :: 		bytetostr(j, txt1);
	MOVF       _j+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt1+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;Lcd.mpas,96 :: 		LCD_Out(1,1, txt1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lcd.mpas,97 :: 		UART1_Write(mov[j]);
	MOVF       _j+0, 0
	ADDLW      _mov+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Lcd.mpas,98 :: 		end;
	MOVF       _j+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L__main22
	INCF       _j+0, 1
	GOTO       L__main19
L__main22:
;Lcd.mpas,99 :: 		end;
L__main16:
;Lcd.mpas,100 :: 		end;
	GOTO       L__main11
;Lcd.mpas,101 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
