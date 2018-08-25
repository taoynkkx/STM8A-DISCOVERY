   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  47                     ; 44 void SPI_DeInit(void)
  47                     ; 45 {
  49                     	switch	.text
  50  0000               _SPI_DeInit:
  54                     ; 46     SPI->CR1    = SPI_CR1_RESET_VALUE;
  56  0000 725f5200      	clr	20992
  57                     ; 47     SPI->CR2    = SPI_CR2_RESET_VALUE;
  59  0004 725f5201      	clr	20993
  60                     ; 48     SPI->ICR    = SPI_ICR_RESET_VALUE;
  62  0008 725f5202      	clr	20994
  63                     ; 49     SPI->SR     = SPI_SR_RESET_VALUE;
  65  000c 35025203      	mov	20995,#2
  66                     ; 50     SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  68  0010 35075205      	mov	20997,#7
  69                     ; 51 }
  72  0014 81            	ret	
 387                     ; 72 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial)
 387                     ; 73 {
 388                     	switch	.text
 389  0015               _SPI_Init:
 391  0015 89            	pushw	x
 392  0016 88            	push	a
 393       00000001      OFST:	set	1
 396                     ; 75     assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 398  0017 9e            	ld	a,xh
 399  0018 4d            	tnz	a
 400  0019 2713          	jreq	L41
 401  001b 9e            	ld	a,xh
 402  001c a180          	cp	a,#128
 403  001e 270e          	jreq	L41
 404  0020 ae004b        	ldw	x,#75
 405  0023 89            	pushw	x
 406  0024 5f            	clrw	x
 407  0025 89            	pushw	x
 408  0026 ae0000        	ldw	x,#L102
 409  0029 cd0000        	call	_assert_failed
 411  002c 5b04          	addw	sp,#4
 412  002e               L41:
 413                     ; 76     assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 415  002e 7b03          	ld	a,(OFST+2,sp)
 416  0030 272a          	jreq	L42
 417  0032 a108          	cp	a,#8
 418  0034 2726          	jreq	L42
 419  0036 a110          	cp	a,#16
 420  0038 2722          	jreq	L42
 421  003a a118          	cp	a,#24
 422  003c 271e          	jreq	L42
 423  003e a120          	cp	a,#32
 424  0040 271a          	jreq	L42
 425  0042 a128          	cp	a,#40
 426  0044 2716          	jreq	L42
 427  0046 a130          	cp	a,#48
 428  0048 2712          	jreq	L42
 429  004a a138          	cp	a,#56
 430  004c 270e          	jreq	L42
 431  004e ae004c        	ldw	x,#76
 432  0051 89            	pushw	x
 433  0052 5f            	clrw	x
 434  0053 89            	pushw	x
 435  0054 ae0000        	ldw	x,#L102
 436  0057 cd0000        	call	_assert_failed
 438  005a 5b04          	addw	sp,#4
 439  005c               L42:
 440                     ; 77     assert_param(IS_SPI_MODE_OK(Mode));
 442  005c 7b06          	ld	a,(OFST+5,sp)
 443  005e a104          	cp	a,#4
 444  0060 2712          	jreq	L43
 445  0062 7b06          	ld	a,(OFST+5,sp)
 446  0064 270e          	jreq	L43
 447  0066 ae004d        	ldw	x,#77
 448  0069 89            	pushw	x
 449  006a 5f            	clrw	x
 450  006b 89            	pushw	x
 451  006c ae0000        	ldw	x,#L102
 452  006f cd0000        	call	_assert_failed
 454  0072 5b04          	addw	sp,#4
 455  0074               L43:
 456                     ; 78     assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 458  0074 7b07          	ld	a,(OFST+6,sp)
 459  0076 2712          	jreq	L44
 460  0078 a102          	cp	a,#2
 461  007a 270e          	jreq	L44
 462  007c ae004e        	ldw	x,#78
 463  007f 89            	pushw	x
 464  0080 5f            	clrw	x
 465  0081 89            	pushw	x
 466  0082 ae0000        	ldw	x,#L102
 467  0085 cd0000        	call	_assert_failed
 469  0088 5b04          	addw	sp,#4
 470  008a               L44:
 471                     ; 79     assert_param(IS_SPI_PHASE_OK(ClockPhase));
 473  008a 7b08          	ld	a,(OFST+7,sp)
 474  008c 2711          	jreq	L45
 475  008e 4a            	dec	a
 476  008f 270e          	jreq	L45
 477  0091 ae004f        	ldw	x,#79
 478  0094 89            	pushw	x
 479  0095 5f            	clrw	x
 480  0096 89            	pushw	x
 481  0097 ae0000        	ldw	x,#L102
 482  009a cd0000        	call	_assert_failed
 484  009d 5b04          	addw	sp,#4
 485  009f               L45:
 486                     ; 80     assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 488  009f 7b09          	ld	a,(OFST+8,sp)
 489  00a1 271a          	jreq	L46
 490  00a3 a104          	cp	a,#4
 491  00a5 2716          	jreq	L46
 492  00a7 a180          	cp	a,#128
 493  00a9 2712          	jreq	L46
 494  00ab a1c0          	cp	a,#192
 495  00ad 270e          	jreq	L46
 496  00af ae0050        	ldw	x,#80
 497  00b2 89            	pushw	x
 498  00b3 5f            	clrw	x
 499  00b4 89            	pushw	x
 500  00b5 ae0000        	ldw	x,#L102
 501  00b8 cd0000        	call	_assert_failed
 503  00bb 5b04          	addw	sp,#4
 504  00bd               L46:
 505                     ; 81     assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 507  00bd 7b0a          	ld	a,(OFST+9,sp)
 508  00bf a102          	cp	a,#2
 509  00c1 2712          	jreq	L47
 510  00c3 7b0a          	ld	a,(OFST+9,sp)
 511  00c5 270e          	jreq	L47
 512  00c7 ae0051        	ldw	x,#81
 513  00ca 89            	pushw	x
 514  00cb 5f            	clrw	x
 515  00cc 89            	pushw	x
 516  00cd ae0000        	ldw	x,#L102
 517  00d0 cd0000        	call	_assert_failed
 519  00d3 5b04          	addw	sp,#4
 520  00d5               L47:
 521                     ; 82     assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 523  00d5 7b0b          	ld	a,(OFST+10,sp)
 524  00d7 260e          	jrne	L201
 525  00d9 ae0052        	ldw	x,#82
 526  00dc 89            	pushw	x
 527  00dd 5f            	clrw	x
 528  00de 89            	pushw	x
 529  00df ae0000        	ldw	x,#L102
 530  00e2 cd0000        	call	_assert_failed
 532  00e5 5b04          	addw	sp,#4
 533  00e7               L201:
 534                     ; 85     SPI->CR1 = (uint8_t)((uint8_t)((uint8_t)FirstBit | BaudRatePrescaler) |
 534                     ; 86                     (uint8_t)((uint8_t)ClockPolarity | ClockPhase));
 536  00e7 7b07          	ld	a,(OFST+6,sp)
 537  00e9 1a08          	or	a,(OFST+7,sp)
 538  00eb 6b01          	ld	(OFST+0,sp),a
 539  00ed 7b02          	ld	a,(OFST+1,sp)
 540  00ef 1a03          	or	a,(OFST+2,sp)
 541  00f1 1a01          	or	a,(OFST+0,sp)
 542  00f3 c75200        	ld	20992,a
 543                     ; 89     SPI->CR2 = (uint8_t)((uint8_t)(Data_Direction) | (uint8_t)(Slave_Management));
 545  00f6 7b09          	ld	a,(OFST+8,sp)
 546  00f8 1a0a          	or	a,(OFST+9,sp)
 547  00fa c75201        	ld	20993,a
 548                     ; 91     if (Mode == SPI_MODE_MASTER)
 550  00fd 7b06          	ld	a,(OFST+5,sp)
 551  00ff a104          	cp	a,#4
 552  0101 2606          	jrne	L302
 553                     ; 93         SPI->CR2 |= (uint8_t)SPI_CR2_SSI;
 555  0103 72105201      	bset	20993,#0
 557  0107 2004          	jra	L502
 558  0109               L302:
 559                     ; 97         SPI->CR2 &= (uint8_t)~(SPI_CR2_SSI);
 561  0109 72115201      	bres	20993,#0
 562  010d               L502:
 563                     ; 101     SPI->CR1 |= (uint8_t)(Mode);
 565  010d c65200        	ld	a,20992
 566  0110 1a06          	or	a,(OFST+5,sp)
 567  0112 c75200        	ld	20992,a
 568                     ; 104     SPI->CRCPR = (uint8_t)CRCPolynomial;
 570  0115 7b0b          	ld	a,(OFST+10,sp)
 571  0117 c75205        	ld	20997,a
 572                     ; 105 }
 575  011a 5b03          	addw	sp,#3
 576  011c 81            	ret	
 632                     ; 113 void SPI_Cmd(FunctionalState NewState)
 632                     ; 114 {
 633                     	switch	.text
 634  011d               _SPI_Cmd:
 636  011d 88            	push	a
 637       00000000      OFST:	set	0
 640                     ; 116     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 642  011e 4d            	tnz	a
 643  011f 2711          	jreq	L411
 644  0121 4a            	dec	a
 645  0122 270e          	jreq	L411
 646  0124 ae0074        	ldw	x,#116
 647  0127 89            	pushw	x
 648  0128 5f            	clrw	x
 649  0129 89            	pushw	x
 650  012a ae0000        	ldw	x,#L102
 651  012d cd0000        	call	_assert_failed
 653  0130 5b04          	addw	sp,#4
 654  0132               L411:
 655                     ; 118     if (NewState != DISABLE)
 657  0132 7b01          	ld	a,(OFST+1,sp)
 658  0134 2706          	jreq	L532
 659                     ; 120         SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 661  0136 721c5200      	bset	20992,#6
 663  013a 2004          	jra	L732
 664  013c               L532:
 665                     ; 124         SPI->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 667  013c 721d5200      	bres	20992,#6
 668  0140               L732:
 669                     ; 126 }
 672  0140 84            	pop	a
 673  0141 81            	ret	
 781                     ; 135 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 781                     ; 136 {
 782                     	switch	.text
 783  0142               _SPI_ITConfig:
 785  0142 89            	pushw	x
 786  0143 88            	push	a
 787       00000001      OFST:	set	1
 790                     ; 137     uint8_t itpos = 0;
 792                     ; 139     assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 794  0144 9e            	ld	a,xh
 795  0145 a117          	cp	a,#23
 796  0147 271d          	jreq	L621
 797  0149 9e            	ld	a,xh
 798  014a a106          	cp	a,#6
 799  014c 2718          	jreq	L621
 800  014e 9e            	ld	a,xh
 801  014f a105          	cp	a,#5
 802  0151 2713          	jreq	L621
 803  0153 9e            	ld	a,xh
 804  0154 a134          	cp	a,#52
 805  0156 270e          	jreq	L621
 806  0158 ae008b        	ldw	x,#139
 807  015b 89            	pushw	x
 808  015c 5f            	clrw	x
 809  015d 89            	pushw	x
 810  015e ae0000        	ldw	x,#L102
 811  0161 cd0000        	call	_assert_failed
 813  0164 5b04          	addw	sp,#4
 814  0166               L621:
 815                     ; 140     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 817  0166 7b03          	ld	a,(OFST+2,sp)
 818  0168 2711          	jreq	L631
 819  016a 4a            	dec	a
 820  016b 270e          	jreq	L631
 821  016d ae008c        	ldw	x,#140
 822  0170 89            	pushw	x
 823  0171 5f            	clrw	x
 824  0172 89            	pushw	x
 825  0173 ae0000        	ldw	x,#L102
 826  0176 cd0000        	call	_assert_failed
 828  0179 5b04          	addw	sp,#4
 829  017b               L631:
 830                     ; 143     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)SPI_IT & (uint8_t)0x0F));
 832  017b 7b02          	ld	a,(OFST+1,sp)
 833  017d a40f          	and	a,#15
 834  017f 5f            	clrw	x
 835  0180 97            	ld	xl,a
 836  0181 a601          	ld	a,#1
 837  0183 5d            	tnzw	x
 838  0184 2704          	jreq	L241
 839  0186               L441:
 840  0186 48            	sll	a
 841  0187 5a            	decw	x
 842  0188 26fc          	jrne	L441
 843  018a               L241:
 844  018a 6b01          	ld	(OFST+0,sp),a
 845                     ; 145     if (NewState != DISABLE)
 847  018c 0d03          	tnz	(OFST+2,sp)
 848  018e 2707          	jreq	L703
 849                     ; 147         SPI->ICR |= itpos; /* Enable interrupt*/
 851  0190 c65202        	ld	a,20994
 852  0193 1a01          	or	a,(OFST+0,sp)
 854  0195 2004          	jra	L113
 855  0197               L703:
 856                     ; 151         SPI->ICR &= (uint8_t)(~itpos); /* Disable interrupt*/
 858  0197 43            	cpl	a
 859  0198 c45202        	and	a,20994
 860  019b               L113:
 861  019b c75202        	ld	20994,a
 862                     ; 153 }
 865  019e 5b03          	addw	sp,#3
 866  01a0 81            	ret	
 898                     ; 159 void SPI_SendData(uint8_t Data)
 898                     ; 160 {
 899                     	switch	.text
 900  01a1               _SPI_SendData:
 904                     ; 161     SPI->DR = Data; /* Write in the DR register the data to be sent*/
 906  01a1 c75204        	ld	20996,a
 907                     ; 162 }
 910  01a4 81            	ret	
 933                     ; 169 uint8_t SPI_ReceiveData(void)
 933                     ; 170 {
 934                     	switch	.text
 935  01a5               _SPI_ReceiveData:
 939                     ; 171     return ((uint8_t)SPI->DR); /* Return the data in the DR register*/
 941  01a5 c65204        	ld	a,20996
 944  01a8 81            	ret	
 981                     ; 180 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 981                     ; 181 {
 982                     	switch	.text
 983  01a9               _SPI_NSSInternalSoftwareCmd:
 985  01a9 88            	push	a
 986       00000000      OFST:	set	0
 989                     ; 183     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 991  01aa 4d            	tnz	a
 992  01ab 2711          	jreq	L061
 993  01ad 4a            	dec	a
 994  01ae 270e          	jreq	L061
 995  01b0 ae00b7        	ldw	x,#183
 996  01b3 89            	pushw	x
 997  01b4 5f            	clrw	x
 998  01b5 89            	pushw	x
 999  01b6 ae0000        	ldw	x,#L102
1000  01b9 cd0000        	call	_assert_failed
1002  01bc 5b04          	addw	sp,#4
1003  01be               L061:
1004                     ; 185     if (NewState != DISABLE)
1006  01be 7b01          	ld	a,(OFST+1,sp)
1007  01c0 2706          	jreq	L553
1008                     ; 187         SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
1010  01c2 72105201      	bset	20993,#0
1012  01c6 2004          	jra	L753
1013  01c8               L553:
1014                     ; 191         SPI->CR2 &= (uint8_t)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
1016  01c8 72115201      	bres	20993,#0
1017  01cc               L753:
1018                     ; 193 }
1021  01cc 84            	pop	a
1022  01cd 81            	ret	
1045                     ; 200 void SPI_TransmitCRC(void)
1045                     ; 201 {
1046                     	switch	.text
1047  01ce               _SPI_TransmitCRC:
1051                     ; 202     SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
1053  01ce 72185201      	bset	20993,#4
1054                     ; 203 }
1057  01d2 81            	ret	
1094                     ; 211 void SPI_CalculateCRCCmd(FunctionalState NewState)
1094                     ; 212 {
1095                     	switch	.text
1096  01d3               _SPI_CalculateCRCCmd:
1098  01d3 88            	push	a
1099       00000000      OFST:	set	0
1102                     ; 214     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1104  01d4 4d            	tnz	a
1105  01d5 2711          	jreq	L471
1106  01d7 4a            	dec	a
1107  01d8 270e          	jreq	L471
1108  01da ae00d6        	ldw	x,#214
1109  01dd 89            	pushw	x
1110  01de 5f            	clrw	x
1111  01df 89            	pushw	x
1112  01e0 ae0000        	ldw	x,#L102
1113  01e3 cd0000        	call	_assert_failed
1115  01e6 5b04          	addw	sp,#4
1116  01e8               L471:
1117                     ; 216     if (NewState != DISABLE)
1119  01e8 7b01          	ld	a,(OFST+1,sp)
1120  01ea 2706          	jreq	L704
1121                     ; 218         SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
1123  01ec 721a5201      	bset	20993,#5
1125  01f0 2004          	jra	L114
1126  01f2               L704:
1127                     ; 222         SPI->CR2 &= (uint8_t)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
1129  01f2 721b5201      	bres	20993,#5
1130  01f6               L114:
1131                     ; 224 }
1134  01f6 84            	pop	a
1135  01f7 81            	ret	
1198                     ; 231 uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
1198                     ; 232 {
1199                     	switch	.text
1200  01f8               _SPI_GetCRC:
1202  01f8 88            	push	a
1203  01f9 88            	push	a
1204       00000001      OFST:	set	1
1207                     ; 233     uint8_t crcreg = 0;
1209                     ; 236     assert_param(IS_SPI_CRC_OK(SPI_CRC));
1211  01fa a101          	cp	a,#1
1212  01fc 2711          	jreq	L602
1213  01fe 4d            	tnz	a
1214  01ff 270e          	jreq	L602
1215  0201 ae00ec        	ldw	x,#236
1216  0204 89            	pushw	x
1217  0205 5f            	clrw	x
1218  0206 89            	pushw	x
1219  0207 ae0000        	ldw	x,#L102
1220  020a cd0000        	call	_assert_failed
1222  020d 5b04          	addw	sp,#4
1223  020f               L602:
1224                     ; 238     if (SPI_CRC != SPI_CRC_RX)
1226  020f 7b02          	ld	a,(OFST+1,sp)
1227  0211 2705          	jreq	L344
1228                     ; 240         crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1230  0213 c65207        	ld	a,20999
1232  0216 2003          	jra	L544
1233  0218               L344:
1234                     ; 244         crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1236  0218 c65206        	ld	a,20998
1237  021b               L544:
1238                     ; 248     return crcreg;
1242  021b 85            	popw	x
1243  021c 81            	ret	
1268                     ; 256 void SPI_ResetCRC(void)
1268                     ; 257 {
1269                     	switch	.text
1270  021d               _SPI_ResetCRC:
1274                     ; 260     SPI_CalculateCRCCmd(ENABLE);
1276  021d a601          	ld	a,#1
1277  021f adb2          	call	_SPI_CalculateCRCCmd
1279                     ; 263     SPI_Cmd(ENABLE);
1281  0221 a601          	ld	a,#1
1283                     ; 264 }
1286  0223 cc011d        	jp	_SPI_Cmd
1310                     ; 271 uint8_t SPI_GetCRCPolynomial(void)
1310                     ; 272 {
1311                     	switch	.text
1312  0226               _SPI_GetCRCPolynomial:
1316                     ; 273     return SPI->CRCPR; /* Return the CRC polynomial register */
1318  0226 c65205        	ld	a,20997
1321  0229 81            	ret	
1378                     ; 281 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1378                     ; 282 {
1379                     	switch	.text
1380  022a               _SPI_BiDirectionalLineConfig:
1382  022a 88            	push	a
1383       00000000      OFST:	set	0
1386                     ; 284     assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1388  022b 4d            	tnz	a
1389  022c 2711          	jreq	L032
1390  022e 4a            	dec	a
1391  022f 270e          	jreq	L032
1392  0231 ae011c        	ldw	x,#284
1393  0234 89            	pushw	x
1394  0235 5f            	clrw	x
1395  0236 89            	pushw	x
1396  0237 ae0000        	ldw	x,#L102
1397  023a cd0000        	call	_assert_failed
1399  023d 5b04          	addw	sp,#4
1400  023f               L032:
1401                     ; 286     if (SPI_Direction != SPI_DIRECTION_RX)
1403  023f 7b01          	ld	a,(OFST+1,sp)
1404  0241 2706          	jreq	L515
1405                     ; 288         SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1407  0243 721c5201      	bset	20993,#6
1409  0247 2004          	jra	L715
1410  0249               L515:
1411                     ; 292         SPI->CR2 &= (uint8_t)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1413  0249 721d5201      	bres	20993,#6
1414  024d               L715:
1415                     ; 294 }
1418  024d 84            	pop	a
1419  024e 81            	ret	
1541                     ; 304 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1541                     ; 305 {
1542                     	switch	.text
1543  024f               _SPI_GetFlagStatus:
1545  024f 88            	push	a
1546  0250 88            	push	a
1547       00000001      OFST:	set	1
1550                     ; 306     FlagStatus status = RESET;
1552                     ; 308     assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1554  0251 a140          	cp	a,#64
1555  0253 2726          	jreq	L242
1556  0255 a120          	cp	a,#32
1557  0257 2722          	jreq	L242
1558  0259 a110          	cp	a,#16
1559  025b 271e          	jreq	L242
1560  025d a108          	cp	a,#8
1561  025f 271a          	jreq	L242
1562  0261 a102          	cp	a,#2
1563  0263 2716          	jreq	L242
1564  0265 a101          	cp	a,#1
1565  0267 2712          	jreq	L242
1566  0269 a180          	cp	a,#128
1567  026b 270e          	jreq	L242
1568  026d ae0134        	ldw	x,#308
1569  0270 89            	pushw	x
1570  0271 5f            	clrw	x
1571  0272 89            	pushw	x
1572  0273 ae0000        	ldw	x,#L102
1573  0276 cd0000        	call	_assert_failed
1575  0279 5b04          	addw	sp,#4
1576  027b               L242:
1577                     ; 311     if ((SPI->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
1579  027b c65203        	ld	a,20995
1580  027e 1502          	bcp	a,(OFST+1,sp)
1581  0280 2704          	jreq	L575
1582                     ; 313         status = SET; /* SPI_FLAG is set */
1584  0282 a601          	ld	a,#1
1586  0284 2001          	jra	L775
1587  0286               L575:
1588                     ; 317         status = RESET; /* SPI_FLAG is reset*/
1590  0286 4f            	clr	a
1591  0287               L775:
1592                     ; 321     return status;
1596  0287 85            	popw	x
1597  0288 81            	ret	
1633                     ; 339 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1633                     ; 340 {
1634                     	switch	.text
1635  0289               _SPI_ClearFlag:
1637  0289 88            	push	a
1638       00000000      OFST:	set	0
1641                     ; 341     assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1643  028a a110          	cp	a,#16
1644  028c 2712          	jreq	L452
1645  028e a108          	cp	a,#8
1646  0290 270e          	jreq	L452
1647  0292 ae0155        	ldw	x,#341
1648  0295 89            	pushw	x
1649  0296 5f            	clrw	x
1650  0297 89            	pushw	x
1651  0298 ae0000        	ldw	x,#L102
1652  029b cd0000        	call	_assert_failed
1654  029e 5b04          	addw	sp,#4
1655  02a0               L452:
1656                     ; 343     SPI->SR = (uint8_t)(~SPI_FLAG);
1658  02a0 7b01          	ld	a,(OFST+1,sp)
1659  02a2 43            	cpl	a
1660  02a3 c75203        	ld	20995,a
1661                     ; 344 }
1664  02a6 84            	pop	a
1665  02a7 81            	ret	
1740                     ; 359 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1740                     ; 360 {
1741                     	switch	.text
1742  02a8               _SPI_GetITStatus:
1744  02a8 88            	push	a
1745  02a9 89            	pushw	x
1746       00000002      OFST:	set	2
1749                     ; 361     ITStatus pendingbitstatus = RESET;
1751                     ; 362     uint8_t itpos = 0;
1753                     ; 363     uint8_t itmask1 = 0;
1755                     ; 364     uint8_t itmask2 = 0;
1757                     ; 365     uint8_t enablestatus = 0;
1759                     ; 366     assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1761  02aa a165          	cp	a,#101
1762  02ac 2722          	jreq	L662
1763  02ae a155          	cp	a,#85
1764  02b0 271e          	jreq	L662
1765  02b2 a145          	cp	a,#69
1766  02b4 271a          	jreq	L662
1767  02b6 a134          	cp	a,#52
1768  02b8 2716          	jreq	L662
1769  02ba a117          	cp	a,#23
1770  02bc 2712          	jreq	L662
1771  02be a106          	cp	a,#6
1772  02c0 270e          	jreq	L662
1773  02c2 ae016e        	ldw	x,#366
1774  02c5 89            	pushw	x
1775  02c6 5f            	clrw	x
1776  02c7 89            	pushw	x
1777  02c8 ae0000        	ldw	x,#L102
1778  02cb cd0000        	call	_assert_failed
1780  02ce 5b04          	addw	sp,#4
1781  02d0               L662:
1782                     ; 368     itpos = (uint8_t)((uint8_t)1 << ((uint8_t)SPI_IT & (uint8_t)0x0F));
1784  02d0 7b03          	ld	a,(OFST+1,sp)
1785  02d2 a40f          	and	a,#15
1786  02d4 5f            	clrw	x
1787  02d5 97            	ld	xl,a
1788  02d6 a601          	ld	a,#1
1789  02d8 5d            	tnzw	x
1790  02d9 2704          	jreq	L272
1791  02db               L472:
1792  02db 48            	sll	a
1793  02dc 5a            	decw	x
1794  02dd 26fc          	jrne	L472
1795  02df               L272:
1796  02df 6b01          	ld	(OFST-1,sp),a
1797                     ; 371     itmask1 = (uint8_t)((uint8_t)SPI_IT >> (uint8_t)4);
1799  02e1 7b03          	ld	a,(OFST+1,sp)
1800  02e3 4e            	swap	a
1801  02e4 a40f          	and	a,#15
1802  02e6 6b02          	ld	(OFST+0,sp),a
1803                     ; 373     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
1805  02e8 5f            	clrw	x
1806  02e9 97            	ld	xl,a
1807  02ea a601          	ld	a,#1
1808  02ec 5d            	tnzw	x
1809  02ed 2704          	jreq	L672
1810  02ef               L003:
1811  02ef 48            	sll	a
1812  02f0 5a            	decw	x
1813  02f1 26fc          	jrne	L003
1814  02f3               L672:
1815                     ; 375     enablestatus = (uint8_t)((uint8_t)SPI->SR & itmask2);
1817  02f3 c45203        	and	a,20995
1818  02f6 6b02          	ld	(OFST+0,sp),a
1819                     ; 377     if (((SPI->ICR & itpos) != RESET) && enablestatus)
1821  02f8 c65202        	ld	a,20994
1822  02fb 1501          	bcp	a,(OFST-1,sp)
1823  02fd 2708          	jreq	L156
1825  02ff 7b02          	ld	a,(OFST+0,sp)
1826  0301 2704          	jreq	L156
1827                     ; 380         pendingbitstatus = SET;
1829  0303 a601          	ld	a,#1
1831  0305 2001          	jra	L356
1832  0307               L156:
1833                     ; 385         pendingbitstatus = RESET;
1835  0307 4f            	clr	a
1836  0308               L356:
1837                     ; 388     return  pendingbitstatus;
1841  0308 5b03          	addw	sp,#3
1842  030a 81            	ret	
1886                     ; 404 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1886                     ; 405 {
1887                     	switch	.text
1888  030b               _SPI_ClearITPendingBit:
1890  030b 88            	push	a
1891  030c 88            	push	a
1892       00000001      OFST:	set	1
1895                     ; 406     uint8_t itpos = 0;
1897                     ; 407     assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1899  030d a145          	cp	a,#69
1900  030f 2712          	jreq	L013
1901  0311 a134          	cp	a,#52
1902  0313 270e          	jreq	L013
1903  0315 ae0197        	ldw	x,#407
1904  0318 89            	pushw	x
1905  0319 5f            	clrw	x
1906  031a 89            	pushw	x
1907  031b ae0000        	ldw	x,#L102
1908  031e cd0000        	call	_assert_failed
1910  0321 5b04          	addw	sp,#4
1911  0323               L013:
1912                     ; 412     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)(SPI_IT & (uint8_t)0xF0) >> 4));
1914  0323 7b02          	ld	a,(OFST+1,sp)
1915  0325 4e            	swap	a
1916  0326 a40f          	and	a,#15
1917  0328 5f            	clrw	x
1918  0329 97            	ld	xl,a
1919  032a a601          	ld	a,#1
1920  032c 5d            	tnzw	x
1921  032d 2704          	jreq	L413
1922  032f               L613:
1923  032f 48            	sll	a
1924  0330 5a            	decw	x
1925  0331 26fc          	jrne	L613
1926  0333               L413:
1927                     ; 414     SPI->SR = (uint8_t)(~itpos);
1929  0333 43            	cpl	a
1930  0334 c75203        	ld	20995,a
1931                     ; 416 }
1934  0337 85            	popw	x
1935  0338 81            	ret	
1948                     	xdef	_SPI_ClearITPendingBit
1949                     	xdef	_SPI_GetITStatus
1950                     	xdef	_SPI_ClearFlag
1951                     	xdef	_SPI_GetFlagStatus
1952                     	xdef	_SPI_BiDirectionalLineConfig
1953                     	xdef	_SPI_GetCRCPolynomial
1954                     	xdef	_SPI_ResetCRC
1955                     	xdef	_SPI_GetCRC
1956                     	xdef	_SPI_CalculateCRCCmd
1957                     	xdef	_SPI_TransmitCRC
1958                     	xdef	_SPI_NSSInternalSoftwareCmd
1959                     	xdef	_SPI_ReceiveData
1960                     	xdef	_SPI_SendData
1961                     	xdef	_SPI_ITConfig
1962                     	xdef	_SPI_Cmd
1963                     	xdef	_SPI_Init
1964                     	xdef	_SPI_DeInit
1965                     	xref	_assert_failed
1966                     .const:	section	.text
1967  0000               L102:
1968  0000 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
1969  0012 6965735c7374  	dc.b	"ies\stm8s_stdperip"
1970  0024 685f64726976  	dc.b	"h_driver\src\stm8s"
1971  0036 5f7370692e63  	dc.b	"_spi.c",0
1991                     	end
