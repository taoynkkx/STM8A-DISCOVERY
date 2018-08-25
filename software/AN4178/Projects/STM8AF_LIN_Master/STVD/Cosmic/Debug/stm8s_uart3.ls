   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  47                     ; 48 void UART3_DeInit(void)
  47                     ; 49 {
  49                     	switch	.text
  50  0000               _UART3_DeInit:
  54                     ; 52     (void) UART3->SR;
  56  0000 c65240        	ld	a,21056
  57                     ; 53     (void) UART3->DR;
  59  0003 c65241        	ld	a,21057
  60                     ; 55     UART3->BRR2 = UART3_BRR2_RESET_VALUE; /*Set UART3_BRR2 to reset value 0x00 */
  62  0006 725f5243      	clr	21059
  63                     ; 56     UART3->BRR1 = UART3_BRR1_RESET_VALUE; /*Set UART3_BRR1 to reset value 0x00 */
  65  000a 725f5242      	clr	21058
  66                     ; 58     UART3->CR1 = UART3_CR1_RESET_VALUE;  /*Set UART3_CR1 to reset value 0x00  */
  68  000e 725f5244      	clr	21060
  69                     ; 59     UART3->CR2 = UART3_CR2_RESET_VALUE;  /*Set UART3_CR2 to reset value 0x00  */
  71  0012 725f5245      	clr	21061
  72                     ; 60     UART3->CR3 = UART3_CR3_RESET_VALUE;  /*Set UART3_CR3 to reset value 0x00  */
  74  0016 725f5246      	clr	21062
  75                     ; 61     UART3->CR4 = UART3_CR4_RESET_VALUE;  /*Set UART3_CR4 to reset value 0x00  */
  77  001a 725f5247      	clr	21063
  78                     ; 62     UART3->CR6 = UART3_CR6_RESET_VALUE;  /*Set UART3_CR6 to reset value 0x00  */
  80  001e 725f5249      	clr	21065
  81                     ; 64 }
  84  0022 81            	ret	
 302                     .const:	section	.text
 303  0000               L24:
 304  0000 00098969      	dc.l	625001
 305  0004               L46:
 306  0004 00000064      	dc.l	100
 307                     ; 78 void UART3_Init(uint32_t BaudRate, UART3_WordLength_TypeDef WordLength, 
 307                     ; 79                 UART3_StopBits_TypeDef StopBits, UART3_Parity_TypeDef Parity, 
 307                     ; 80                 UART3_Mode_TypeDef Mode)
 307                     ; 81 {
 308                     	switch	.text
 309  0023               _UART3_Init:
 311  0023 520e          	subw	sp,#14
 312       0000000e      OFST:	set	14
 315                     ; 82     uint8_t BRR2_1 = 0, BRR2_2 = 0;
 319                     ; 83     uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 323                     ; 86     assert_param(IS_UART3_WORDLENGTH_OK(WordLength));
 325  0025 7b15          	ld	a,(OFST+7,sp)
 326  0027 2712          	jreq	L41
 327  0029 a110          	cp	a,#16
 328  002b 270e          	jreq	L41
 329  002d ae0056        	ldw	x,#86
 330  0030 89            	pushw	x
 331  0031 5f            	clrw	x
 332  0032 89            	pushw	x
 333  0033 ae0008        	ldw	x,#L531
 334  0036 cd0000        	call	_assert_failed
 336  0039 5b04          	addw	sp,#4
 337  003b               L41:
 338                     ; 87     assert_param(IS_UART3_STOPBITS_OK(StopBits));
 340  003b 7b16          	ld	a,(OFST+8,sp)
 341  003d 2712          	jreq	L42
 342  003f a120          	cp	a,#32
 343  0041 270e          	jreq	L42
 344  0043 ae0057        	ldw	x,#87
 345  0046 89            	pushw	x
 346  0047 5f            	clrw	x
 347  0048 89            	pushw	x
 348  0049 ae0008        	ldw	x,#L531
 349  004c cd0000        	call	_assert_failed
 351  004f 5b04          	addw	sp,#4
 352  0051               L42:
 353                     ; 88     assert_param(IS_UART3_PARITY_OK(Parity));
 355  0051 7b17          	ld	a,(OFST+9,sp)
 356  0053 2716          	jreq	L43
 357  0055 a104          	cp	a,#4
 358  0057 2712          	jreq	L43
 359  0059 a106          	cp	a,#6
 360  005b 270e          	jreq	L43
 361  005d ae0058        	ldw	x,#88
 362  0060 89            	pushw	x
 363  0061 5f            	clrw	x
 364  0062 89            	pushw	x
 365  0063 ae0008        	ldw	x,#L531
 366  0066 cd0000        	call	_assert_failed
 368  0069 5b04          	addw	sp,#4
 369  006b               L43:
 370                     ; 89     assert_param(IS_UART3_BAUDRATE_OK(BaudRate));
 372  006b 96            	ldw	x,sp
 373  006c 1c0011        	addw	x,#OFST+3
 374  006f cd0000        	call	c_ltor
 376  0072 ae0000        	ldw	x,#L24
 377  0075 cd0000        	call	c_lcmp
 379  0078 250e          	jrult	L44
 380  007a ae0059        	ldw	x,#89
 381  007d 89            	pushw	x
 382  007e 5f            	clrw	x
 383  007f 89            	pushw	x
 384  0080 ae0008        	ldw	x,#L531
 385  0083 cd0000        	call	_assert_failed
 387  0086 5b04          	addw	sp,#4
 388  0088               L44:
 389                     ; 90     assert_param(IS_UART3_MODE_OK((uint8_t)Mode));
 391  0088 7b18          	ld	a,(OFST+10,sp)
 392  008a a108          	cp	a,#8
 393  008c 272a          	jreq	L45
 394  008e a140          	cp	a,#64
 395  0090 2726          	jreq	L45
 396  0092 a104          	cp	a,#4
 397  0094 2722          	jreq	L45
 398  0096 a180          	cp	a,#128
 399  0098 271e          	jreq	L45
 400  009a a10c          	cp	a,#12
 401  009c 271a          	jreq	L45
 402  009e a144          	cp	a,#68
 403  00a0 2716          	jreq	L45
 404  00a2 a1c0          	cp	a,#192
 405  00a4 2712          	jreq	L45
 406  00a6 a188          	cp	a,#136
 407  00a8 270e          	jreq	L45
 408  00aa ae005a        	ldw	x,#90
 409  00ad 89            	pushw	x
 410  00ae 5f            	clrw	x
 411  00af 89            	pushw	x
 412  00b0 ae0008        	ldw	x,#L531
 413  00b3 cd0000        	call	_assert_failed
 415  00b6 5b04          	addw	sp,#4
 416  00b8               L45:
 417                     ; 93     UART3->CR1 &= (uint8_t)(~UART3_CR1_M);     
 419  00b8 72195244      	bres	21060,#4
 420                     ; 95     UART3->CR1 |= (uint8_t)WordLength; 
 422  00bc c65244        	ld	a,21060
 423  00bf 1a15          	or	a,(OFST+7,sp)
 424  00c1 c75244        	ld	21060,a
 425                     ; 98     UART3->CR3 &= (uint8_t)(~UART3_CR3_STOP);  
 427  00c4 c65246        	ld	a,21062
 428  00c7 a4cf          	and	a,#207
 429  00c9 c75246        	ld	21062,a
 430                     ; 100     UART3->CR3 |= (uint8_t)StopBits;  
 432  00cc c65246        	ld	a,21062
 433  00cf 1a16          	or	a,(OFST+8,sp)
 434  00d1 c75246        	ld	21062,a
 435                     ; 103     UART3->CR1 &= (uint8_t)(~(UART3_CR1_PCEN | UART3_CR1_PS));  
 437  00d4 c65244        	ld	a,21060
 438  00d7 a4f9          	and	a,#249
 439  00d9 c75244        	ld	21060,a
 440                     ; 105     UART3->CR1 |= (uint8_t)Parity;     
 442  00dc c65244        	ld	a,21060
 443  00df 1a17          	or	a,(OFST+9,sp)
 444  00e1 c75244        	ld	21060,a
 445                     ; 108     UART3->BRR1 &= (uint8_t)(~UART3_BRR1_DIVM);  
 447  00e4 725f5242      	clr	21058
 448                     ; 110     UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVM);  
 450  00e8 c65243        	ld	a,21059
 451  00eb a40f          	and	a,#15
 452  00ed c75243        	ld	21059,a
 453                     ; 112     UART3->BRR2 &= (uint8_t)(~UART3_BRR2_DIVF);  
 455  00f0 c65243        	ld	a,21059
 456  00f3 a4f0          	and	a,#240
 457  00f5 c75243        	ld	21059,a
 458                     ; 115     BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 460  00f8 96            	ldw	x,sp
 461  00f9 1c0011        	addw	x,#OFST+3
 462  00fc cd0000        	call	c_ltor
 464  00ff a604          	ld	a,#4
 465  0101 cd0000        	call	c_llsh
 467  0104 96            	ldw	x,sp
 468  0105 5c            	incw	x
 469  0106 cd0000        	call	c_rtol
 471  0109 cd0000        	call	_CLK_GetClockFreq
 473  010c 96            	ldw	x,sp
 474  010d 5c            	incw	x
 475  010e cd0000        	call	c_ludv
 477  0111 96            	ldw	x,sp
 478  0112 1c000b        	addw	x,#OFST-3
 479  0115 cd0000        	call	c_rtol
 481                     ; 116     BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 483  0118 96            	ldw	x,sp
 484  0119 1c0011        	addw	x,#OFST+3
 485  011c cd0000        	call	c_ltor
 487  011f a604          	ld	a,#4
 488  0121 cd0000        	call	c_llsh
 490  0124 96            	ldw	x,sp
 491  0125 5c            	incw	x
 492  0126 cd0000        	call	c_rtol
 494  0129 cd0000        	call	_CLK_GetClockFreq
 496  012c a664          	ld	a,#100
 497  012e cd0000        	call	c_smul
 499  0131 96            	ldw	x,sp
 500  0132 5c            	incw	x
 501  0133 cd0000        	call	c_ludv
 503  0136 96            	ldw	x,sp
 504  0137 1c0007        	addw	x,#OFST-7
 505  013a cd0000        	call	c_rtol
 507                     ; 119     BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 507                     ; 120                         << 4) / 100) & (uint8_t)0x0F); 
 509  013d 96            	ldw	x,sp
 510  013e 1c000b        	addw	x,#OFST-3
 511  0141 cd0000        	call	c_ltor
 513  0144 a664          	ld	a,#100
 514  0146 cd0000        	call	c_smul
 516  0149 96            	ldw	x,sp
 517  014a 5c            	incw	x
 518  014b cd0000        	call	c_rtol
 520  014e 96            	ldw	x,sp
 521  014f 1c0007        	addw	x,#OFST-7
 522  0152 cd0000        	call	c_ltor
 524  0155 96            	ldw	x,sp
 525  0156 5c            	incw	x
 526  0157 cd0000        	call	c_lsub
 528  015a a604          	ld	a,#4
 529  015c cd0000        	call	c_llsh
 531  015f ae0004        	ldw	x,#L46
 532  0162 cd0000        	call	c_ludv
 534  0165 b603          	ld	a,c_lreg+3
 535  0167 a40f          	and	a,#15
 536  0169 6b05          	ld	(OFST-9,sp),a
 537                     ; 121     BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 539  016b 96            	ldw	x,sp
 540  016c 1c000b        	addw	x,#OFST-3
 541  016f cd0000        	call	c_ltor
 543  0172 a604          	ld	a,#4
 544  0174 cd0000        	call	c_lursh
 546  0177 b603          	ld	a,c_lreg+3
 547  0179 a4f0          	and	a,#240
 548  017b b703          	ld	c_lreg+3,a
 549  017d 3f02          	clr	c_lreg+2
 550  017f 3f01          	clr	c_lreg+1
 551  0181 3f00          	clr	c_lreg
 552  0183 6b06          	ld	(OFST-8,sp),a
 553                     ; 123     UART3->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 555  0185 1a05          	or	a,(OFST-9,sp)
 556  0187 c75243        	ld	21059,a
 557                     ; 125     UART3->BRR1 = (uint8_t)BaudRate_Mantissa;           
 559  018a 7b0e          	ld	a,(OFST+0,sp)
 560  018c c75242        	ld	21058,a
 561                     ; 127     if ((uint8_t)(Mode & UART3_MODE_TX_ENABLE))
 563  018f 7b18          	ld	a,(OFST+10,sp)
 564  0191 a504          	bcp	a,#4
 565  0193 2706          	jreq	L731
 566                     ; 130         UART3->CR2 |= UART3_CR2_TEN;  
 568  0195 72165245      	bset	21061,#3
 570  0199 2004          	jra	L141
 571  019b               L731:
 572                     ; 135         UART3->CR2 &= (uint8_t)(~UART3_CR2_TEN);  
 574  019b 72175245      	bres	21061,#3
 575  019f               L141:
 576                     ; 137     if ((uint8_t)(Mode & UART3_MODE_RX_ENABLE))
 578  019f a508          	bcp	a,#8
 579  01a1 2706          	jreq	L341
 580                     ; 140         UART3->CR2 |= UART3_CR2_REN;  
 582  01a3 72145245      	bset	21061,#2
 584  01a7 2004          	jra	L541
 585  01a9               L341:
 586                     ; 145         UART3->CR2 &= (uint8_t)(~UART3_CR2_REN);  
 588  01a9 72155245      	bres	21061,#2
 589  01ad               L541:
 590                     ; 147 }
 593  01ad 5b0e          	addw	sp,#14
 594  01af 81            	ret	
 649                     ; 155 void UART3_Cmd(FunctionalState NewState)
 649                     ; 156 {
 650                     	switch	.text
 651  01b0               _UART3_Cmd:
 655                     ; 158     if (NewState != DISABLE)
 657  01b0 4d            	tnz	a
 658  01b1 2705          	jreq	L571
 659                     ; 161         UART3->CR1 &= (uint8_t)(~UART3_CR1_UARTD); 
 661  01b3 721b5244      	bres	21060,#5
 664  01b7 81            	ret	
 665  01b8               L571:
 666                     ; 166         UART3->CR1 |= UART3_CR1_UARTD;  
 668  01b8 721a5244      	bset	21060,#5
 669                     ; 168 }
 672  01bc 81            	ret	
 801                     ; 185 void UART3_ITConfig(UART3_IT_TypeDef UART3_IT, FunctionalState NewState)
 801                     ; 186 {
 802                     	switch	.text
 803  01bd               _UART3_ITConfig:
 805  01bd 89            	pushw	x
 806  01be 89            	pushw	x
 807       00000002      OFST:	set	2
 810                     ; 187     uint8_t uartreg = 0, itpos = 0x00;
 814                     ; 190     assert_param(IS_UART3_CONFIG_IT_OK(UART3_IT));
 816  01bf a30100        	cpw	x,#256
 817  01c2 272c          	jreq	L67
 818  01c4 a30277        	cpw	x,#631
 819  01c7 2727          	jreq	L67
 820  01c9 a30266        	cpw	x,#614
 821  01cc 2722          	jreq	L67
 822  01ce a30205        	cpw	x,#517
 823  01d1 271d          	jreq	L67
 824  01d3 a30244        	cpw	x,#580
 825  01d6 2718          	jreq	L67
 826  01d8 a30412        	cpw	x,#1042
 827  01db 2713          	jreq	L67
 828  01dd a30346        	cpw	x,#838
 829  01e0 270e          	jreq	L67
 830  01e2 ae00be        	ldw	x,#190
 831  01e5 89            	pushw	x
 832  01e6 5f            	clrw	x
 833  01e7 89            	pushw	x
 834  01e8 ae0008        	ldw	x,#L531
 835  01eb cd0000        	call	_assert_failed
 837  01ee 5b04          	addw	sp,#4
 838  01f0               L67:
 839                     ; 191     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 841  01f0 7b07          	ld	a,(OFST+5,sp)
 842  01f2 2711          	jreq	L601
 843  01f4 4a            	dec	a
 844  01f5 270e          	jreq	L601
 845  01f7 ae00bf        	ldw	x,#191
 846  01fa 89            	pushw	x
 847  01fb 5f            	clrw	x
 848  01fc 89            	pushw	x
 849  01fd ae0008        	ldw	x,#L531
 850  0200 cd0000        	call	_assert_failed
 852  0203 5b04          	addw	sp,#4
 853  0205               L601:
 854                     ; 194     uartreg = (uint8_t)((uint16_t)UART3_IT >> 0x08);
 856  0205 7b03          	ld	a,(OFST+1,sp)
 857  0207 6b01          	ld	(OFST-1,sp),a
 858                     ; 197     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
 860  0209 7b04          	ld	a,(OFST+2,sp)
 861  020b a40f          	and	a,#15
 862  020d 5f            	clrw	x
 863  020e 97            	ld	xl,a
 864  020f a601          	ld	a,#1
 865  0211 5d            	tnzw	x
 866  0212 2704          	jreq	L211
 867  0214               L411:
 868  0214 48            	sll	a
 869  0215 5a            	decw	x
 870  0216 26fc          	jrne	L411
 871  0218               L211:
 872  0218 6b02          	ld	(OFST+0,sp),a
 873                     ; 199     if (NewState != DISABLE)
 875  021a 7b07          	ld	a,(OFST+5,sp)
 876  021c 272a          	jreq	L552
 877                     ; 202         if (uartreg == 0x01)
 879  021e 7b01          	ld	a,(OFST-1,sp)
 880  0220 a101          	cp	a,#1
 881  0222 2607          	jrne	L752
 882                     ; 204             UART3->CR1 |= itpos;
 884  0224 c65244        	ld	a,21060
 885  0227 1a02          	or	a,(OFST+0,sp)
 887  0229 2029          	jp	LC003
 888  022b               L752:
 889                     ; 206         else if (uartreg == 0x02)
 891  022b a102          	cp	a,#2
 892  022d 2607          	jrne	L362
 893                     ; 208             UART3->CR2 |= itpos;
 895  022f c65245        	ld	a,21061
 896  0232 1a02          	or	a,(OFST+0,sp)
 898  0234 202d          	jp	LC002
 899  0236               L362:
 900                     ; 210         else if (uartreg == 0x03)
 902  0236 a103          	cp	a,#3
 903  0238 2607          	jrne	L762
 904                     ; 212             UART3->CR4 |= itpos;
 906  023a c65247        	ld	a,21063
 907  023d 1a02          	or	a,(OFST+0,sp)
 909  023f 2031          	jp	LC004
 910  0241               L762:
 911                     ; 216             UART3->CR6 |= itpos;
 913  0241 c65249        	ld	a,21065
 914  0244 1a02          	or	a,(OFST+0,sp)
 915  0246 2035          	jp	LC001
 916  0248               L552:
 917                     ; 222         if (uartreg == 0x01)
 919  0248 7b01          	ld	a,(OFST-1,sp)
 920  024a a101          	cp	a,#1
 921  024c 260b          	jrne	L572
 922                     ; 224             UART3->CR1 &= (uint8_t)(~itpos);
 924  024e 7b02          	ld	a,(OFST+0,sp)
 925  0250 43            	cpl	a
 926  0251 c45244        	and	a,21060
 927  0254               LC003:
 928  0254 c75244        	ld	21060,a
 930  0257 2027          	jra	L372
 931  0259               L572:
 932                     ; 226         else if (uartreg == 0x02)
 934  0259 a102          	cp	a,#2
 935  025b 260b          	jrne	L103
 936                     ; 228             UART3->CR2 &= (uint8_t)(~itpos);
 938  025d 7b02          	ld	a,(OFST+0,sp)
 939  025f 43            	cpl	a
 940  0260 c45245        	and	a,21061
 941  0263               LC002:
 942  0263 c75245        	ld	21061,a
 944  0266 2018          	jra	L372
 945  0268               L103:
 946                     ; 230         else if (uartreg == 0x03)
 948  0268 a103          	cp	a,#3
 949  026a 260b          	jrne	L503
 950                     ; 232             UART3->CR4 &= (uint8_t)(~itpos);
 952  026c 7b02          	ld	a,(OFST+0,sp)
 953  026e 43            	cpl	a
 954  026f c45247        	and	a,21063
 955  0272               LC004:
 956  0272 c75247        	ld	21063,a
 958  0275 2009          	jra	L372
 959  0277               L503:
 960                     ; 236             UART3->CR6 &= (uint8_t)(~itpos);
 962  0277 7b02          	ld	a,(OFST+0,sp)
 963  0279 43            	cpl	a
 964  027a c45249        	and	a,21065
 965  027d               LC001:
 966  027d c75249        	ld	21065,a
 967  0280               L372:
 968                     ; 239 }
 971  0280 5b04          	addw	sp,#4
 972  0282 81            	ret	
1032                     ; 248 void UART3_LINBreakDetectionConfig(UART3_LINBreakDetectionLength_TypeDef UART3_LINBreakDetectionLength)
1032                     ; 249 {
1033                     	switch	.text
1034  0283               _UART3_LINBreakDetectionConfig:
1036  0283 88            	push	a
1037       00000000      OFST:	set	0
1040                     ; 251     assert_param(IS_UART3_LINBREAKDETECTIONLENGTH_OK(UART3_LINBreakDetectionLength));
1042  0284 4d            	tnz	a
1043  0285 2711          	jreq	L421
1044  0287 4a            	dec	a
1045  0288 270e          	jreq	L421
1046  028a ae00fb        	ldw	x,#251
1047  028d 89            	pushw	x
1048  028e 5f            	clrw	x
1049  028f 89            	pushw	x
1050  0290 ae0008        	ldw	x,#L531
1051  0293 cd0000        	call	_assert_failed
1053  0296 5b04          	addw	sp,#4
1054  0298               L421:
1055                     ; 253     if (UART3_LINBreakDetectionLength != UART3_LINBREAKDETECTIONLENGTH_10BITS)
1057  0298 7b01          	ld	a,(OFST+1,sp)
1058  029a 2706          	jreq	L733
1059                     ; 255         UART3->CR4 |= UART3_CR4_LBDL;
1061  029c 721a5247      	bset	21063,#5
1063  02a0 2004          	jra	L143
1064  02a2               L733:
1065                     ; 259         UART3->CR4 &= ((uint8_t)~UART3_CR4_LBDL);
1067  02a2 721b5247      	bres	21063,#5
1068  02a6               L143:
1069                     ; 261 }
1072  02a6 84            	pop	a
1073  02a7 81            	ret	
1195                     ; 273 void UART3_LINConfig(UART3_LinMode_TypeDef UART3_Mode,
1195                     ; 274                      UART3_LinAutosync_TypeDef UART3_Autosync, 
1195                     ; 275                      UART3_LinDivUp_TypeDef UART3_DivUp)
1195                     ; 276 {
1196                     	switch	.text
1197  02a8               _UART3_LINConfig:
1199  02a8 89            	pushw	x
1200       00000000      OFST:	set	0
1203                     ; 278     assert_param(IS_UART3_SLAVE_OK(UART3_Mode));
1205  02a9 9e            	ld	a,xh
1206  02aa 4d            	tnz	a
1207  02ab 2712          	jreq	L631
1208  02ad 9e            	ld	a,xh
1209  02ae 4a            	dec	a
1210  02af 270e          	jreq	L631
1211  02b1 ae0116        	ldw	x,#278
1212  02b4 89            	pushw	x
1213  02b5 5f            	clrw	x
1214  02b6 89            	pushw	x
1215  02b7 ae0008        	ldw	x,#L531
1216  02ba cd0000        	call	_assert_failed
1218  02bd 5b04          	addw	sp,#4
1219  02bf               L631:
1220                     ; 279     assert_param(IS_UART3_AUTOSYNC_OK(UART3_Autosync));
1222  02bf 7b02          	ld	a,(OFST+2,sp)
1223  02c1 4a            	dec	a
1224  02c2 2712          	jreq	L641
1225  02c4 7b02          	ld	a,(OFST+2,sp)
1226  02c6 270e          	jreq	L641
1227  02c8 ae0117        	ldw	x,#279
1228  02cb 89            	pushw	x
1229  02cc 5f            	clrw	x
1230  02cd 89            	pushw	x
1231  02ce ae0008        	ldw	x,#L531
1232  02d1 cd0000        	call	_assert_failed
1234  02d4 5b04          	addw	sp,#4
1235  02d6               L641:
1236                     ; 280     assert_param(IS_UART3_DIVUP_OK(UART3_DivUp));
1238  02d6 7b05          	ld	a,(OFST+5,sp)
1239  02d8 2711          	jreq	L651
1240  02da 4a            	dec	a
1241  02db 270e          	jreq	L651
1242  02dd ae0118        	ldw	x,#280
1243  02e0 89            	pushw	x
1244  02e1 5f            	clrw	x
1245  02e2 89            	pushw	x
1246  02e3 ae0008        	ldw	x,#L531
1247  02e6 cd0000        	call	_assert_failed
1249  02e9 5b04          	addw	sp,#4
1250  02eb               L651:
1251                     ; 282     if (UART3_Mode != UART3_LIN_MODE_MASTER)
1253  02eb 7b01          	ld	a,(OFST+1,sp)
1254  02ed 2706          	jreq	L124
1255                     ; 284         UART3->CR6 |=  UART3_CR6_LSLV;
1257  02ef 721a5249      	bset	21065,#5
1259  02f3 2004          	jra	L324
1260  02f5               L124:
1261                     ; 288         UART3->CR6 &= ((uint8_t)~UART3_CR6_LSLV);
1263  02f5 721b5249      	bres	21065,#5
1264  02f9               L324:
1265                     ; 291     if (UART3_Autosync != UART3_LIN_AUTOSYNC_DISABLE)
1267  02f9 7b02          	ld	a,(OFST+2,sp)
1268  02fb 2706          	jreq	L524
1269                     ; 293         UART3->CR6 |=  UART3_CR6_LASE ;
1271  02fd 72185249      	bset	21065,#4
1273  0301 2004          	jra	L724
1274  0303               L524:
1275                     ; 297         UART3->CR6 &= ((uint8_t)~ UART3_CR6_LASE );
1277  0303 72195249      	bres	21065,#4
1278  0307               L724:
1279                     ; 300     if (UART3_DivUp != UART3_LIN_DIVUP_LBRR1)
1281  0307 7b05          	ld	a,(OFST+5,sp)
1282  0309 2706          	jreq	L134
1283                     ; 302         UART3->CR6 |=  UART3_CR6_LDUM;
1285  030b 721e5249      	bset	21065,#7
1287  030f 2004          	jra	L334
1288  0311               L134:
1289                     ; 306         UART3->CR6 &= ((uint8_t)~ UART3_CR6_LDUM);
1291  0311 721f5249      	bres	21065,#7
1292  0315               L334:
1293                     ; 308 }
1296  0315 85            	popw	x
1297  0316 81            	ret	
1333                     ; 316 void UART3_LINCmd(FunctionalState NewState)
1333                     ; 317 {
1334                     	switch	.text
1335  0317               _UART3_LINCmd:
1337  0317 88            	push	a
1338       00000000      OFST:	set	0
1341                     ; 319     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1343  0318 4d            	tnz	a
1344  0319 2711          	jreq	L071
1345  031b 4a            	dec	a
1346  031c 270e          	jreq	L071
1347  031e ae013f        	ldw	x,#319
1348  0321 89            	pushw	x
1349  0322 5f            	clrw	x
1350  0323 89            	pushw	x
1351  0324 ae0008        	ldw	x,#L531
1352  0327 cd0000        	call	_assert_failed
1354  032a 5b04          	addw	sp,#4
1355  032c               L071:
1356                     ; 321     if (NewState != DISABLE)
1358  032c 7b01          	ld	a,(OFST+1,sp)
1359  032e 2706          	jreq	L354
1360                     ; 324         UART3->CR3 |= UART3_CR3_LINEN;
1362  0330 721c5246      	bset	21062,#6
1364  0334 2004          	jra	L554
1365  0336               L354:
1366                     ; 329         UART3->CR3 &= ((uint8_t)~UART3_CR3_LINEN);
1368  0336 721d5246      	bres	21062,#6
1369  033a               L554:
1370                     ; 331 }
1373  033a 84            	pop	a
1374  033b 81            	ret	
1432                     ; 339 void UART3_WakeUpConfig(UART3_WakeUp_TypeDef UART3_WakeUp)
1432                     ; 340 {
1433                     	switch	.text
1434  033c               _UART3_WakeUpConfig:
1436  033c 88            	push	a
1437       00000000      OFST:	set	0
1440                     ; 342     assert_param(IS_UART3_WAKEUP_OK(UART3_WakeUp));
1442  033d 4d            	tnz	a
1443  033e 2712          	jreq	L202
1444  0340 a108          	cp	a,#8
1445  0342 270e          	jreq	L202
1446  0344 ae0156        	ldw	x,#342
1447  0347 89            	pushw	x
1448  0348 5f            	clrw	x
1449  0349 89            	pushw	x
1450  034a ae0008        	ldw	x,#L531
1451  034d cd0000        	call	_assert_failed
1453  0350 5b04          	addw	sp,#4
1454  0352               L202:
1455                     ; 344     UART3->CR1 &= ((uint8_t)~UART3_CR1_WAKE);
1457  0352 72175244      	bres	21060,#3
1458                     ; 345     UART3->CR1 |= (uint8_t)UART3_WakeUp;
1460  0356 c65244        	ld	a,21060
1461  0359 1a01          	or	a,(OFST+1,sp)
1462  035b c75244        	ld	21060,a
1463                     ; 346 }
1466  035e 84            	pop	a
1467  035f 81            	ret	
1504                     ; 354 void UART3_ReceiverWakeUpCmd(FunctionalState NewState)
1504                     ; 355 {
1505                     	switch	.text
1506  0360               _UART3_ReceiverWakeUpCmd:
1508  0360 88            	push	a
1509       00000000      OFST:	set	0
1512                     ; 357     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1514  0361 4d            	tnz	a
1515  0362 2711          	jreq	L412
1516  0364 4a            	dec	a
1517  0365 270e          	jreq	L412
1518  0367 ae0165        	ldw	x,#357
1519  036a 89            	pushw	x
1520  036b 5f            	clrw	x
1521  036c 89            	pushw	x
1522  036d ae0008        	ldw	x,#L531
1523  0370 cd0000        	call	_assert_failed
1525  0373 5b04          	addw	sp,#4
1526  0375               L412:
1527                     ; 359     if (NewState != DISABLE)
1529  0375 7b01          	ld	a,(OFST+1,sp)
1530  0377 2706          	jreq	L325
1531                     ; 362         UART3->CR2 |= UART3_CR2_RWU;
1533  0379 72125245      	bset	21061,#1
1535  037d 2004          	jra	L525
1536  037f               L325:
1537                     ; 367         UART3->CR2 &= ((uint8_t)~UART3_CR2_RWU);
1539  037f 72135245      	bres	21061,#1
1540  0383               L525:
1541                     ; 369 }
1544  0383 84            	pop	a
1545  0384 81            	ret	
1568                     ; 376 uint8_t UART3_ReceiveData8(void)
1568                     ; 377 {
1569                     	switch	.text
1570  0385               _UART3_ReceiveData8:
1574                     ; 378     return ((uint8_t)UART3->DR);
1576  0385 c65241        	ld	a,21057
1579  0388 81            	ret	
1611                     ; 386 uint16_t UART3_ReceiveData9(void)
1611                     ; 387 {
1612                     	switch	.text
1613  0389               _UART3_ReceiveData9:
1615  0389 89            	pushw	x
1616       00000002      OFST:	set	2
1619                     ; 388   uint16_t temp = 0;
1621                     ; 390  temp = (uint16_t)(((uint16_t)((uint16_t)UART3->CR1 & (uint16_t)UART3_CR1_R8)) << 1);
1623  038a c65244        	ld	a,21060
1624  038d a480          	and	a,#128
1625  038f 5f            	clrw	x
1626  0390 02            	rlwa	x,a
1627  0391 58            	sllw	x
1628  0392 1f01          	ldw	(OFST-1,sp),x
1629                     ; 391   return (uint16_t)((((uint16_t)UART3->DR) | temp) & ((uint16_t)0x01FF));
1631  0394 5f            	clrw	x
1632  0395 c65241        	ld	a,21057
1633  0398 97            	ld	xl,a
1634  0399 01            	rrwa	x,a
1635  039a 1a02          	or	a,(OFST+0,sp)
1636  039c 01            	rrwa	x,a
1637  039d 1a01          	or	a,(OFST-1,sp)
1638  039f a401          	and	a,#1
1639  03a1 01            	rrwa	x,a
1642  03a2 5b02          	addw	sp,#2
1643  03a4 81            	ret	
1675                     ; 399 void UART3_SendData8(uint8_t Data)
1675                     ; 400 {
1676                     	switch	.text
1677  03a5               _UART3_SendData8:
1681                     ; 402     UART3->DR = Data;
1683  03a5 c75241        	ld	21057,a
1684                     ; 403 }
1687  03a8 81            	ret	
1719                     ; 410 void UART3_SendData9(uint16_t Data)
1719                     ; 411 {
1720                     	switch	.text
1721  03a9               _UART3_SendData9:
1723  03a9 89            	pushw	x
1724       00000000      OFST:	set	0
1727                     ; 413     UART3->CR1 &= ((uint8_t)~UART3_CR1_T8);                  
1729  03aa 721d5244      	bres	21060,#6
1730                     ; 416     UART3->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART3_CR1_T8); 
1732  03ae 54            	srlw	x
1733  03af 54            	srlw	x
1734  03b0 9f            	ld	a,xl
1735  03b1 a440          	and	a,#64
1736  03b3 ca5244        	or	a,21060
1737  03b6 c75244        	ld	21060,a
1738                     ; 419     UART3->DR   = (uint8_t)(Data);                    
1740  03b9 7b02          	ld	a,(OFST+2,sp)
1741  03bb c75241        	ld	21057,a
1742                     ; 420 }
1745  03be 85            	popw	x
1746  03bf 81            	ret	
1769                     ; 427 void UART3_SendBreak(void)
1769                     ; 428 {
1770                     	switch	.text
1771  03c0               _UART3_SendBreak:
1775                     ; 429     UART3->CR2 |= UART3_CR2_SBK;
1777  03c0 72105245      	bset	21061,#0
1778                     ; 430 }
1781  03c4 81            	ret	
1814                     ; 437 void UART3_SetAddress(uint8_t UART3_Address)
1814                     ; 438 {
1815                     	switch	.text
1816  03c5               _UART3_SetAddress:
1818  03c5 88            	push	a
1819       00000000      OFST:	set	0
1822                     ; 440     assert_param(IS_UART3_ADDRESS_OK(UART3_Address));
1824  03c6 a110          	cp	a,#16
1825  03c8 250e          	jrult	L632
1826  03ca ae01b8        	ldw	x,#440
1827  03cd 89            	pushw	x
1828  03ce 5f            	clrw	x
1829  03cf 89            	pushw	x
1830  03d0 ae0008        	ldw	x,#L531
1831  03d3 cd0000        	call	_assert_failed
1833  03d6 5b04          	addw	sp,#4
1834  03d8               L632:
1835                     ; 443     UART3->CR4 &= ((uint8_t)~UART3_CR4_ADD);
1837  03d8 c65247        	ld	a,21063
1838  03db a4f0          	and	a,#240
1839  03dd c75247        	ld	21063,a
1840                     ; 445     UART3->CR4 |= UART3_Address;
1842  03e0 c65247        	ld	a,21063
1843  03e3 1a01          	or	a,(OFST+1,sp)
1844  03e5 c75247        	ld	21063,a
1845                     ; 446 }
1848  03e8 84            	pop	a
1849  03e9 81            	ret	
2007                     ; 454 FlagStatus UART3_GetFlagStatus(UART3_Flag_TypeDef UART3_FLAG)
2007                     ; 455 {
2008                     	switch	.text
2009  03ea               _UART3_GetFlagStatus:
2011  03ea 89            	pushw	x
2012  03eb 88            	push	a
2013       00000001      OFST:	set	1
2016                     ; 456     FlagStatus status = RESET;
2018                     ; 459     assert_param(IS_UART3_FLAG_OK(UART3_FLAG));
2020  03ec a30080        	cpw	x,#128
2021  03ef 2745          	jreq	L052
2022  03f1 a30040        	cpw	x,#64
2023  03f4 2740          	jreq	L052
2024  03f6 a30020        	cpw	x,#32
2025  03f9 273b          	jreq	L052
2026  03fb a30010        	cpw	x,#16
2027  03fe 2736          	jreq	L052
2028  0400 a30008        	cpw	x,#8
2029  0403 2731          	jreq	L052
2030  0405 a30004        	cpw	x,#4
2031  0408 272c          	jreq	L052
2032  040a a30002        	cpw	x,#2
2033  040d 2727          	jreq	L052
2034  040f a30001        	cpw	x,#1
2035  0412 2722          	jreq	L052
2036  0414 a30101        	cpw	x,#257
2037  0417 271d          	jreq	L052
2038  0419 a30301        	cpw	x,#769
2039  041c 2718          	jreq	L052
2040  041e a30302        	cpw	x,#770
2041  0421 2713          	jreq	L052
2042  0423 a30210        	cpw	x,#528
2043  0426 270e          	jreq	L052
2044  0428 ae01cb        	ldw	x,#459
2045  042b 89            	pushw	x
2046  042c 5f            	clrw	x
2047  042d 89            	pushw	x
2048  042e ae0008        	ldw	x,#L531
2049  0431 cd0000        	call	_assert_failed
2051  0434 5b04          	addw	sp,#4
2052  0436               L052:
2053                     ; 462     if (UART3_FLAG == UART3_FLAG_LBDF)
2055  0436 1e02          	ldw	x,(OFST+1,sp)
2056  0438 a30210        	cpw	x,#528
2057  043b 2609          	jrne	L517
2058                     ; 464         if ((UART3->CR4 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
2060  043d c65247        	ld	a,21063
2061  0440 1503          	bcp	a,(OFST+2,sp)
2062  0442 2725          	jreq	L147
2063                     ; 467             status = SET;
2065  0444 201f          	jp	LC006
2066                     ; 472             status = RESET;
2067  0446               L517:
2068                     ; 475     else if (UART3_FLAG == UART3_FLAG_SBK)
2070  0446 a30101        	cpw	x,#257
2071  0449 2609          	jrne	L527
2072                     ; 477         if ((UART3->CR2 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
2074  044b c65245        	ld	a,21061
2075  044e 1503          	bcp	a,(OFST+2,sp)
2076  0450 2717          	jreq	L147
2077                     ; 480             status = SET;
2079  0452 2011          	jp	LC006
2080                     ; 485             status = RESET;
2081  0454               L527:
2082                     ; 488     else if ((UART3_FLAG == UART3_FLAG_LHDF) || (UART3_FLAG == UART3_FLAG_LSF))
2084  0454 a30302        	cpw	x,#770
2085  0457 2705          	jreq	L737
2087  0459 a30301        	cpw	x,#769
2088  045c 260f          	jrne	L537
2089  045e               L737:
2090                     ; 490         if ((UART3->CR6 & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
2092  045e c65249        	ld	a,21065
2093  0461 1503          	bcp	a,(OFST+2,sp)
2094  0463 2704          	jreq	L147
2095                     ; 493             status = SET;
2097  0465               LC006:
2101  0465 a601          	ld	a,#1
2103  0467 2001          	jra	L327
2104  0469               L147:
2105                     ; 498             status = RESET;
2110  0469 4f            	clr	a
2111  046a               L327:
2112                     ; 516     return  status;
2116  046a 5b03          	addw	sp,#3
2117  046c 81            	ret	
2118  046d               L537:
2119                     ; 503         if ((UART3->SR & (uint8_t)UART3_FLAG) != (uint8_t)0x00)
2121  046d c65240        	ld	a,21056
2122  0470 1503          	bcp	a,(OFST+2,sp)
2123  0472 27f5          	jreq	L147
2124                     ; 506             status = SET;
2126  0474 20ef          	jp	LC006
2127                     ; 511             status = RESET;
2163                     ; 546 void UART3_ClearFlag(UART3_Flag_TypeDef UART3_FLAG)
2163                     ; 547 {
2164                     	switch	.text
2165  0476               _UART3_ClearFlag:
2167  0476 89            	pushw	x
2168       00000000      OFST:	set	0
2171                     ; 549     assert_param(IS_UART3_CLEAR_FLAG_OK(UART3_FLAG));
2173  0477 a30020        	cpw	x,#32
2174  047a 271d          	jreq	L262
2175  047c a30302        	cpw	x,#770
2176  047f 2718          	jreq	L262
2177  0481 a30301        	cpw	x,#769
2178  0484 2713          	jreq	L262
2179  0486 a30210        	cpw	x,#528
2180  0489 270e          	jreq	L262
2181  048b ae0225        	ldw	x,#549
2182  048e 89            	pushw	x
2183  048f 5f            	clrw	x
2184  0490 89            	pushw	x
2185  0491 ae0008        	ldw	x,#L531
2186  0494 cd0000        	call	_assert_failed
2188  0497 5b04          	addw	sp,#4
2189  0499               L262:
2190                     ; 552     if (UART3_FLAG == UART3_FLAG_RXNE)
2192  0499 1e01          	ldw	x,(OFST+1,sp)
2193  049b a30020        	cpw	x,#32
2194  049e 2606          	jrne	L177
2195                     ; 554         UART3->SR = (uint8_t)~(UART3_SR_RXNE);
2197  04a0 35df5240      	mov	21056,#223
2199  04a4 201a          	jra	L377
2200  04a6               L177:
2201                     ; 557     else if (UART3_FLAG == UART3_FLAG_LBDF)
2203  04a6 a30210        	cpw	x,#528
2204  04a9 2606          	jrne	L577
2205                     ; 559         UART3->CR4 &= (uint8_t)(~UART3_CR4_LBDF);
2207  04ab 72195247      	bres	21063,#4
2209  04af 200f          	jra	L377
2210  04b1               L577:
2211                     ; 562     else if (UART3_FLAG == UART3_FLAG_LHDF)
2213  04b1 a30302        	cpw	x,#770
2214  04b4 2606          	jrne	L1001
2215                     ; 564         UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
2217  04b6 72135249      	bres	21065,#1
2219  04ba 2004          	jra	L377
2220  04bc               L1001:
2221                     ; 569         UART3->CR6 &= (uint8_t)(~UART3_CR6_LSF);
2223  04bc 72115249      	bres	21065,#0
2224  04c0               L377:
2225                     ; 571 }
2228  04c0 85            	popw	x
2229  04c1 81            	ret	
2304                     ; 586 ITStatus UART3_GetITStatus(UART3_IT_TypeDef UART3_IT)
2304                     ; 587 {
2305                     	switch	.text
2306  04c2               _UART3_GetITStatus:
2308  04c2 89            	pushw	x
2309  04c3 89            	pushw	x
2310       00000002      OFST:	set	2
2313                     ; 588     ITStatus pendingbitstatus = RESET;
2315                     ; 589     uint8_t itpos = 0;
2317                     ; 590     uint8_t itmask1 = 0;
2319                     ; 591     uint8_t itmask2 = 0;
2321                     ; 592     uint8_t enablestatus = 0;
2323                     ; 595     assert_param(IS_UART3_GET_IT_OK(UART3_IT));
2325  04c4 a30277        	cpw	x,#631
2326  04c7 2731          	jreq	L472
2327  04c9 a30266        	cpw	x,#614
2328  04cc 272c          	jreq	L472
2329  04ce a30255        	cpw	x,#597
2330  04d1 2727          	jreq	L472
2331  04d3 a30244        	cpw	x,#580
2332  04d6 2722          	jreq	L472
2333  04d8 a30235        	cpw	x,#565
2334  04db 271d          	jreq	L472
2335  04dd a30346        	cpw	x,#838
2336  04e0 2718          	jreq	L472
2337  04e2 a30412        	cpw	x,#1042
2338  04e5 2713          	jreq	L472
2339  04e7 a30100        	cpw	x,#256
2340  04ea 270e          	jreq	L472
2341  04ec ae0253        	ldw	x,#595
2342  04ef 89            	pushw	x
2343  04f0 5f            	clrw	x
2344  04f1 89            	pushw	x
2345  04f2 ae0008        	ldw	x,#L531
2346  04f5 cd0000        	call	_assert_failed
2348  04f8 5b04          	addw	sp,#4
2349  04fa               L472:
2350                     ; 598     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART3_IT & (uint8_t)0x0F));
2352  04fa 7b04          	ld	a,(OFST+2,sp)
2353  04fc a40f          	and	a,#15
2354  04fe 5f            	clrw	x
2355  04ff 97            	ld	xl,a
2356  0500 a601          	ld	a,#1
2357  0502 5d            	tnzw	x
2358  0503 2704          	jreq	L003
2359  0505               L203:
2360  0505 48            	sll	a
2361  0506 5a            	decw	x
2362  0507 26fc          	jrne	L203
2363  0509               L003:
2364  0509 6b01          	ld	(OFST-1,sp),a
2365                     ; 600     itmask1 = (uint8_t)((uint8_t)UART3_IT >> (uint8_t)4);
2367  050b 7b04          	ld	a,(OFST+2,sp)
2368  050d 4e            	swap	a
2369  050e a40f          	and	a,#15
2370  0510 6b02          	ld	(OFST+0,sp),a
2371                     ; 602     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2373  0512 5f            	clrw	x
2374  0513 97            	ld	xl,a
2375  0514 a601          	ld	a,#1
2376  0516 5d            	tnzw	x
2377  0517 2704          	jreq	L403
2378  0519               L603:
2379  0519 48            	sll	a
2380  051a 5a            	decw	x
2381  051b 26fc          	jrne	L603
2382  051d               L403:
2383  051d 6b02          	ld	(OFST+0,sp),a
2384                     ; 605     if (UART3_IT == UART3_IT_PE)
2386  051f 1e03          	ldw	x,(OFST+1,sp)
2387  0521 a30100        	cpw	x,#256
2388  0524 260c          	jrne	L7301
2389                     ; 608         enablestatus = (uint8_t)((uint8_t)UART3->CR1 & itmask2);
2391  0526 c65244        	ld	a,21060
2392  0529 1402          	and	a,(OFST+0,sp)
2393  052b 6b02          	ld	(OFST+0,sp),a
2394                     ; 611         if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2396  052d c65240        	ld	a,21056
2398                     ; 614             pendingbitstatus = SET;
2400  0530 2020          	jp	LC009
2401                     ; 619             pendingbitstatus = RESET;
2402  0532               L7301:
2403                     ; 622     else if (UART3_IT == UART3_IT_LBDF)
2405  0532 a30346        	cpw	x,#838
2406  0535 260c          	jrne	L7401
2407                     ; 625         enablestatus = (uint8_t)((uint8_t)UART3->CR4 & itmask2);
2409  0537 c65247        	ld	a,21063
2410  053a 1402          	and	a,(OFST+0,sp)
2411  053c 6b02          	ld	(OFST+0,sp),a
2412                     ; 627         if (((UART3->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2414  053e c65247        	ld	a,21063
2416                     ; 630             pendingbitstatus = SET;
2418  0541 200f          	jp	LC009
2419                     ; 635             pendingbitstatus = RESET;
2420  0543               L7401:
2421                     ; 638     else if (UART3_IT == UART3_IT_LHDF)
2423  0543 a30412        	cpw	x,#1042
2424  0546 2616          	jrne	L7501
2425                     ; 641         enablestatus = (uint8_t)((uint8_t)UART3->CR6 & itmask2);
2427  0548 c65249        	ld	a,21065
2428  054b 1402          	and	a,(OFST+0,sp)
2429  054d 6b02          	ld	(OFST+0,sp),a
2430                     ; 643         if (((UART3->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2432  054f c65249        	ld	a,21065
2434  0552               LC009:
2435  0552 1501          	bcp	a,(OFST-1,sp)
2436  0554 271a          	jreq	L7601
2437  0556 7b02          	ld	a,(OFST+0,sp)
2438  0558 2716          	jreq	L7601
2439                     ; 646             pendingbitstatus = SET;
2441  055a               LC008:
2445  055a a601          	ld	a,#1
2447  055c 2013          	jra	L5401
2448                     ; 651             pendingbitstatus = RESET;
2449  055e               L7501:
2450                     ; 657         enablestatus = (uint8_t)((uint8_t)UART3->CR2 & itmask2);
2452  055e c65245        	ld	a,21061
2453  0561 1402          	and	a,(OFST+0,sp)
2454  0563 6b02          	ld	(OFST+0,sp),a
2455                     ; 659         if (((UART3->SR & itpos) != (uint8_t)0x00) && enablestatus)
2457  0565 c65240        	ld	a,21056
2458  0568 1501          	bcp	a,(OFST-1,sp)
2459  056a 2704          	jreq	L7601
2461  056c 7b02          	ld	a,(OFST+0,sp)
2462                     ; 662             pendingbitstatus = SET;
2464  056e 26ea          	jrne	LC008
2465  0570               L7601:
2466                     ; 667             pendingbitstatus = RESET;
2471  0570 4f            	clr	a
2472  0571               L5401:
2473                     ; 671     return  pendingbitstatus;
2477  0571 5b04          	addw	sp,#4
2478  0573 81            	ret	
2515                     ; 701 void UART3_ClearITPendingBit(UART3_IT_TypeDef UART3_IT)
2515                     ; 702 {
2516                     	switch	.text
2517  0574               _UART3_ClearITPendingBit:
2519  0574 89            	pushw	x
2520       00000000      OFST:	set	0
2523                     ; 704     assert_param(IS_UART3_CLEAR_IT_OK(UART3_IT));
2525  0575 a30255        	cpw	x,#597
2526  0578 2718          	jreq	L613
2527  057a a30412        	cpw	x,#1042
2528  057d 2713          	jreq	L613
2529  057f a30346        	cpw	x,#838
2530  0582 270e          	jreq	L613
2531  0584 ae02c0        	ldw	x,#704
2532  0587 89            	pushw	x
2533  0588 5f            	clrw	x
2534  0589 89            	pushw	x
2535  058a ae0008        	ldw	x,#L531
2536  058d cd0000        	call	_assert_failed
2538  0590 5b04          	addw	sp,#4
2539  0592               L613:
2540                     ; 707     if (UART3_IT == UART3_IT_RXNE)
2542  0592 1e01          	ldw	x,(OFST+1,sp)
2543  0594 a30255        	cpw	x,#597
2544  0597 2606          	jrne	L1111
2545                     ; 709         UART3->SR = (uint8_t)~(UART3_SR_RXNE);
2547  0599 35df5240      	mov	21056,#223
2549  059d 200f          	jra	L3111
2550  059f               L1111:
2551                     ; 712     else if (UART3_IT == UART3_IT_LBDF)
2553  059f a30346        	cpw	x,#838
2554  05a2 2606          	jrne	L5111
2555                     ; 714         UART3->CR4 &= (uint8_t)~(UART3_CR4_LBDF);
2557  05a4 72195247      	bres	21063,#4
2559  05a8 2004          	jra	L3111
2560  05aa               L5111:
2561                     ; 719         UART3->CR6 &= (uint8_t)(~UART3_CR6_LHDF);
2563  05aa 72135249      	bres	21065,#1
2564  05ae               L3111:
2565                     ; 721 }
2568  05ae 85            	popw	x
2569  05af 81            	ret	
2582                     	xdef	_UART3_ClearITPendingBit
2583                     	xdef	_UART3_GetITStatus
2584                     	xdef	_UART3_ClearFlag
2585                     	xdef	_UART3_GetFlagStatus
2586                     	xdef	_UART3_SetAddress
2587                     	xdef	_UART3_SendBreak
2588                     	xdef	_UART3_SendData9
2589                     	xdef	_UART3_SendData8
2590                     	xdef	_UART3_ReceiveData9
2591                     	xdef	_UART3_ReceiveData8
2592                     	xdef	_UART3_WakeUpConfig
2593                     	xdef	_UART3_ReceiverWakeUpCmd
2594                     	xdef	_UART3_LINCmd
2595                     	xdef	_UART3_LINConfig
2596                     	xdef	_UART3_LINBreakDetectionConfig
2597                     	xdef	_UART3_ITConfig
2598                     	xdef	_UART3_Cmd
2599                     	xdef	_UART3_Init
2600                     	xdef	_UART3_DeInit
2601                     	xref	_assert_failed
2602                     	xref	_CLK_GetClockFreq
2603                     	switch	.const
2604  0008               L531:
2605  0008 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
2606  001a 6965735c7374  	dc.b	"ies\stm8s_stdperip"
2607  002c 685f64726976  	dc.b	"h_driver\src\stm8s"
2608  003e 5f7561727433  	dc.b	"_uart3.c",0
2609                     	xref.b	c_lreg
2610                     	xref.b	c_x
2630                     	xref	c_lursh
2631                     	xref	c_lsub
2632                     	xref	c_smul
2633                     	xref	c_ludv
2634                     	xref	c_rtol
2635                     	xref	c_llsh
2636                     	xref	c_lcmp
2637                     	xref	c_ltor
2638                     	end
