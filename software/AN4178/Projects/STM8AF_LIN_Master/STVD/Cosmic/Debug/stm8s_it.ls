   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  19                     	switch	.data
  20  0000               L3_AppliTick:
  21  0000 00            	dc.b	0
  51                     ; 75 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 76 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 80 }
  60  0000 80            	iret	
  82                     ; 88 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 89 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 93 }
  91  0001 80            	iret	
 113                     ; 99 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 100 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 104 }
 122  0002 80            	iret	
 144                     ; 111 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 112 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 116 }
 153  0003 80            	iret	
 175                     ; 123 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 124 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 128 }
 184  0004 80            	iret	
 207                     ; 135 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 136 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 140 }
 216  0005 80            	iret	
 239                     ; 147 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 148 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 152 }
 248  0006 80            	iret	
 271                     ; 159 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 160 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 164 }
 280  0007 80            	iret	
 303                     ; 171 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 172 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 176 }
 312  0008 80            	iret	
 338                     ; 183 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 338                     ; 184 {
 339                     	switch	.text
 340  0009               f_EXTI_PORTE_IRQHandler:
 342  0009 3b0002        	push	c_x+2
 343  000c be00          	ldw	x,c_x
 344  000e 89            	pushw	x
 345  000f 3b0002        	push	c_y+2
 346  0012 be00          	ldw	x,c_y
 347  0014 89            	pushw	x
 350                     ; 186   if (GPIO_ReadInputPin(GPIOE, GPIO_PIN_2) == 0) UserButton1 = TRUE;
 352  0015 4b04          	push	#4
 353  0017 ae5014        	ldw	x,#20500
 354  001a cd0000        	call	_GPIO_ReadInputPin
 356  001d 5b01          	addw	sp,#1
 357  001f 4d            	tnz	a
 358  0020 2604          	jrne	L331
 361  0022 35010000      	mov	_UserButton1,#1
 362  0026               L331:
 363                     ; 187   if (GPIO_ReadInputPin(GPIOE, GPIO_PIN_1) == 0) UserButton2 = TRUE;
 365  0026 4b02          	push	#2
 366  0028 ae5014        	ldw	x,#20500
 367  002b cd0000        	call	_GPIO_ReadInputPin
 369  002e 5b01          	addw	sp,#1
 370  0030 4d            	tnz	a
 371  0031 2604          	jrne	L531
 374  0033 35010000      	mov	_UserButton2,#1
 375  0037               L531:
 376                     ; 189 }
 379  0037 85            	popw	x
 380  0038 bf00          	ldw	c_y,x
 381  003a 320002        	pop	c_y+2
 382  003d 85            	popw	x
 383  003e bf00          	ldw	c_x,x
 384  0040 320002        	pop	c_x+2
 385  0043 80            	iret	
 407                     ; 210 INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
 407                     ; 211 {
 408                     	switch	.text
 409  0044               f_CAN_RX_IRQHandler:
 413                     ; 215 }
 416  0044 80            	iret	
 438                     ; 222 INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
 438                     ; 223 {
 439                     	switch	.text
 440  0045               f_CAN_TX_IRQHandler:
 444                     ; 227 }
 447  0045 80            	iret	
 469                     ; 235 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 469                     ; 236 {
 470                     	switch	.text
 471  0046               f_SPI_IRQHandler:
 475                     ; 240 }
 478  0046 80            	iret	
 501                     ; 247 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 501                     ; 248 {
 502                     	switch	.text
 503  0047               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 507                     ; 252 }
 510  0047 80            	iret	
 533                     ; 259 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 533                     ; 260 {
 534                     	switch	.text
 535  0048               f_TIM1_CAP_COM_IRQHandler:
 539                     ; 264 }
 542  0048 80            	iret	
 565                     ; 296 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 565                     ; 297 {
 566                     	switch	.text
 567  0049               f_TIM2_UPD_OVF_BRK_IRQHandler:
 571                     ; 301 }
 574  0049 80            	iret	
 597                     ; 308 INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 597                     ; 309 {
 598                     	switch	.text
 599  004a               f_TIM2_CAP_COM_IRQHandler:
 603                     ; 313 }
 606  004a 80            	iret	
 629                     ; 323 INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 629                     ; 324 {
 630                     	switch	.text
 631  004b               f_TIM3_UPD_OVF_BRK_IRQHandler:
 635                     ; 328 }
 638  004b 80            	iret	
 661                     ; 335 INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 661                     ; 336 {
 662                     	switch	.text
 663  004c               f_TIM3_CAP_COM_IRQHandler:
 667                     ; 340 }
 670  004c 80            	iret	
 693                     ; 350 INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 693                     ; 351 {
 694                     	switch	.text
 695  004d               f_UART1_TX_IRQHandler:
 699                     ; 355 }
 702  004d 80            	iret	
 725                     ; 362 INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 725                     ; 363 {
 726                     	switch	.text
 727  004e               f_UART1_RX_IRQHandler:
 731                     ; 367 }
 734  004e 80            	iret	
 756                     ; 375 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 756                     ; 376 {
 757                     	switch	.text
 758  004f               f_I2C_IRQHandler:
 762                     ; 380 }
 765  004f 80            	iret	
 788                     ; 414 INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 788                     ; 415 {
 789                     	switch	.text
 790  0050               f_UART3_TX_IRQHandler:
 794                     ; 419 }
 797  0050 80            	iret	
 826                     ; 426 INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
 826                     ; 427 {
 827                     	switch	.text
 828  0051               f_UART3_RX_IRQHandler:
 830  0051 3b0002        	push	c_x+2
 831  0054 be00          	ldw	x,c_x
 832  0056 89            	pushw	x
 833  0057 3b0002        	push	c_y+2
 834  005a be00          	ldw	x,c_y
 837                     ; 431   UART3_SR_Buf = UART3->SR;
 840  005c 5552400000    	mov	_UART3_SR_Buf,21056
 841  0061 89            	pushw	x
 842                     ; 432   UART3Data = UART3->DR;
 844  0062 5552410000    	mov	_UART3Data,21057
 845                     ; 437 	if (UART3->CR4 & UART3_CR4_LBDF)
 847  0067 720952470a    	btjf	21063,#4,L713
 848                     ; 439 		UART3->CR4 &= ~UART3_CR4_LBDF; /* Reset LBDF flag */
 850  006c 72195247      	bres	21063,#4
 851                     ; 440 		BreakReceived = 1;
 853  0070 35010000      	mov	_BreakReceived,#1
 855  0074 2026          	jra	L123
 856  0076               L713:
 857                     ; 445 		if (UART3_SR_Buf & UART3_SR_FE)
 859  0076 720300000b    	btjf	_UART3_SR_Buf,#1,L323
 860                     ; 447 			DataReceived = 1;
 862  007b 35010000      	mov	_DataReceived,#1
 863                     ; 448 			ReceptionError = 1;
 865  007f 35010000      	mov	_ReceptionError,#1
 866                     ; 449 			UART3_BDIE(); /* It can be a Break, wait for next IT...*/
 868  0083 cd0000        	call	_UART3_BDIE
 870  0086               L323:
 871                     ; 453 		if (UART3_SR_Buf & UART3_SR_OR)
 873  0086 7207000008    	btjf	_UART3_SR_Buf,#3,L523
 874                     ; 455 			DataReceived = 1;
 876  008b 35010000      	mov	_DataReceived,#1
 877                     ; 456 			ReceptionError = 1;
 879  008f 35010000      	mov	_ReceptionError,#1
 880  0093               L523:
 881                     ; 460 		if (UART3_SR_Buf & UART3_SR_RXNE)
 883  0093 720b000004    	btjf	_UART3_SR_Buf,#5,L123
 884                     ; 462 			DataReceived = 1;
 886  0098 35010000      	mov	_DataReceived,#1
 887  009c               L123:
 888                     ; 467 }
 892  009c 85            	popw	x
 893  009d bf00          	ldw	c_y,x
 894  009f 320002        	pop	c_y+2
 895  00a2 85            	popw	x
 896  00a3 bf00          	ldw	c_x,x
 897  00a5 320002        	pop	c_x+2
 898  00a8 80            	iret	
 920                     ; 476 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
 920                     ; 477 {
 921                     	switch	.text
 922  00a9               f_ADC2_IRQHandler:
 926                     ; 481 }
 929  00a9 80            	iret	
 960                     ; 515 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 960                     ; 516 {
 961                     	switch	.text
 962  00aa               f_TIM4_UPD_OVF_IRQHandler:
 964  00aa 3b0002        	push	c_x+2
 965  00ad be00          	ldw	x,c_x
 966  00af 89            	pushw	x
 967  00b0 3b0002        	push	c_y+2
 968  00b3 be00          	ldw	x,c_y
 969  00b5 89            	pushw	x
 972                     ; 520   SetLINTimebaseTick();
 975  00b6 cd0000        	call	_SetLINTimebaseTick
 977                     ; 522   if (AppliTick > APPLI_TASK_40MS)
 979  00b9 c60000        	ld	a,L3_AppliTick
 980  00bc a128          	cp	a,#40
 981  00be 2509          	jrult	L153
 982                     ; 524     AppliTick = 0;
 984  00c0 725f0000      	clr	L3_AppliTick
 985                     ; 525     SetAppliTimebaseTick();
 987  00c4 cd0000        	call	_SetAppliTimebaseTick
 990  00c7 2004          	jra	L353
 991  00c9               L153:
 992                     ; 529     AppliTick++;
 994  00c9 725c0000      	inc	L3_AppliTick
 995  00cd               L353:
 996                     ; 532   if (LINReceptionTimeout == TRUE) LINReceptionTimeoutValue++;
 998  00cd c60000        	ld	a,_LINReceptionTimeout
 999  00d0 4a            	dec	a
1000  00d1 2604          	jrne	L553
1003  00d3 725c0000      	inc	_LINReceptionTimeoutValue
1004  00d7               L553:
1005                     ; 534   TimingDelay_Decrement();
1007  00d7 cd0000        	call	_TimingDelay_Decrement
1009                     ; 535   WdgAutoDecrement();
1011  00da cd0000        	call	_WdgAutoDecrement
1013                     ; 538   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
1015  00dd a601          	ld	a,#1
1016  00df cd0000        	call	_TIM4_ClearITPendingBit
1018                     ; 541 }
1022  00e2 85            	popw	x
1023  00e3 bf00          	ldw	c_y,x
1024  00e5 320002        	pop	c_y+2
1025  00e8 85            	popw	x
1026  00e9 bf00          	ldw	c_x,x
1027  00eb 320002        	pop	c_x+2
1028  00ee 80            	iret	
1051                     ; 549 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1051                     ; 550 {
1052                     	switch	.text
1053  00ef               f_EEPROM_EEC_IRQHandler:
1057                     ; 554 }
1060  00ef 80            	iret	
1081                     	xref	_UART3_BDIE
1082                     	xref	_LINReceptionTimeout
1083                     	xref	_LINReceptionTimeoutValue
1084                     	xref	_BreakReceived
1085                     	xref	_DataReceived
1086                     	xref	_WdgAutoDecrement
1087                     	xref	_TimingDelay_Decrement
1088                     	xref	_SetAppliTimebaseTick
1089                     	xref	_SetLINTimebaseTick
1090                     	xref	_ReceptionError
1091                     	xref	_UART3Data
1092                     	xref	_UART3_SR_Buf
1093                     	xref	_UserButton2
1094                     	xref	_UserButton1
1095                     	xdef	f_EEPROM_EEC_IRQHandler
1096                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1097                     	xdef	f_ADC2_IRQHandler
1098                     	xdef	f_UART3_TX_IRQHandler
1099                     	xdef	f_UART3_RX_IRQHandler
1100                     	xdef	f_I2C_IRQHandler
1101                     	xdef	f_UART1_RX_IRQHandler
1102                     	xdef	f_UART1_TX_IRQHandler
1103                     	xdef	f_TIM3_CAP_COM_IRQHandler
1104                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1105                     	xdef	f_TIM2_CAP_COM_IRQHandler
1106                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1107                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1108                     	xdef	f_TIM1_CAP_COM_IRQHandler
1109                     	xdef	f_SPI_IRQHandler
1110                     	xdef	f_CAN_TX_IRQHandler
1111                     	xdef	f_CAN_RX_IRQHandler
1112                     	xdef	f_EXTI_PORTE_IRQHandler
1113                     	xdef	f_EXTI_PORTD_IRQHandler
1114                     	xdef	f_EXTI_PORTC_IRQHandler
1115                     	xdef	f_EXTI_PORTB_IRQHandler
1116                     	xdef	f_EXTI_PORTA_IRQHandler
1117                     	xdef	f_CLK_IRQHandler
1118                     	xdef	f_AWU_IRQHandler
1119                     	xdef	f_TLI_IRQHandler
1120                     	xdef	f_TRAP_IRQHandler
1121                     	xdef	f_NonHandledInterrupt
1122                     	xref	_TIM4_ClearITPendingBit
1123                     	xref	_GPIO_ReadInputPin
1124                     	xref.b	c_x
1125                     	xref.b	c_y
1144                     	end
