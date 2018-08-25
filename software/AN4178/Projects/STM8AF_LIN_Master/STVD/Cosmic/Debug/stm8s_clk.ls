   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  19                     .const:	section	.text
  20  0000               _HSIDivFactor:
  21  0000 01            	dc.b	1
  22  0001 02            	dc.b	2
  23  0002 04            	dc.b	4
  24  0003 08            	dc.b	8
  25  0004               _CLKPrescTable:
  26  0004 01            	dc.b	1
  27  0005 02            	dc.b	2
  28  0006 04            	dc.b	4
  29  0007 08            	dc.b	8
  30  0008 0a            	dc.b	10
  31  0009 10            	dc.b	16
  32  000a 14            	dc.b	20
  33  000b 28            	dc.b	40
  62                     ; 66 void CLK_DeInit(void)
  62                     ; 67 {
  64                     	switch	.text
  65  0000               _CLK_DeInit:
  69                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  71  0000 350150c0      	mov	20672,#1
  72                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  74  0004 725f50c1      	clr	20673
  75                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  77  0008 35e150c4      	mov	20676,#225
  78                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  80  000c 725f50c5      	clr	20677
  81                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  83  0010 351850c6      	mov	20678,#24
  84                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  86  0014 35ff50c7      	mov	20679,#255
  87                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  89  0018 35ff50ca      	mov	20682,#255
  90                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  92  001c 725f50c8      	clr	20680
  93                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  95  0020 725f50c9      	clr	20681
  97  0024               L52:
  98                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
 100  0024 720050c9fb    	btjt	20681,#0,L52
 101                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 103  0029 725f50c9      	clr	20681
 104                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 106  002d 725f50cc      	clr	20684
 107                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 109  0031 725f50cd      	clr	20685
 110                     ; 84 }
 113  0035 81            	ret	
 170                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 170                     ; 96 {
 171                     	switch	.text
 172  0036               _CLK_FastHaltWakeUpCmd:
 174  0036 88            	push	a
 175       00000000      OFST:	set	0
 178                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 180  0037 4d            	tnz	a
 181  0038 2711          	jreq	L41
 182  003a 4a            	dec	a
 183  003b 270e          	jreq	L41
 184  003d ae0063        	ldw	x,#99
 185  0040 89            	pushw	x
 186  0041 5f            	clrw	x
 187  0042 89            	pushw	x
 188  0043 ae000c        	ldw	x,#L75
 189  0046 cd0000        	call	_assert_failed
 191  0049 5b04          	addw	sp,#4
 192  004b               L41:
 193                     ; 101     if (NewState != DISABLE)
 195  004b 7b01          	ld	a,(OFST+1,sp)
 196  004d 2706          	jreq	L16
 197                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 199  004f 721450c0      	bset	20672,#2
 201  0053 2004          	jra	L36
 202  0055               L16:
 203                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 205  0055 721550c0      	bres	20672,#2
 206  0059               L36:
 207                     ; 112 }
 210  0059 84            	pop	a
 211  005a 81            	ret	
 247                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 247                     ; 120 {
 248                     	switch	.text
 249  005b               _CLK_HSECmd:
 251  005b 88            	push	a
 252       00000000      OFST:	set	0
 255                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 257  005c 4d            	tnz	a
 258  005d 2711          	jreq	L62
 259  005f 4a            	dec	a
 260  0060 270e          	jreq	L62
 261  0062 ae007b        	ldw	x,#123
 262  0065 89            	pushw	x
 263  0066 5f            	clrw	x
 264  0067 89            	pushw	x
 265  0068 ae000c        	ldw	x,#L75
 266  006b cd0000        	call	_assert_failed
 268  006e 5b04          	addw	sp,#4
 269  0070               L62:
 270                     ; 125     if (NewState != DISABLE)
 272  0070 7b01          	ld	a,(OFST+1,sp)
 273  0072 2706          	jreq	L301
 274                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 276  0074 721050c1      	bset	20673,#0
 278  0078 2004          	jra	L501
 279  007a               L301:
 280                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 282  007a 721150c1      	bres	20673,#0
 283  007e               L501:
 284                     ; 136 }
 287  007e 84            	pop	a
 288  007f 81            	ret	
 324                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 324                     ; 144 {
 325                     	switch	.text
 326  0080               _CLK_HSICmd:
 328  0080 88            	push	a
 329       00000000      OFST:	set	0
 332                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 334  0081 4d            	tnz	a
 335  0082 2711          	jreq	L04
 336  0084 4a            	dec	a
 337  0085 270e          	jreq	L04
 338  0087 ae0093        	ldw	x,#147
 339  008a 89            	pushw	x
 340  008b 5f            	clrw	x
 341  008c 89            	pushw	x
 342  008d ae000c        	ldw	x,#L75
 343  0090 cd0000        	call	_assert_failed
 345  0093 5b04          	addw	sp,#4
 346  0095               L04:
 347                     ; 149     if (NewState != DISABLE)
 349  0095 7b01          	ld	a,(OFST+1,sp)
 350  0097 2706          	jreq	L521
 351                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 353  0099 721050c0      	bset	20672,#0
 355  009d 2004          	jra	L721
 356  009f               L521:
 357                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 359  009f 721150c0      	bres	20672,#0
 360  00a3               L721:
 361                     ; 160 }
 364  00a3 84            	pop	a
 365  00a4 81            	ret	
 401                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 401                     ; 168 {
 402                     	switch	.text
 403  00a5               _CLK_LSICmd:
 405  00a5 88            	push	a
 406       00000000      OFST:	set	0
 409                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 411  00a6 4d            	tnz	a
 412  00a7 2711          	jreq	L25
 413  00a9 4a            	dec	a
 414  00aa 270e          	jreq	L25
 415  00ac ae00ab        	ldw	x,#171
 416  00af 89            	pushw	x
 417  00b0 5f            	clrw	x
 418  00b1 89            	pushw	x
 419  00b2 ae000c        	ldw	x,#L75
 420  00b5 cd0000        	call	_assert_failed
 422  00b8 5b04          	addw	sp,#4
 423  00ba               L25:
 424                     ; 173     if (NewState != DISABLE)
 426  00ba 7b01          	ld	a,(OFST+1,sp)
 427  00bc 2706          	jreq	L741
 428                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 430  00be 721650c0      	bset	20672,#3
 432  00c2 2004          	jra	L151
 433  00c4               L741:
 434                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 436  00c4 721750c0      	bres	20672,#3
 437  00c8               L151:
 438                     ; 184 }
 441  00c8 84            	pop	a
 442  00c9 81            	ret	
 478                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 478                     ; 193 {
 479                     	switch	.text
 480  00ca               _CLK_CCOCmd:
 482  00ca 88            	push	a
 483       00000000      OFST:	set	0
 486                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 488  00cb 4d            	tnz	a
 489  00cc 2711          	jreq	L46
 490  00ce 4a            	dec	a
 491  00cf 270e          	jreq	L46
 492  00d1 ae00c4        	ldw	x,#196
 493  00d4 89            	pushw	x
 494  00d5 5f            	clrw	x
 495  00d6 89            	pushw	x
 496  00d7 ae000c        	ldw	x,#L75
 497  00da cd0000        	call	_assert_failed
 499  00dd 5b04          	addw	sp,#4
 500  00df               L46:
 501                     ; 198     if (NewState != DISABLE)
 503  00df 7b01          	ld	a,(OFST+1,sp)
 504  00e1 2706          	jreq	L171
 505                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 507  00e3 721050c9      	bset	20681,#0
 509  00e7 2004          	jra	L371
 510  00e9               L171:
 511                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 513  00e9 721150c9      	bres	20681,#0
 514  00ed               L371:
 515                     ; 209 }
 518  00ed 84            	pop	a
 519  00ee 81            	ret	
 555                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 555                     ; 219 {
 556                     	switch	.text
 557  00ef               _CLK_ClockSwitchCmd:
 559  00ef 88            	push	a
 560       00000000      OFST:	set	0
 563                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 565  00f0 4d            	tnz	a
 566  00f1 2711          	jreq	L67
 567  00f3 4a            	dec	a
 568  00f4 270e          	jreq	L67
 569  00f6 ae00de        	ldw	x,#222
 570  00f9 89            	pushw	x
 571  00fa 5f            	clrw	x
 572  00fb 89            	pushw	x
 573  00fc ae000c        	ldw	x,#L75
 574  00ff cd0000        	call	_assert_failed
 576  0102 5b04          	addw	sp,#4
 577  0104               L67:
 578                     ; 224     if (NewState != DISABLE )
 580  0104 7b01          	ld	a,(OFST+1,sp)
 581  0106 2706          	jreq	L312
 582                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 584  0108 721250c5      	bset	20677,#1
 586  010c 2004          	jra	L512
 587  010e               L312:
 588                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 590  010e 721350c5      	bres	20677,#1
 591  0112               L512:
 592                     ; 235 }
 595  0112 84            	pop	a
 596  0113 81            	ret	
 633                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 633                     ; 246 {
 634                     	switch	.text
 635  0114               _CLK_SlowActiveHaltWakeUpCmd:
 637  0114 88            	push	a
 638       00000000      OFST:	set	0
 641                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 643  0115 4d            	tnz	a
 644  0116 2711          	jreq	L011
 645  0118 4a            	dec	a
 646  0119 270e          	jreq	L011
 647  011b ae00f9        	ldw	x,#249
 648  011e 89            	pushw	x
 649  011f 5f            	clrw	x
 650  0120 89            	pushw	x
 651  0121 ae000c        	ldw	x,#L75
 652  0124 cd0000        	call	_assert_failed
 654  0127 5b04          	addw	sp,#4
 655  0129               L011:
 656                     ; 251     if (NewState != DISABLE)
 658  0129 7b01          	ld	a,(OFST+1,sp)
 659  012b 2706          	jreq	L532
 660                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 662  012d 721a50c0      	bset	20672,#5
 664  0131 2004          	jra	L732
 665  0133               L532:
 666                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 668  0133 721b50c0      	bres	20672,#5
 669  0137               L732:
 670                     ; 262 }
 673  0137 84            	pop	a
 674  0138 81            	ret	
 834                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 834                     ; 273 {
 835                     	switch	.text
 836  0139               _CLK_PeripheralClockConfig:
 838  0139 89            	pushw	x
 839       00000000      OFST:	set	0
 842                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 844  013a 9f            	ld	a,xl
 845  013b 4d            	tnz	a
 846  013c 2712          	jreq	L221
 847  013e 9f            	ld	a,xl
 848  013f 4a            	dec	a
 849  0140 270e          	jreq	L221
 850  0142 ae0114        	ldw	x,#276
 851  0145 89            	pushw	x
 852  0146 5f            	clrw	x
 853  0147 89            	pushw	x
 854  0148 ae000c        	ldw	x,#L75
 855  014b cd0000        	call	_assert_failed
 857  014e 5b04          	addw	sp,#4
 858  0150               L221:
 859                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 861  0150 7b01          	ld	a,(OFST+1,sp)
 862  0152 273c          	jreq	L231
 863  0154 a101          	cp	a,#1
 864  0156 2738          	jreq	L231
 865  0158 a103          	cp	a,#3
 866  015a 2734          	jreq	L231
 867  015c a102          	cp	a,#2
 868  015e 2730          	jreq	L231
 869  0160 a104          	cp	a,#4
 870  0162 272c          	jreq	L231
 871  0164 a105          	cp	a,#5
 872  0166 2728          	jreq	L231
 873  0168 a104          	cp	a,#4
 874  016a 2724          	jreq	L231
 875  016c a106          	cp	a,#6
 876  016e 2720          	jreq	L231
 877  0170 a107          	cp	a,#7
 878  0172 271c          	jreq	L231
 879  0174 a117          	cp	a,#23
 880  0176 2718          	jreq	L231
 881  0178 a113          	cp	a,#19
 882  017a 2714          	jreq	L231
 883  017c a112          	cp	a,#18
 884  017e 2710          	jreq	L231
 885  0180 ae0115        	ldw	x,#277
 886  0183 89            	pushw	x
 887  0184 5f            	clrw	x
 888  0185 89            	pushw	x
 889  0186 ae000c        	ldw	x,#L75
 890  0189 cd0000        	call	_assert_failed
 892  018c 5b04          	addw	sp,#4
 893  018e 7b01          	ld	a,(OFST+1,sp)
 894  0190               L231:
 895                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 897  0190 a510          	bcp	a,#16
 898  0192 262c          	jrne	L323
 899                     ; 281         if (NewState != DISABLE)
 901  0194 0d02          	tnz	(OFST+2,sp)
 902  0196 2712          	jreq	L523
 903                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 905  0198 a40f          	and	a,#15
 906  019a 5f            	clrw	x
 907  019b 97            	ld	xl,a
 908  019c a601          	ld	a,#1
 909  019e 5d            	tnzw	x
 910  019f 2704          	jreq	L631
 911  01a1               L041:
 912  01a1 48            	sll	a
 913  01a2 5a            	decw	x
 914  01a3 26fc          	jrne	L041
 915  01a5               L631:
 916  01a5 ca50c7        	or	a,20679
 918  01a8 2011          	jp	LC002
 919  01aa               L523:
 920                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 922  01aa a40f          	and	a,#15
 923  01ac 5f            	clrw	x
 924  01ad 97            	ld	xl,a
 925  01ae a601          	ld	a,#1
 926  01b0 5d            	tnzw	x
 927  01b1 2704          	jreq	L241
 928  01b3               L441:
 929  01b3 48            	sll	a
 930  01b4 5a            	decw	x
 931  01b5 26fc          	jrne	L441
 932  01b7               L241:
 933  01b7 43            	cpl	a
 934  01b8 c450c7        	and	a,20679
 935  01bb               LC002:
 936  01bb c750c7        	ld	20679,a
 937  01be 202a          	jra	L133
 938  01c0               L323:
 939                     ; 294         if (NewState != DISABLE)
 941  01c0 0d02          	tnz	(OFST+2,sp)
 942  01c2 2712          	jreq	L333
 943                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 945  01c4 a40f          	and	a,#15
 946  01c6 5f            	clrw	x
 947  01c7 97            	ld	xl,a
 948  01c8 a601          	ld	a,#1
 949  01ca 5d            	tnzw	x
 950  01cb 2704          	jreq	L641
 951  01cd               L051:
 952  01cd 48            	sll	a
 953  01ce 5a            	decw	x
 954  01cf 26fc          	jrne	L051
 955  01d1               L641:
 956  01d1 ca50ca        	or	a,20682
 958  01d4 2011          	jp	LC001
 959  01d6               L333:
 960                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 962  01d6 a40f          	and	a,#15
 963  01d8 5f            	clrw	x
 964  01d9 97            	ld	xl,a
 965  01da a601          	ld	a,#1
 966  01dc 5d            	tnzw	x
 967  01dd 2704          	jreq	L251
 968  01df               L451:
 969  01df 48            	sll	a
 970  01e0 5a            	decw	x
 971  01e1 26fc          	jrne	L451
 972  01e3               L251:
 973  01e3 43            	cpl	a
 974  01e4 c450ca        	and	a,20682
 975  01e7               LC001:
 976  01e7 c750ca        	ld	20682,a
 977  01ea               L133:
 978                     ; 306 }
 981  01ea 85            	popw	x
 982  01eb 81            	ret	
1169                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1169                     ; 320 {
1170                     	switch	.text
1171  01ec               _CLK_ClockSwitchConfig:
1173  01ec 89            	pushw	x
1174  01ed 5204          	subw	sp,#4
1175       00000004      OFST:	set	4
1178                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1180  01ef ae0491        	ldw	x,#1169
1181  01f2 1f03          	ldw	(OFST-1,sp),x
1182                     ; 324     ErrorStatus Swif = ERROR;
1184                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1186  01f4 7b06          	ld	a,(OFST+2,sp)
1187  01f6 a1e1          	cp	a,#225
1188  01f8 2716          	jreq	L461
1189  01fa a1d2          	cp	a,#210
1190  01fc 2712          	jreq	L461
1191  01fe a1b4          	cp	a,#180
1192  0200 270e          	jreq	L461
1193  0202 ae0147        	ldw	x,#327
1194  0205 89            	pushw	x
1195  0206 5f            	clrw	x
1196  0207 89            	pushw	x
1197  0208 ae000c        	ldw	x,#L75
1198  020b cd0000        	call	_assert_failed
1200  020e 5b04          	addw	sp,#4
1201  0210               L461:
1202                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1204  0210 7b05          	ld	a,(OFST+1,sp)
1205  0212 2711          	jreq	L471
1206  0214 4a            	dec	a
1207  0215 270e          	jreq	L471
1208  0217 ae0148        	ldw	x,#328
1209  021a 89            	pushw	x
1210  021b 5f            	clrw	x
1211  021c 89            	pushw	x
1212  021d ae000c        	ldw	x,#L75
1213  0220 cd0000        	call	_assert_failed
1215  0223 5b04          	addw	sp,#4
1216  0225               L471:
1217                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1219  0225 7b09          	ld	a,(OFST+5,sp)
1220  0227 2711          	jreq	L402
1221  0229 4a            	dec	a
1222  022a 270e          	jreq	L402
1223  022c ae0149        	ldw	x,#329
1224  022f 89            	pushw	x
1225  0230 5f            	clrw	x
1226  0231 89            	pushw	x
1227  0232 ae000c        	ldw	x,#L75
1228  0235 cd0000        	call	_assert_failed
1230  0238 5b04          	addw	sp,#4
1231  023a               L402:
1232                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1234  023a 7b0a          	ld	a,(OFST+6,sp)
1235  023c 2711          	jreq	L412
1236  023e 4a            	dec	a
1237  023f 270e          	jreq	L412
1238  0241 ae014a        	ldw	x,#330
1239  0244 89            	pushw	x
1240  0245 5f            	clrw	x
1241  0246 89            	pushw	x
1242  0247 ae000c        	ldw	x,#L75
1243  024a cd0000        	call	_assert_failed
1245  024d 5b04          	addw	sp,#4
1246  024f               L412:
1247                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1249  024f c650c3        	ld	a,20675
1250  0252 6b01          	ld	(OFST-3,sp),a
1251                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1253  0254 7b05          	ld	a,(OFST+1,sp)
1254  0256 4a            	dec	a
1255  0257 262d          	jrne	L544
1256                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1258  0259 721250c5      	bset	20677,#1
1259                     ; 343         if (ITState != DISABLE)
1261  025d 7b09          	ld	a,(OFST+5,sp)
1262  025f 2706          	jreq	L744
1263                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1265  0261 721450c5      	bset	20677,#2
1267  0265 2004          	jra	L154
1268  0267               L744:
1269                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1271  0267 721550c5      	bres	20677,#2
1272  026b               L154:
1273                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1275  026b 7b06          	ld	a,(OFST+2,sp)
1276  026d c750c4        	ld	20676,a
1278  0270 2003          	jra	L754
1279  0272               L354:
1280                     ; 357             DownCounter--;
1282  0272 5a            	decw	x
1283  0273 1f03          	ldw	(OFST-1,sp),x
1284  0275               L754:
1285                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1287  0275 720150c504    	btjf	20677,#0,L364
1289  027a 1e03          	ldw	x,(OFST-1,sp)
1290  027c 26f4          	jrne	L354
1291  027e               L364:
1292                     ; 360         if (DownCounter != 0)
1294  027e 1e03          	ldw	x,(OFST-1,sp)
1295                     ; 362             Swif = SUCCESS;
1297  0280 2617          	jrne	LC003
1298                     ; 366             Swif = ERROR;
1300  0282 0f02          	clr	(OFST-2,sp)
1301  0284 2017          	jra	L174
1302  0286               L544:
1303                     ; 374         if (ITState != DISABLE)
1305  0286 7b09          	ld	a,(OFST+5,sp)
1306  0288 2706          	jreq	L374
1307                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1309  028a 721450c5      	bset	20677,#2
1311  028e 2004          	jra	L574
1312  0290               L374:
1313                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1315  0290 721550c5      	bres	20677,#2
1316  0294               L574:
1317                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1319  0294 7b06          	ld	a,(OFST+2,sp)
1320  0296 c750c4        	ld	20676,a
1321                     ; 388         Swif = SUCCESS;
1323  0299               LC003:
1325  0299 a601          	ld	a,#1
1326  029b 6b02          	ld	(OFST-2,sp),a
1327  029d               L174:
1328                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1330  029d 7b0a          	ld	a,(OFST+6,sp)
1331  029f 260c          	jrne	L774
1333  02a1 7b01          	ld	a,(OFST-3,sp)
1334  02a3 a1e1          	cp	a,#225
1335  02a5 2606          	jrne	L774
1336                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1338  02a7 721150c0      	bres	20672,#0
1340  02ab 201e          	jra	L105
1341  02ad               L774:
1342                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1344  02ad 7b0a          	ld	a,(OFST+6,sp)
1345  02af 260c          	jrne	L305
1347  02b1 7b01          	ld	a,(OFST-3,sp)
1348  02b3 a1d2          	cp	a,#210
1349  02b5 2606          	jrne	L305
1350                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1352  02b7 721750c0      	bres	20672,#3
1354  02bb 200e          	jra	L105
1355  02bd               L305:
1356                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1358  02bd 7b0a          	ld	a,(OFST+6,sp)
1359  02bf 260a          	jrne	L105
1361  02c1 7b01          	ld	a,(OFST-3,sp)
1362  02c3 a1b4          	cp	a,#180
1363  02c5 2604          	jrne	L105
1364                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1366  02c7 721150c1      	bres	20673,#0
1367  02cb               L105:
1368                     ; 406     return(Swif);
1370  02cb 7b02          	ld	a,(OFST-2,sp)
1373  02cd 5b06          	addw	sp,#6
1374  02cf 81            	ret	
1513                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1513                     ; 417 {
1514                     	switch	.text
1515  02d0               _CLK_HSIPrescalerConfig:
1517  02d0 88            	push	a
1518       00000000      OFST:	set	0
1521                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1523  02d1 4d            	tnz	a
1524  02d2 271a          	jreq	L622
1525  02d4 a108          	cp	a,#8
1526  02d6 2716          	jreq	L622
1527  02d8 a110          	cp	a,#16
1528  02da 2712          	jreq	L622
1529  02dc a118          	cp	a,#24
1530  02de 270e          	jreq	L622
1531  02e0 ae01a4        	ldw	x,#420
1532  02e3 89            	pushw	x
1533  02e4 5f            	clrw	x
1534  02e5 89            	pushw	x
1535  02e6 ae000c        	ldw	x,#L75
1536  02e9 cd0000        	call	_assert_failed
1538  02ec 5b04          	addw	sp,#4
1539  02ee               L622:
1540                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1542  02ee c650c6        	ld	a,20678
1543  02f1 a4e7          	and	a,#231
1544  02f3 c750c6        	ld	20678,a
1545                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1547  02f6 c650c6        	ld	a,20678
1548  02f9 1a01          	or	a,(OFST+1,sp)
1549  02fb c750c6        	ld	20678,a
1550                     ; 428 }
1553  02fe 84            	pop	a
1554  02ff 81            	ret	
1690                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1690                     ; 440 {
1691                     	switch	.text
1692  0300               _CLK_CCOConfig:
1694  0300 88            	push	a
1695       00000000      OFST:	set	0
1698                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1700  0301 4d            	tnz	a
1701  0302 273e          	jreq	L042
1702  0304 a104          	cp	a,#4
1703  0306 273a          	jreq	L042
1704  0308 a102          	cp	a,#2
1705  030a 2736          	jreq	L042
1706  030c a108          	cp	a,#8
1707  030e 2732          	jreq	L042
1708  0310 a10a          	cp	a,#10
1709  0312 272e          	jreq	L042
1710  0314 a10c          	cp	a,#12
1711  0316 272a          	jreq	L042
1712  0318 a10e          	cp	a,#14
1713  031a 2726          	jreq	L042
1714  031c a110          	cp	a,#16
1715  031e 2722          	jreq	L042
1716  0320 a112          	cp	a,#18
1717  0322 271e          	jreq	L042
1718  0324 a114          	cp	a,#20
1719  0326 271a          	jreq	L042
1720  0328 a116          	cp	a,#22
1721  032a 2716          	jreq	L042
1722  032c a118          	cp	a,#24
1723  032e 2712          	jreq	L042
1724  0330 a11a          	cp	a,#26
1725  0332 270e          	jreq	L042
1726  0334 ae01bb        	ldw	x,#443
1727  0337 89            	pushw	x
1728  0338 5f            	clrw	x
1729  0339 89            	pushw	x
1730  033a ae000c        	ldw	x,#L75
1731  033d cd0000        	call	_assert_failed
1733  0340 5b04          	addw	sp,#4
1734  0342               L042:
1735                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1737  0342 c650c9        	ld	a,20681
1738  0345 a4e1          	and	a,#225
1739  0347 c750c9        	ld	20681,a
1740                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1742  034a c650c9        	ld	a,20681
1743  034d 1a01          	or	a,(OFST+1,sp)
1744  034f c750c9        	ld	20681,a
1745                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1747                     ; 454 }
1750  0352 84            	pop	a
1751  0353 721050c9      	bset	20681,#0
1752  0357 81            	ret	
1818                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1818                     ; 465 {
1819                     	switch	.text
1820  0358               _CLK_ITConfig:
1822  0358 89            	pushw	x
1823       00000000      OFST:	set	0
1826                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1828  0359 9f            	ld	a,xl
1829  035a 4d            	tnz	a
1830  035b 2712          	jreq	L252
1831  035d 9f            	ld	a,xl
1832  035e 4a            	dec	a
1833  035f 270e          	jreq	L252
1834  0361 ae01d4        	ldw	x,#468
1835  0364 89            	pushw	x
1836  0365 5f            	clrw	x
1837  0366 89            	pushw	x
1838  0367 ae000c        	ldw	x,#L75
1839  036a cd0000        	call	_assert_failed
1841  036d 5b04          	addw	sp,#4
1842  036f               L252:
1843                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1845  036f 7b01          	ld	a,(OFST+1,sp)
1846  0371 a10c          	cp	a,#12
1847  0373 2712          	jreq	L262
1848  0375 a11c          	cp	a,#28
1849  0377 270e          	jreq	L262
1850  0379 ae01d5        	ldw	x,#469
1851  037c 89            	pushw	x
1852  037d 5f            	clrw	x
1853  037e 89            	pushw	x
1854  037f ae000c        	ldw	x,#L75
1855  0382 cd0000        	call	_assert_failed
1857  0385 5b04          	addw	sp,#4
1858  0387               L262:
1859                     ; 471     if (NewState != DISABLE)
1861  0387 7b02          	ld	a,(OFST+2,sp)
1862  0389 2716          	jreq	L507
1863                     ; 473         switch (CLK_IT)
1865  038b 7b01          	ld	a,(OFST+1,sp)
1867                     ; 481         default:
1867                     ; 482             break;
1868  038d a00c          	sub	a,#12
1869  038f 270a          	jreq	L146
1870  0391 a010          	sub	a,#16
1871  0393 2620          	jrne	L317
1872                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1872                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1874  0395 721450c5      	bset	20677,#2
1875                     ; 477             break;
1877  0399 201a          	jra	L317
1878  039b               L146:
1879                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1879                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1881  039b 721450c8      	bset	20680,#2
1882                     ; 480             break;
1884  039f 2014          	jra	L317
1885                     ; 481         default:
1885                     ; 482             break;
1888  03a1               L507:
1889                     ; 487         switch (CLK_IT)
1891  03a1 7b01          	ld	a,(OFST+1,sp)
1893                     ; 495         default:
1893                     ; 496             break;
1894  03a3 a00c          	sub	a,#12
1895  03a5 270a          	jreq	L746
1896  03a7 a010          	sub	a,#16
1897  03a9 260a          	jrne	L317
1898                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1898                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1900  03ab 721550c5      	bres	20677,#2
1901                     ; 491             break;
1903  03af 2004          	jra	L317
1904  03b1               L746:
1905                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1905                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1907  03b1 721550c8      	bres	20680,#2
1908                     ; 494             break;
1909  03b5               L317:
1910                     ; 500 }
1913  03b5 85            	popw	x
1914  03b6 81            	ret	
1915                     ; 495         default:
1915                     ; 496             break;
1952                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1952                     ; 508 {
1953                     	switch	.text
1954  03b7               _CLK_SYSCLKConfig:
1956  03b7 88            	push	a
1957       00000000      OFST:	set	0
1960                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1962  03b8 4d            	tnz	a
1963  03b9 273a          	jreq	L472
1964  03bb a108          	cp	a,#8
1965  03bd 2736          	jreq	L472
1966  03bf a110          	cp	a,#16
1967  03c1 2732          	jreq	L472
1968  03c3 a118          	cp	a,#24
1969  03c5 272e          	jreq	L472
1970  03c7 a180          	cp	a,#128
1971  03c9 272a          	jreq	L472
1972  03cb a181          	cp	a,#129
1973  03cd 2726          	jreq	L472
1974  03cf a182          	cp	a,#130
1975  03d1 2722          	jreq	L472
1976  03d3 a183          	cp	a,#131
1977  03d5 271e          	jreq	L472
1978  03d7 a184          	cp	a,#132
1979  03d9 271a          	jreq	L472
1980  03db a185          	cp	a,#133
1981  03dd 2716          	jreq	L472
1982  03df a186          	cp	a,#134
1983  03e1 2712          	jreq	L472
1984  03e3 a187          	cp	a,#135
1985  03e5 270e          	jreq	L472
1986  03e7 ae01ff        	ldw	x,#511
1987  03ea 89            	pushw	x
1988  03eb 5f            	clrw	x
1989  03ec 89            	pushw	x
1990  03ed ae000c        	ldw	x,#L75
1991  03f0 cd0000        	call	_assert_failed
1993  03f3 5b04          	addw	sp,#4
1994  03f5               L472:
1995                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1997  03f5 7b01          	ld	a,(OFST+1,sp)
1998  03f7 2b0e          	jrmi	L737
1999                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
2001  03f9 c650c6        	ld	a,20678
2002  03fc a4e7          	and	a,#231
2003  03fe c750c6        	ld	20678,a
2004                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
2006  0401 7b01          	ld	a,(OFST+1,sp)
2007  0403 a418          	and	a,#24
2009  0405 200c          	jra	L147
2010  0407               L737:
2011                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
2013  0407 c650c6        	ld	a,20678
2014  040a a4f8          	and	a,#248
2015  040c c750c6        	ld	20678,a
2016                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
2018  040f 7b01          	ld	a,(OFST+1,sp)
2019  0411 a407          	and	a,#7
2020  0413               L147:
2021  0413 ca50c6        	or	a,20678
2022  0416 c750c6        	ld	20678,a
2023                     ; 524 }
2026  0419 84            	pop	a
2027  041a 81            	ret	
2084                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
2084                     ; 532 {
2085                     	switch	.text
2086  041b               _CLK_SWIMConfig:
2088  041b 88            	push	a
2089       00000000      OFST:	set	0
2092                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
2094  041c 4d            	tnz	a
2095  041d 2711          	jreq	L603
2096  041f 4a            	dec	a
2097  0420 270e          	jreq	L603
2098  0422 ae0217        	ldw	x,#535
2099  0425 89            	pushw	x
2100  0426 5f            	clrw	x
2101  0427 89            	pushw	x
2102  0428 ae000c        	ldw	x,#L75
2103  042b cd0000        	call	_assert_failed
2105  042e 5b04          	addw	sp,#4
2106  0430               L603:
2107                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
2109  0430 7b01          	ld	a,(OFST+1,sp)
2110  0432 2706          	jreq	L177
2111                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
2113  0434 721050cd      	bset	20685,#0
2115  0438 2004          	jra	L377
2116  043a               L177:
2117                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
2119  043a 721150cd      	bres	20685,#0
2120  043e               L377:
2121                     ; 548 }
2124  043e 84            	pop	a
2125  043f 81            	ret	
2149                     ; 557 void CLK_ClockSecuritySystemEnable(void)
2149                     ; 558 {
2150                     	switch	.text
2151  0440               _CLK_ClockSecuritySystemEnable:
2155                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
2157  0440 721050c8      	bset	20680,#0
2158                     ; 561 }
2161  0444 81            	ret	
2186                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
2186                     ; 570 {
2187                     	switch	.text
2188  0445               _CLK_GetSYSCLKSource:
2192                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
2194  0445 c650c3        	ld	a,20675
2197  0448 81            	ret	
2254                     ; 579 uint32_t CLK_GetClockFreq(void)
2254                     ; 580 {
2255                     	switch	.text
2256  0449               _CLK_GetClockFreq:
2258  0449 5209          	subw	sp,#9
2259       00000009      OFST:	set	9
2262                     ; 582     uint32_t clockfrequency = 0;
2264                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
2266                     ; 584     uint8_t tmp = 0, presc = 0;
2270                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
2272  044b c650c3        	ld	a,20675
2273  044e 6b09          	ld	(OFST+0,sp),a
2274                     ; 589     if (clocksource == CLK_SOURCE_HSI)
2276  0450 a1e1          	cp	a,#225
2277  0452 2634          	jrne	L1401
2278                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
2280  0454 c650c6        	ld	a,20678
2281  0457 a418          	and	a,#24
2282  0459 44            	srl	a
2283  045a 44            	srl	a
2284  045b 44            	srl	a
2285                     ; 592         tmp = (uint8_t)(tmp >> 3);
2287                     ; 593         presc = HSIDivFactor[tmp];
2289  045c 5f            	clrw	x
2290  045d 97            	ld	xl,a
2291  045e d60000        	ld	a,(_HSIDivFactor,x)
2292  0461 6b09          	ld	(OFST+0,sp),a
2293                     ; 594         clockfrequency = HSI_VALUE / presc;
2295  0463 b703          	ld	c_lreg+3,a
2296  0465 3f02          	clr	c_lreg+2
2297  0467 3f01          	clr	c_lreg+1
2298  0469 3f00          	clr	c_lreg
2299  046b 96            	ldw	x,sp
2300  046c 5c            	incw	x
2301  046d cd0000        	call	c_rtol
2303  0470 ae2400        	ldw	x,#9216
2304  0473 bf02          	ldw	c_lreg+2,x
2305  0475 ae00f4        	ldw	x,#244
2306  0478 bf00          	ldw	c_lreg,x
2307  047a 96            	ldw	x,sp
2308  047b 5c            	incw	x
2309  047c cd0000        	call	c_ludv
2311  047f 96            	ldw	x,sp
2312  0480 1c0005        	addw	x,#OFST-4
2313  0483 cd0000        	call	c_rtol
2316  0486 2018          	jra	L3401
2317  0488               L1401:
2318                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
2320  0488 a1d2          	cp	a,#210
2321  048a 260a          	jrne	L5401
2322                     ; 598         clockfrequency = LSI_VALUE;
2324  048c aef400        	ldw	x,#62464
2325  048f 1f07          	ldw	(OFST-2,sp),x
2326  0491 ae0001        	ldw	x,#1
2328  0494 2008          	jp	LC004
2329  0496               L5401:
2330                     ; 602         clockfrequency = HSE_VALUE;
2332  0496 ae2400        	ldw	x,#9216
2333  0499 1f07          	ldw	(OFST-2,sp),x
2334  049b ae00f4        	ldw	x,#244
2335  049e               LC004:
2336  049e 1f05          	ldw	(OFST-4,sp),x
2337  04a0               L3401:
2338                     ; 605     return((uint32_t)clockfrequency);
2340  04a0 96            	ldw	x,sp
2341  04a1 1c0005        	addw	x,#OFST-4
2342  04a4 cd0000        	call	c_ltor
2346  04a7 5b09          	addw	sp,#9
2347  04a9 81            	ret	
2447                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2447                     ; 617 {
2448                     	switch	.text
2449  04aa               _CLK_AdjustHSICalibrationValue:
2451  04aa 88            	push	a
2452       00000000      OFST:	set	0
2455                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2457  04ab 4d            	tnz	a
2458  04ac 272a          	jreq	L623
2459  04ae a101          	cp	a,#1
2460  04b0 2726          	jreq	L623
2461  04b2 a102          	cp	a,#2
2462  04b4 2722          	jreq	L623
2463  04b6 a103          	cp	a,#3
2464  04b8 271e          	jreq	L623
2465  04ba a104          	cp	a,#4
2466  04bc 271a          	jreq	L623
2467  04be a105          	cp	a,#5
2468  04c0 2716          	jreq	L623
2469  04c2 a106          	cp	a,#6
2470  04c4 2712          	jreq	L623
2471  04c6 a107          	cp	a,#7
2472  04c8 270e          	jreq	L623
2473  04ca ae026c        	ldw	x,#620
2474  04cd 89            	pushw	x
2475  04ce 5f            	clrw	x
2476  04cf 89            	pushw	x
2477  04d0 ae000c        	ldw	x,#L75
2478  04d3 cd0000        	call	_assert_failed
2480  04d6 5b04          	addw	sp,#4
2481  04d8               L623:
2482                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2484  04d8 c650cc        	ld	a,20684
2485  04db a4f8          	and	a,#248
2486  04dd 1a01          	or	a,(OFST+1,sp)
2487  04df c750cc        	ld	20684,a
2488                     ; 625 }
2491  04e2 84            	pop	a
2492  04e3 81            	ret	
2516                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2516                     ; 637 {
2517                     	switch	.text
2518  04e4               _CLK_SYSCLKEmergencyClear:
2522                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2524  04e4 721150c5      	bres	20677,#0
2525                     ; 639 }
2528  04e8 81            	ret	
2678                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2678                     ; 649 {
2679                     	switch	.text
2680  04e9               _CLK_GetFlagStatus:
2682  04e9 89            	pushw	x
2683  04ea 5203          	subw	sp,#3
2684       00000003      OFST:	set	3
2687                     ; 651     uint16_t statusreg = 0;
2689                     ; 652     uint8_t tmpreg = 0;
2691                     ; 653     FlagStatus bitstatus = RESET;
2693                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2695  04ec a30110        	cpw	x,#272
2696  04ef 2736          	jreq	L243
2697  04f1 a30102        	cpw	x,#258
2698  04f4 2731          	jreq	L243
2699  04f6 a30202        	cpw	x,#514
2700  04f9 272c          	jreq	L243
2701  04fb a30308        	cpw	x,#776
2702  04fe 2727          	jreq	L243
2703  0500 a30301        	cpw	x,#769
2704  0503 2722          	jreq	L243
2705  0505 a30408        	cpw	x,#1032
2706  0508 271d          	jreq	L243
2707  050a a30402        	cpw	x,#1026
2708  050d 2718          	jreq	L243
2709  050f a30504        	cpw	x,#1284
2710  0512 2713          	jreq	L243
2711  0514 a30502        	cpw	x,#1282
2712  0517 270e          	jreq	L243
2713  0519 ae0290        	ldw	x,#656
2714  051c 89            	pushw	x
2715  051d 5f            	clrw	x
2716  051e 89            	pushw	x
2717  051f ae000c        	ldw	x,#L75
2718  0522 cd0000        	call	_assert_failed
2720  0525 5b04          	addw	sp,#4
2721  0527               L243:
2722                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2724  0527 7b04          	ld	a,(OFST+1,sp)
2725  0529 97            	ld	xl,a
2726  052a 4f            	clr	a
2727  052b 02            	rlwa	x,a
2728  052c 1f01          	ldw	(OFST-2,sp),x
2729                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2731  052e a30100        	cpw	x,#256
2732  0531 2605          	jrne	L7021
2733                     ; 664         tmpreg = CLK->ICKR;
2735  0533 c650c0        	ld	a,20672
2737  0536 2021          	jra	L1121
2738  0538               L7021:
2739                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2741  0538 a30200        	cpw	x,#512
2742  053b 2605          	jrne	L3121
2743                     ; 668         tmpreg = CLK->ECKR;
2745  053d c650c1        	ld	a,20673
2747  0540 2017          	jra	L1121
2748  0542               L3121:
2749                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2751  0542 a30300        	cpw	x,#768
2752  0545 2605          	jrne	L7121
2753                     ; 672         tmpreg = CLK->SWCR;
2755  0547 c650c5        	ld	a,20677
2757  054a 200d          	jra	L1121
2758  054c               L7121:
2759                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2761  054c a30400        	cpw	x,#1024
2762  054f 2605          	jrne	L3221
2763                     ; 676         tmpreg = CLK->CSSR;
2765  0551 c650c8        	ld	a,20680
2767  0554 2003          	jra	L1121
2768  0556               L3221:
2769                     ; 680         tmpreg = CLK->CCOR;
2771  0556 c650c9        	ld	a,20681
2772  0559               L1121:
2773  0559 6b03          	ld	(OFST+0,sp),a
2774                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2776  055b 7b05          	ld	a,(OFST+2,sp)
2777  055d 1503          	bcp	a,(OFST+0,sp)
2778  055f 2704          	jreq	L7221
2779                     ; 685         bitstatus = SET;
2781  0561 a601          	ld	a,#1
2783  0563 2001          	jra	L1321
2784  0565               L7221:
2785                     ; 689         bitstatus = RESET;
2787  0565 4f            	clr	a
2788  0566               L1321:
2789                     ; 693     return((FlagStatus)bitstatus);
2793  0566 5b05          	addw	sp,#5
2794  0568 81            	ret	
2841                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2841                     ; 704 {
2842                     	switch	.text
2843  0569               _CLK_GetITStatus:
2845  0569 88            	push	a
2846  056a 88            	push	a
2847       00000001      OFST:	set	1
2850                     ; 706     ITStatus bitstatus = RESET;
2852                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2854  056b a10c          	cp	a,#12
2855  056d 2712          	jreq	L453
2856  056f a11c          	cp	a,#28
2857  0571 270e          	jreq	L453
2858  0573 ae02c5        	ldw	x,#709
2859  0576 89            	pushw	x
2860  0577 5f            	clrw	x
2861  0578 89            	pushw	x
2862  0579 ae000c        	ldw	x,#L75
2863  057c cd0000        	call	_assert_failed
2865  057f 5b04          	addw	sp,#4
2866  0581               L453:
2867                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2869  0581 7b02          	ld	a,(OFST+1,sp)
2870  0583 a11c          	cp	a,#28
2871  0585 260b          	jrne	L5521
2872                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2874  0587 c650c5        	ld	a,20677
2875  058a 1402          	and	a,(OFST+1,sp)
2876  058c a10c          	cp	a,#12
2877  058e 260f          	jrne	L5621
2878                     ; 716             bitstatus = SET;
2880  0590 2009          	jp	LC006
2881                     ; 720             bitstatus = RESET;
2882  0592               L5521:
2883                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2885  0592 c650c8        	ld	a,20680
2886  0595 1402          	and	a,(OFST+1,sp)
2887  0597 a10c          	cp	a,#12
2888  0599 2604          	jrne	L5621
2889                     ; 728             bitstatus = SET;
2891  059b               LC006:
2893  059b a601          	ld	a,#1
2895  059d 2001          	jra	L3621
2896  059f               L5621:
2897                     ; 732             bitstatus = RESET;
2900  059f 4f            	clr	a
2901  05a0               L3621:
2902                     ; 737     return bitstatus;
2906  05a0 85            	popw	x
2907  05a1 81            	ret	
2944                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2944                     ; 748 {
2945                     	switch	.text
2946  05a2               _CLK_ClearITPendingBit:
2948  05a2 88            	push	a
2949       00000000      OFST:	set	0
2952                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2954  05a3 a10c          	cp	a,#12
2955  05a5 2712          	jreq	L663
2956  05a7 a11c          	cp	a,#28
2957  05a9 270e          	jreq	L663
2958  05ab ae02ef        	ldw	x,#751
2959  05ae 89            	pushw	x
2960  05af 5f            	clrw	x
2961  05b0 89            	pushw	x
2962  05b1 ae000c        	ldw	x,#L75
2963  05b4 cd0000        	call	_assert_failed
2965  05b7 5b04          	addw	sp,#4
2966  05b9               L663:
2967                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2969  05b9 7b01          	ld	a,(OFST+1,sp)
2970  05bb a10c          	cp	a,#12
2971  05bd 2606          	jrne	L7031
2972                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2974  05bf 721750c8      	bres	20680,#3
2976  05c3 2004          	jra	L1131
2977  05c5               L7031:
2978                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2980  05c5 721750c5      	bres	20677,#3
2981  05c9               L1131:
2982                     ; 764 }
2985  05c9 84            	pop	a
2986  05ca 81            	ret	
3021                     	xdef	_CLKPrescTable
3022                     	xdef	_HSIDivFactor
3023                     	xdef	_CLK_ClearITPendingBit
3024                     	xdef	_CLK_GetITStatus
3025                     	xdef	_CLK_GetFlagStatus
3026                     	xdef	_CLK_GetSYSCLKSource
3027                     	xdef	_CLK_GetClockFreq
3028                     	xdef	_CLK_AdjustHSICalibrationValue
3029                     	xdef	_CLK_SYSCLKEmergencyClear
3030                     	xdef	_CLK_ClockSecuritySystemEnable
3031                     	xdef	_CLK_SWIMConfig
3032                     	xdef	_CLK_SYSCLKConfig
3033                     	xdef	_CLK_ITConfig
3034                     	xdef	_CLK_CCOConfig
3035                     	xdef	_CLK_HSIPrescalerConfig
3036                     	xdef	_CLK_ClockSwitchConfig
3037                     	xdef	_CLK_PeripheralClockConfig
3038                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
3039                     	xdef	_CLK_FastHaltWakeUpCmd
3040                     	xdef	_CLK_ClockSwitchCmd
3041                     	xdef	_CLK_CCOCmd
3042                     	xdef	_CLK_LSICmd
3043                     	xdef	_CLK_HSICmd
3044                     	xdef	_CLK_HSECmd
3045                     	xdef	_CLK_DeInit
3046                     	xref	_assert_failed
3047                     	switch	.const
3048  000c               L75:
3049  000c 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
3050  001e 6965735c7374  	dc.b	"ies\stm8s_stdperip"
3051  0030 685f64726976  	dc.b	"h_driver\src\stm8s"
3052  0042 5f636c6b2e63  	dc.b	"_clk.c",0
3053                     	xref.b	c_lreg
3054                     	xref.b	c_x
3074                     	xref	c_ltor
3075                     	xref	c_ludv
3076                     	xref	c_rtol
3077                     	end
