   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
 113                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 113                     ; 48 {
 115                     	switch	.text
 116  0000               _GPIO_DeInit:
 120                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 122  0000 7f            	clr	(x)
 123                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 125  0001 6f02          	clr	(2,x)
 126                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 128  0003 6f03          	clr	(3,x)
 129                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 131  0005 6f04          	clr	(4,x)
 132                     ; 53 }
 135  0007 81            	ret	
 376                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 376                     ; 66 {
 377                     	switch	.text
 378  0008               _GPIO_Init:
 380  0008 89            	pushw	x
 381       00000000      OFST:	set	0
 384                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 386  0009 7b06          	ld	a,(OFST+6,sp)
 387  000b 273a          	jreq	L41
 388  000d a140          	cp	a,#64
 389  000f 2736          	jreq	L41
 390  0011 a120          	cp	a,#32
 391  0013 2732          	jreq	L41
 392  0015 a160          	cp	a,#96
 393  0017 272e          	jreq	L41
 394  0019 a1a0          	cp	a,#160
 395  001b 272a          	jreq	L41
 396  001d a1e0          	cp	a,#224
 397  001f 2726          	jreq	L41
 398  0021 a180          	cp	a,#128
 399  0023 2722          	jreq	L41
 400  0025 a1c0          	cp	a,#192
 401  0027 271e          	jreq	L41
 402  0029 a1b0          	cp	a,#176
 403  002b 271a          	jreq	L41
 404  002d a1f0          	cp	a,#240
 405  002f 2716          	jreq	L41
 406  0031 a190          	cp	a,#144
 407  0033 2712          	jreq	L41
 408  0035 a1d0          	cp	a,#208
 409  0037 270e          	jreq	L41
 410  0039 ae0047        	ldw	x,#71
 411  003c 89            	pushw	x
 412  003d 5f            	clrw	x
 413  003e 89            	pushw	x
 414  003f ae0000        	ldw	x,#L771
 415  0042 cd0000        	call	_assert_failed
 417  0045 5b04          	addw	sp,#4
 418  0047               L41:
 419                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 421  0047 7b05          	ld	a,(OFST+5,sp)
 422  0049 2610          	jrne	L22
 423  004b ae0048        	ldw	x,#72
 424  004e 89            	pushw	x
 425  004f 5f            	clrw	x
 426  0050 89            	pushw	x
 427  0051 ae0000        	ldw	x,#L771
 428  0054 cd0000        	call	_assert_failed
 430  0057 5b04          	addw	sp,#4
 431  0059 7b05          	ld	a,(OFST+5,sp)
 432  005b               L22:
 433                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 435  005b 1e01          	ldw	x,(OFST+1,sp)
 436  005d 43            	cpl	a
 437  005e e404          	and	a,(4,x)
 438  0060 e704          	ld	(4,x),a
 439                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 441  0062 7b06          	ld	a,(OFST+6,sp)
 442  0064 2a14          	jrpl	L102
 443                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 445  0066 a510          	bcp	a,#16
 446  0068 2705          	jreq	L302
 447                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 449  006a f6            	ld	a,(x)
 450  006b 1a05          	or	a,(OFST+5,sp)
 452  006d 2004          	jra	L502
 453  006f               L302:
 454                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 456  006f 7b05          	ld	a,(OFST+5,sp)
 457  0071 43            	cpl	a
 458  0072 f4            	and	a,(x)
 459  0073               L502:
 460  0073 f7            	ld	(x),a
 461                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 463  0074 e602          	ld	a,(2,x)
 464  0076 1a05          	or	a,(OFST+5,sp)
 466  0078 2005          	jra	L702
 467  007a               L102:
 468                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 470  007a 7b05          	ld	a,(OFST+5,sp)
 471  007c 43            	cpl	a
 472  007d e402          	and	a,(2,x)
 473  007f               L702:
 474  007f e702          	ld	(2,x),a
 475                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 477  0081 7b06          	ld	a,(OFST+6,sp)
 478  0083 a540          	bcp	a,#64
 479  0085 2706          	jreq	L112
 480                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 482  0087 e603          	ld	a,(3,x)
 483  0089 1a05          	or	a,(OFST+5,sp)
 485  008b 2005          	jra	L312
 486  008d               L112:
 487                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 489  008d 7b05          	ld	a,(OFST+5,sp)
 490  008f 43            	cpl	a
 491  0090 e403          	and	a,(3,x)
 492  0092               L312:
 493  0092 e703          	ld	(3,x),a
 494                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 496  0094 7b06          	ld	a,(OFST+6,sp)
 497  0096 a520          	bcp	a,#32
 498  0098 2708          	jreq	L512
 499                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 501  009a 1e01          	ldw	x,(OFST+1,sp)
 502  009c e604          	ld	a,(4,x)
 503  009e 1a05          	or	a,(OFST+5,sp)
 505  00a0 2007          	jra	L712
 506  00a2               L512:
 507                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 509  00a2 1e01          	ldw	x,(OFST+1,sp)
 510  00a4 7b05          	ld	a,(OFST+5,sp)
 511  00a6 43            	cpl	a
 512  00a7 e404          	and	a,(4,x)
 513  00a9               L712:
 514  00a9 e704          	ld	(4,x),a
 515                     ; 125 }
 518  00ab 85            	popw	x
 519  00ac 81            	ret	
 563                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 563                     ; 136 {
 564                     	switch	.text
 565  00ad               _GPIO_Write:
 567  00ad 89            	pushw	x
 568       00000000      OFST:	set	0
 571                     ; 137     GPIOx->ODR = PortVal;
 573  00ae 1e01          	ldw	x,(OFST+1,sp)
 574  00b0 7b05          	ld	a,(OFST+5,sp)
 575  00b2 f7            	ld	(x),a
 576                     ; 138 }
 579  00b3 85            	popw	x
 580  00b4 81            	ret	
 627                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 627                     ; 149 {
 628                     	switch	.text
 629  00b5               _GPIO_WriteHigh:
 631  00b5 89            	pushw	x
 632       00000000      OFST:	set	0
 635                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 637  00b6 f6            	ld	a,(x)
 638  00b7 1a05          	or	a,(OFST+5,sp)
 639  00b9 f7            	ld	(x),a
 640                     ; 151 }
 643  00ba 85            	popw	x
 644  00bb 81            	ret	
 691                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 691                     ; 162 {
 692                     	switch	.text
 693  00bc               _GPIO_WriteLow:
 695  00bc 89            	pushw	x
 696       00000000      OFST:	set	0
 699                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 701  00bd 7b05          	ld	a,(OFST+5,sp)
 702  00bf 43            	cpl	a
 703  00c0 f4            	and	a,(x)
 704  00c1 f7            	ld	(x),a
 705                     ; 164 }
 708  00c2 85            	popw	x
 709  00c3 81            	ret	
 756                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 756                     ; 175 {
 757                     	switch	.text
 758  00c4               _GPIO_WriteReverse:
 760  00c4 89            	pushw	x
 761       00000000      OFST:	set	0
 764                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 766  00c5 f6            	ld	a,(x)
 767  00c6 1805          	xor	a,(OFST+5,sp)
 768  00c8 f7            	ld	(x),a
 769                     ; 177 }
 772  00c9 85            	popw	x
 773  00ca 81            	ret	
 811                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 811                     ; 186 {
 812                     	switch	.text
 813  00cb               _GPIO_ReadOutputData:
 817                     ; 187     return ((uint8_t)GPIOx->ODR);
 819  00cb f6            	ld	a,(x)
 822  00cc 81            	ret	
 859                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 859                     ; 197 {
 860                     	switch	.text
 861  00cd               _GPIO_ReadInputData:
 865                     ; 198     return ((uint8_t)GPIOx->IDR);
 867  00cd e601          	ld	a,(1,x)
 870  00cf 81            	ret	
 938                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 938                     ; 208 {
 939                     	switch	.text
 940  00d0               _GPIO_ReadInputPin:
 942  00d0 89            	pushw	x
 943       00000000      OFST:	set	0
 946                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 948  00d1 e601          	ld	a,(1,x)
 949  00d3 1405          	and	a,(OFST+5,sp)
 952  00d5 85            	popw	x
 953  00d6 81            	ret	
1032                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
1032                     ; 220 {
1033                     	switch	.text
1034  00d7               _GPIO_ExternalPullUpConfig:
1036  00d7 89            	pushw	x
1037       00000000      OFST:	set	0
1040                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
1042  00d8 7b05          	ld	a,(OFST+5,sp)
1043  00da 260e          	jrne	L05
1044  00dc ae00de        	ldw	x,#222
1045  00df 89            	pushw	x
1046  00e0 5f            	clrw	x
1047  00e1 89            	pushw	x
1048  00e2 ae0000        	ldw	x,#L771
1049  00e5 cd0000        	call	_assert_failed
1051  00e8 5b04          	addw	sp,#4
1052  00ea               L05:
1053                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1055  00ea 7b06          	ld	a,(OFST+6,sp)
1056  00ec 2711          	jreq	L06
1057  00ee 4a            	dec	a
1058  00ef 270e          	jreq	L06
1059  00f1 ae00df        	ldw	x,#223
1060  00f4 89            	pushw	x
1061  00f5 5f            	clrw	x
1062  00f6 89            	pushw	x
1063  00f7 ae0000        	ldw	x,#L771
1064  00fa cd0000        	call	_assert_failed
1066  00fd 5b04          	addw	sp,#4
1067  00ff               L06:
1068                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
1070  00ff 7b06          	ld	a,(OFST+6,sp)
1071  0101 2708          	jreq	L374
1072                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1074  0103 1e01          	ldw	x,(OFST+1,sp)
1075  0105 e603          	ld	a,(3,x)
1076  0107 1a05          	or	a,(OFST+5,sp)
1078  0109 2007          	jra	L574
1079  010b               L374:
1080                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1082  010b 1e01          	ldw	x,(OFST+1,sp)
1083  010d 7b05          	ld	a,(OFST+5,sp)
1084  010f 43            	cpl	a
1085  0110 e403          	and	a,(3,x)
1086  0112               L574:
1087  0112 e703          	ld	(3,x),a
1088                     ; 232 }
1091  0114 85            	popw	x
1092  0115 81            	ret	
1105                     	xdef	_GPIO_ExternalPullUpConfig
1106                     	xdef	_GPIO_ReadInputPin
1107                     	xdef	_GPIO_ReadOutputData
1108                     	xdef	_GPIO_ReadInputData
1109                     	xdef	_GPIO_WriteReverse
1110                     	xdef	_GPIO_WriteLow
1111                     	xdef	_GPIO_WriteHigh
1112                     	xdef	_GPIO_Write
1113                     	xdef	_GPIO_Init
1114                     	xdef	_GPIO_DeInit
1115                     	xref	_assert_failed
1116                     .const:	section	.text
1117  0000               L771:
1118  0000 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
1119  0012 6965735c7374  	dc.b	"ies\stm8s_stdperip"
1120  0024 685f64726976  	dc.b	"h_driver\src\stm8s"
1121  0036 5f6770696f2e  	dc.b	"_gpio.c",0
1141                     	end
