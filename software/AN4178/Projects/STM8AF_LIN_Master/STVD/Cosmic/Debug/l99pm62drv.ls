   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  19                     	switch	.data
  20  0000               L74_InitFlag:
  21  0000 00            	dc.b	0
  22  0001               _count:
  23  0001 00            	dc.b	0
  90                     ; 116 bool L99PM62drv_ReportError (u8 ServiceId, u8 ErrorId)
  90                     ; 117 {
  92                     	switch	.text
  93  0000               _L99PM62drv_ReportError:
  97                     ; 118   ServiceId = ServiceId;  /* to avoid error message parameter not used */
  99                     ; 119   ErrorId   = ErrorId;    /* to avoid error message parameter not used */
 101                     ; 125   return FALSE;   /*  to stop execution of interrupted function by return; */
 103  0000 4f            	clr	a
 106  0001 81            	ret	
 156                     ; 142 void L99PM62drv_Init (void)
 156                     ; 143 {
 157                     	switch	.text
 158  0002               _L99PM62drv_Init:
 160  0002 88            	push	a
 161       00000001      OFST:	set	1
 164                     ; 147   InitFlag = 1U;  /* Flag to notice that L99PM62drv_Init()was already called*/
 166  0003 35010000      	mov	L74_InitFlag,#1
 167                     ; 150   for (i = 0U; i < 2U; i++)
 169  0007 4f            	clr	a
 170  0008 6b01          	ld	(OFST+0,sp),a
 171  000a               L121:
 172                     ; 152     CtrlReg1[i] = 0U;
 174  000a 5f            	clrw	x
 175  000b 97            	ld	xl,a
 176  000c 724f0022      	clr	(L3_CtrlReg1,x)
 177                     ; 153     CtrlReg2[i] = 0U;
 179  0010 5f            	clrw	x
 180  0011 97            	ld	xl,a
 181  0012 724f001e      	clr	(L7_CtrlReg2,x)
 182                     ; 154     CtrlReg3[i] = 0U;
 184  0016 5f            	clrw	x
 185  0017 97            	ld	xl,a
 186  0018 724f001a      	clr	(L31_CtrlReg3,x)
 187                     ; 155     CtrlReg4[i] = 0U;
 189  001c 5f            	clrw	x
 190  001d 97            	ld	xl,a
 191  001e 724f0016      	clr	(L71_CtrlReg4,x)
 192                     ; 156     CtrlReg5[i] = 0U;
 194  0022 5f            	clrw	x
 195  0023 97            	ld	xl,a
 196  0024 724f0012      	clr	(L32_CtrlReg5,x)
 197                     ; 157     CtrlReg6[i] = 0U;
 199  0028 5f            	clrw	x
 200  0029 97            	ld	xl,a
 201  002a 724f000e      	clr	(L72_CtrlReg6,x)
 202                     ; 158     CtrlReg1_old[i] = 0U;
 204  002e 5f            	clrw	x
 205  002f 97            	ld	xl,a
 206  0030 724f0020      	clr	(L5_CtrlReg1_old,x)
 207                     ; 159     CtrlReg2_old[i] = 0U;
 209  0034 5f            	clrw	x
 210  0035 97            	ld	xl,a
 211  0036 724f001c      	clr	(L11_CtrlReg2_old,x)
 212                     ; 160     CtrlReg3_old[i] = 0U;
 214  003a 5f            	clrw	x
 215  003b 97            	ld	xl,a
 216  003c 724f0018      	clr	(L51_CtrlReg3_old,x)
 217                     ; 161     CtrlReg4_old[i] = 0U;
 219  0040 5f            	clrw	x
 220  0041 97            	ld	xl,a
 221  0042 724f0014      	clr	(L12_CtrlReg4_old,x)
 222                     ; 162     CtrlReg5[i] = 0U;
 224  0046 5f            	clrw	x
 225  0047 97            	ld	xl,a
 226  0048 724f0012      	clr	(L32_CtrlReg5,x)
 227                     ; 163     CtrlReg5_old[i] = 0U;
 229  004c 5f            	clrw	x
 230  004d 97            	ld	xl,a
 231  004e 724f0010      	clr	(L52_CtrlReg5_old,x)
 232                     ; 164     CtrlReg6[i] = 0U;
 234  0052 5f            	clrw	x
 235  0053 97            	ld	xl,a
 236  0054 724f000e      	clr	(L72_CtrlReg6,x)
 237                     ; 165     CtrlReg6_old[i] = 0U;
 239  0058 5f            	clrw	x
 240  0059 97            	ld	xl,a
 241  005a 724f000c      	clr	(L13_CtrlReg6_old,x)
 242                     ; 166     StatReg1[i] = 0U;
 244  005e 5f            	clrw	x
 245  005f 97            	ld	xl,a
 246  0060 724f000a      	clr	(L33_StatReg1,x)
 247                     ; 167     StatReg2[i] = 0U;
 249  0064 5f            	clrw	x
 250  0065 97            	ld	xl,a
 251  0066 724f0008      	clr	(L53_StatReg2,x)
 252                     ; 168     StatReg3[i] = 0U;
 254  006a 5f            	clrw	x
 255  006b 97            	ld	xl,a
 256  006c 724f0006      	clr	(L73_StatReg3,x)
 257                     ; 169     ConfigReg[i] = 0U;
 259  0070 5f            	clrw	x
 260  0071 97            	ld	xl,a
 261  0072 724f0004      	clr	(L14_ConfigReg,x)
 262                     ; 170     ConfigReg_old[i] = 0U;
 264  0076 5f            	clrw	x
 265  0077 97            	ld	xl,a
 266  0078 724f0002      	clr	(L34_ConfigReg_old,x)
 267                     ; 150   for (i = 0U; i < 2U; i++)
 269  007c 0c01          	inc	(OFST+0,sp)
 272  007e 7b01          	ld	a,(OFST+0,sp)
 273  0080 a102          	cp	a,#2
 274  0082 2586          	jrult	L121
 275                     ; 172   CtrlReg2[0] |= 0x03U; /* sets the default power on values*/
 277  0084 c6001e        	ld	a,L7_CtrlReg2
 278  0087 aa03          	or	a,#3
 279  0089 c7001e        	ld	L7_CtrlReg2,a
 280                     ; 173   CtrlReg3[0] |= 0x0CU;
 282  008c c6001a        	ld	a,L31_CtrlReg3
 283  008f aa0c          	or	a,#12
 284  0091 c7001a        	ld	L31_CtrlReg3,a
 285                     ; 174   CtrlReg4[1] |= 0x14U;
 287  0094 c60017        	ld	a,L71_CtrlReg4+1
 288  0097 aa14          	or	a,#20
 289  0099 c70017        	ld	L71_CtrlReg4+1,a
 290                     ; 175   CtrlReg4[0] |= 0xF6U;
 292  009c c60016        	ld	a,L71_CtrlReg4
 293  009f aaf6          	or	a,#246
 294  00a1 c70016        	ld	L71_CtrlReg4,a
 295                     ; 176   CtrlReg5[1] |= 0x7fU;
 297  00a4 c60013        	ld	a,L32_CtrlReg5+1
 298  00a7 aa7f          	or	a,#127
 299  00a9 c70013        	ld	L32_CtrlReg5+1,a
 300                     ; 177   CtrlReg6[1] |= 0x7fU;
 302  00ac c6000f        	ld	a,L72_CtrlReg6+1
 303  00af aa7f          	or	a,#127
 304  00b1 c7000f        	ld	L72_CtrlReg6+1,a
 305                     ; 178 }
 308  00b4 84            	pop	a
 309  00b5 81            	ret	
 339                     ; 194 void L99PM62drv_WdgTrigger (void)
 339                     ; 195 {
 340                     	switch	.text
 341  00b6               _L99PM62drv_WdgTrigger:
 345                     ; 198   if (!InitFlag)
 347  00b6 c60000        	ld	a,L74_InitFlag
 348  00b9 260a          	jrne	L731
 349                     ; 200     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_WdgTrigger, L99PM62DRV_EID_UNINIT))
 351  00bb ae0114        	ldw	x,#276
 352  00be cd0000        	call	_L99PM62drv_ReportError
 354  00c1 4d            	tnz	a
 355  00c2 2601          	jrne	L731
 356                     ; 202       return;
 359  00c4 81            	ret	
 360  00c5               L731:
 361                     ; 206   CtrlReg1[0] ^= 0x01U;           /* refresh WD */
 363  00c5 c60022        	ld	a,L3_CtrlReg1
 364  00c8 a801          	xor	a,#1
 365  00ca c70022        	ld	L3_CtrlReg1,a
 366                     ; 207   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
 366                     ; 208                         CtrlReg1,
 366                     ; 209                         &GlobalStatusRegister,
 366                     ; 210                         CtrlReg1_old);
 368  00cd ae0020        	ldw	x,#L5_CtrlReg1_old
 369  00d0 89            	pushw	x
 370  00d1 ae0001        	ldw	x,#L54_GlobalStatusRegister
 371  00d4 89            	pushw	x
 372  00d5 ae0022        	ldw	x,#L3_CtrlReg1
 373  00d8 89            	pushw	x
 374  00d9 a601          	ld	a,#1
 375  00db cd0e70        	call	_ST_SPI_Send_16
 377  00de 5b06          	addw	sp,#6
 378                     ; 211 }
 381  00e0 81            	ret	
 445                     ; 231 void L99PM62drv_SetStandbyMode (L99PM62drv_StandbyModeType mode)
 445                     ; 232 {
 446                     	switch	.text
 447  00e1               _L99PM62drv_SetStandbyMode:
 449  00e1 88            	push	a
 450       00000000      OFST:	set	0
 453                     ; 235   if (!InitFlag)
 455  00e2 c60000        	ld	a,L74_InitFlag
 456  00e5 260b          	jrne	L771
 457                     ; 237     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetStandbyMode, L99PM62DRV_EID_UNINIT))
 459  00e7 ae0214        	ldw	x,#532
 460  00ea cd0000        	call	_L99PM62drv_ReportError
 462  00ed 4d            	tnz	a
 463  00ee 2602          	jrne	L771
 464                     ; 239       return;
 467  00f0 84            	pop	a
 468  00f1 81            	ret	
 469  00f2               L771:
 470                     ; 243   switch (mode)
 472  00f2 7b01          	ld	a,(OFST+1,sp)
 474                     ; 266       return;
 475  00f4 270b          	jreq	L341
 476  00f6 4a            	dec	a
 477  00f7 2729          	jreq	L541
 478                     ; 262     default:
 478                     ; 263 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
 478                     ; 264       L99PM62drv_ReportError (SID_L99PM62drv_SetStandbyMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
 480  00f9 ae020b        	ldw	x,#523
 481  00fc cd0000        	call	_L99PM62drv_ReportError
 483                     ; 266       return;
 486  00ff 84            	pop	a
 487  0100 81            	ret	
 488  0101               L341:
 489                     ; 245     case L99PM62DRV_STANDBYMODE_V1:
 489                     ; 246       CtrlReg1[0] |= 0x06U;
 491  0101 c60022        	ld	a,L3_CtrlReg1
 492  0104 aa06          	or	a,#6
 493  0106 c70022        	ld	L3_CtrlReg1,a
 494                     ; 247       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
 494                     ; 248                             CtrlReg1,
 494                     ; 249                             &GlobalStatusRegister,
 494                     ; 250                             CtrlReg1_old);
 496  0109 ae0020        	ldw	x,#L5_CtrlReg1_old
 497  010c 89            	pushw	x
 498  010d ae0001        	ldw	x,#L54_GlobalStatusRegister
 499  0110 89            	pushw	x
 500  0111 ae0022        	ldw	x,#L3_CtrlReg1
 501  0114 89            	pushw	x
 502  0115 a601          	ld	a,#1
 503  0117 cd0e70        	call	_ST_SPI_Send_16
 505  011a 5b06          	addw	sp,#6
 506                     ; 251       CtrlReg1[0] &= (u8)~0x02U;
 508  011c 72130022      	bres	L3_CtrlReg1,#1
 509                     ; 252       break;
 511  0120 2022          	jra	L502
 512  0122               L541:
 513                     ; 253     case L99PM62DRV_STANDBYMODE_VBAT:
 513                     ; 254       CtrlReg1[0] &= ~0x04U;
 515  0122 72150022      	bres	L3_CtrlReg1,#2
 516                     ; 255       CtrlReg1[0] |= 0x02U;
 518                     ; 256       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
 518                     ; 257                             CtrlReg1,
 518                     ; 258                             &GlobalStatusRegister,
 518                     ; 259                             CtrlReg1_old);  /* should cause power off */
 520  0126 ae0020        	ldw	x,#L5_CtrlReg1_old
 521  0129 72120022      	bset	L3_CtrlReg1,#1
 522  012d 89            	pushw	x
 523  012e ae0001        	ldw	x,#L54_GlobalStatusRegister
 524  0131 89            	pushw	x
 525  0132 ae0022        	ldw	x,#L3_CtrlReg1
 526  0135 89            	pushw	x
 527  0136 4c            	inc	a
 528  0137 cd0e70        	call	_ST_SPI_Send_16
 530  013a 5b06          	addw	sp,#6
 531                     ; 260       CtrlReg1[0] &= (u8)~0x012;            /* line should not be reached */
 533  013c c60022        	ld	a,L3_CtrlReg1
 534  013f a4ed          	and	a,#237
 535  0141 c70022        	ld	L3_CtrlReg1,a
 536                     ; 261       break;
 538  0144               L502:
 539                     ; 268 }
 542  0144 84            	pop	a
 543  0145 81            	ret	
 607                     ; 280 void L99PM62drv_SetOut1Mode (L99PM62drv_Out1ModeType mode)
 607                     ; 281 {
 608                     	switch	.text
 609  0146               _L99PM62drv_SetOut1Mode:
 611  0146 88            	push	a
 612       00000000      OFST:	set	0
 615                     ; 284   if (!InitFlag)
 617  0147 c60000        	ld	a,L74_InitFlag
 618  014a 260b          	jrne	L532
 619                     ; 286     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut1Mode, L99PM62DRV_EID_UNINIT))
 621  014c ae0314        	ldw	x,#788
 622  014f cd0000        	call	_L99PM62drv_ReportError
 624  0152 4d            	tnz	a
 625  0153 2602          	jrne	L532
 626                     ; 288       return;
 629  0155 84            	pop	a
 630  0156 81            	ret	
 631  0157               L532:
 632                     ; 291   if ((mode != L99PM62DRV_OUT1_MODE_PWM1) && (mode != L99PM62DRV_OUT1_MODE_TIMER1))
 634  0157 7b01          	ld	a,(OFST+1,sp)
 635  0159 270e          	jreq	L142
 637  015b 4a            	dec	a
 638  015c 270b          	jreq	L142
 639                     ; 293     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut1Mode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
 641  015e ae030c        	ldw	x,#780
 642  0161 cd0000        	call	_L99PM62drv_ReportError
 644  0164 4d            	tnz	a
 645  0165 2602          	jrne	L142
 646                     ; 295       return;
 649  0167 84            	pop	a
 650  0168 81            	ret	
 651  0169               L142:
 652                     ; 299   CtrlReg1[1] &= (u8)~0x01U;
 654  0169 72110023      	bres	L3_CtrlReg1+1,#0
 655                     ; 300   CtrlReg1[1] |= (u8)mode & 0x01U;
 657  016d 7b01          	ld	a,(OFST+1,sp)
 658  016f a401          	and	a,#1
 659  0171 ca0023        	or	a,L3_CtrlReg1+1
 660  0174 c70023        	ld	L3_CtrlReg1+1,a
 661                     ; 301   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
 661                     ; 302                         CtrlReg1,
 661                     ; 303                         &GlobalStatusRegister,
 661                     ; 304                         CtrlReg1_old);
 663  0177 ae0020        	ldw	x,#L5_CtrlReg1_old
 664  017a 89            	pushw	x
 665  017b ae0001        	ldw	x,#L54_GlobalStatusRegister
 666  017e 89            	pushw	x
 667  017f ae0022        	ldw	x,#L3_CtrlReg1
 668  0182 89            	pushw	x
 669  0183 a601          	ld	a,#1
 670  0185 cd0e70        	call	_ST_SPI_Send_16
 672  0188 5b06          	addw	sp,#6
 673                     ; 305 }
 676  018a 84            	pop	a
 677  018b 81            	ret	
 741                     ; 317 void L99PM62drv_SetOut2Mode (L99PM62drv_Out2ModeType mode)
 741                     ; 318 {
 742                     	switch	.text
 743  018c               _L99PM62drv_SetOut2Mode:
 745  018c 88            	push	a
 746       00000000      OFST:	set	0
 749                     ; 321   if (!InitFlag)
 751  018d c60000        	ld	a,L74_InitFlag
 752  0190 260b          	jrne	L372
 753                     ; 323     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut2Mode, L99PM62DRV_EID_UNINIT))
 755  0192 ae0414        	ldw	x,#1044
 756  0195 cd0000        	call	_L99PM62drv_ReportError
 758  0198 4d            	tnz	a
 759  0199 2602          	jrne	L372
 760                     ; 325       return;
 763  019b 84            	pop	a
 764  019c 81            	ret	
 765  019d               L372:
 766                     ; 329   if ((mode != L99PM62DRV_OUT2_MODE_PWM2) && (mode != L99PM62DRV_OUT2_MODE_TIMER2))
 768  019d 7b01          	ld	a,(OFST+1,sp)
 769  019f 270e          	jreq	L772
 771  01a1 4a            	dec	a
 772  01a2 270b          	jreq	L772
 773                     ; 331     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut2Mode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
 775  01a4 ae040c        	ldw	x,#1036
 776  01a7 cd0000        	call	_L99PM62drv_ReportError
 778  01aa 4d            	tnz	a
 779  01ab 2602          	jrne	L772
 780                     ; 333       return;
 783  01ad 84            	pop	a
 784  01ae 81            	ret	
 785  01af               L772:
 786                     ; 337   CtrlReg1[1] &= (u8)~0x02U;
 788  01af 72130023      	bres	L3_CtrlReg1+1,#1
 789                     ; 338   CtrlReg1[1] |= ((u8)mode & 0x01U) << 1;
 791  01b3 7b01          	ld	a,(OFST+1,sp)
 792  01b5 a401          	and	a,#1
 793  01b7 48            	sll	a
 794  01b8 ca0023        	or	a,L3_CtrlReg1+1
 795  01bb c70023        	ld	L3_CtrlReg1+1,a
 796                     ; 339   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
 796                     ; 340                         CtrlReg1,
 796                     ; 341                         &GlobalStatusRegister,
 796                     ; 342                         CtrlReg1_old);
 798  01be ae0020        	ldw	x,#L5_CtrlReg1_old
 799  01c1 89            	pushw	x
 800  01c2 ae0001        	ldw	x,#L54_GlobalStatusRegister
 801  01c5 89            	pushw	x
 802  01c6 ae0022        	ldw	x,#L3_CtrlReg1
 803  01c9 89            	pushw	x
 804  01ca a601          	ld	a,#1
 805  01cc cd0e70        	call	_ST_SPI_Send_16
 807  01cf 5b06          	addw	sp,#6
 808                     ; 343 }
 811  01d1 84            	pop	a
 812  01d2 81            	ret	
 876                     ; 354 void L99PM62drv_SetOut3Mode (L99PM62drv_Out3ModeType mode)
 876                     ; 355 {
 877                     	switch	.text
 878  01d3               _L99PM62drv_SetOut3Mode:
 880  01d3 88            	push	a
 881       00000000      OFST:	set	0
 884                     ; 358   if (!InitFlag)
 886  01d4 c60000        	ld	a,L74_InitFlag
 887  01d7 260b          	jrne	L133
 888                     ; 360     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut3Mode, L99PM62DRV_EID_UNINIT))
 890  01d9 ae0514        	ldw	x,#1300
 891  01dc cd0000        	call	_L99PM62drv_ReportError
 893  01df 4d            	tnz	a
 894  01e0 2602          	jrne	L133
 895                     ; 362       return;
 898  01e2 84            	pop	a
 899  01e3 81            	ret	
 900  01e4               L133:
 901                     ; 365   if ((mode != L99PM62DRV_OUT3_MODE_FSO) && (mode != L99PM62DRV_OUT3_MODE_PWM3))
 903  01e4 7b01          	ld	a,(OFST+1,sp)
 904  01e6 270e          	jreq	L533
 906  01e8 4a            	dec	a
 907  01e9 270b          	jreq	L533
 908                     ; 367     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut3Mode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
 910  01eb ae050c        	ldw	x,#1292
 911  01ee cd0000        	call	_L99PM62drv_ReportError
 913  01f1 4d            	tnz	a
 914  01f2 2602          	jrne	L533
 915                     ; 369       return;
 918  01f4 84            	pop	a
 919  01f5 81            	ret	
 920  01f6               L533:
 921                     ; 373   CtrlReg1[1] &= (u8)~0x04U;
 923  01f6 72150023      	bres	L3_CtrlReg1+1,#2
 924                     ; 374   CtrlReg1[1] |= ((u8)mode & 0x01U) << 2;
 926  01fa 7b01          	ld	a,(OFST+1,sp)
 927  01fc a401          	and	a,#1
 928  01fe 48            	sll	a
 929  01ff 48            	sll	a
 930  0200 ca0023        	or	a,L3_CtrlReg1+1
 931  0203 c70023        	ld	L3_CtrlReg1+1,a
 932                     ; 375   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
 932                     ; 376                         CtrlReg1,
 932                     ; 377                         &GlobalStatusRegister,
 932                     ; 378                         CtrlReg1_old);
 934  0206 ae0020        	ldw	x,#L5_CtrlReg1_old
 935  0209 89            	pushw	x
 936  020a ae0001        	ldw	x,#L54_GlobalStatusRegister
 937  020d 89            	pushw	x
 938  020e ae0022        	ldw	x,#L3_CtrlReg1
 939  0211 89            	pushw	x
 940  0212 a601          	ld	a,#1
 941  0214 cd0e70        	call	_ST_SPI_Send_16
 943  0217 5b06          	addw	sp,#6
 944                     ; 379 }
 947  0219 84            	pop	a
 948  021a 81            	ret	
1035                     ; 390 void L99PM62drv_SetOut4Mode (L99PM62drv_Out4ModeType mode)
1035                     ; 391 {
1036                     	switch	.text
1037  021b               _L99PM62drv_SetOut4Mode:
1039  021b 88            	push	a
1040  021c 88            	push	a
1041       00000001      OFST:	set	1
1044                     ; 396   if (!InitFlag)
1046  021d c60000        	ld	a,L74_InitFlag
1047  0220 2609          	jrne	L573
1048                     ; 398     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut4Mode, L99PM62DRV_EID_UNINIT))
1050  0222 ae0614        	ldw	x,#1556
1051  0225 cd0000        	call	_L99PM62drv_ReportError
1053  0228 4d            	tnz	a
1054  0229 2713          	jreq	L07
1055                     ; 400       return;
1057  022b               L573:
1058                     ; 403   tmp = (s8)mode;
1060  022b 7b02          	ld	a,(OFST+1,sp)
1061  022d 6b01          	ld	(OFST+0,sp),a
1062                     ; 404   if ((tmp < (s8)L99PM62DRV_OUT4_MODE_OFF) || (tmp > (s8)L99PM62DRV_OUT4_MODE_TIMER2))
1064  022f 2b04          	jrmi	L304
1066  0231 a104          	cp	a,#4
1067  0233 2f0b          	jrslt	L104
1068  0235               L304:
1069                     ; 406     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut4Mode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
1071  0235 ae060c        	ldw	x,#1548
1072  0238 cd0000        	call	_L99PM62drv_ReportError
1074  023b 4d            	tnz	a
1075  023c 2602          	jrne	L104
1076                     ; 408       return;
1077  023e               L07:
1080  023e 85            	popw	x
1081  023f 81            	ret	
1082  0240               L104:
1083                     ; 412   CtrlReg1[1] &= (u8)~0x30U;
1085  0240 c60023        	ld	a,L3_CtrlReg1+1
1086  0243 a4cf          	and	a,#207
1087  0245 c70023        	ld	L3_CtrlReg1+1,a
1088                     ; 413   CtrlReg1[1] |= ((u8)mode & 0x03U) << 4;
1090  0248 7b02          	ld	a,(OFST+1,sp)
1091  024a a403          	and	a,#3
1092  024c 97            	ld	xl,a
1093  024d a610          	ld	a,#16
1094  024f 42            	mul	x,a
1095  0250 9f            	ld	a,xl
1096  0251 ca0023        	or	a,L3_CtrlReg1+1
1097  0254 c70023        	ld	L3_CtrlReg1+1,a
1098                     ; 414   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
1098                     ; 415                         CtrlReg1,
1098                     ; 416                         &GlobalStatusRegister,
1098                     ; 417                         CtrlReg1_old);
1100  0257 ae0020        	ldw	x,#L5_CtrlReg1_old
1101  025a 89            	pushw	x
1102  025b ae0001        	ldw	x,#L54_GlobalStatusRegister
1103  025e 89            	pushw	x
1104  025f ae0022        	ldw	x,#L3_CtrlReg1
1105  0262 89            	pushw	x
1106  0263 a601          	ld	a,#1
1107  0265 cd0e70        	call	_ST_SPI_Send_16
1109  0268 5b06          	addw	sp,#6
1110                     ; 418 }
1112  026a 20d2          	jra	L07
1215                     ; 429 void L99PM62drv_SetOutHSMode (L99PM62drv_OutHSModeType mode)
1215                     ; 430 {
1216                     	switch	.text
1217  026c               _L99PM62drv_SetOutHSMode:
1219  026c 88            	push	a
1220  026d 88            	push	a
1221       00000001      OFST:	set	1
1224                     ; 435   if (!InitFlag)
1226  026e c60000        	ld	a,L74_InitFlag
1227  0271 2609          	jrne	L754
1228                     ; 437     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSMode, L99PM62DRV_EID_UNINIT))
1230  0273 ae0714        	ldw	x,#1812
1231  0276 cd0000        	call	_L99PM62drv_ReportError
1233  0279 4d            	tnz	a
1234  027a 2713          	jreq	L401
1235                     ; 439       return;
1237  027c               L754:
1238                     ; 442   tmp = (s8)mode;
1240  027c 7b02          	ld	a,(OFST+1,sp)
1241  027e 6b01          	ld	(OFST+0,sp),a
1242                     ; 443   if ((tmp < (s8)L99PM62DRV_OUTHS_MODE_OFF) || (tmp > (s8)L99PM62DRV_OUTHS_MODE_ON))
1244  0280 2b04          	jrmi	L564
1246  0282 a106          	cp	a,#6
1247  0284 2f0b          	jrslt	L364
1248  0286               L564:
1249                     ; 445     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSMode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
1251  0286 ae070c        	ldw	x,#1804
1252  0289 cd0000        	call	_L99PM62drv_ReportError
1254  028c 4d            	tnz	a
1255  028d 2602          	jrne	L364
1256                     ; 447       return;
1257  028f               L401:
1260  028f 85            	popw	x
1261  0290 81            	ret	
1262  0291               L364:
1263                     ; 451   switch (mode)
1265  0291 7b02          	ld	a,(OFST+1,sp)
1267                     ; 472       return;                 /* parameter value out of range */
1268  0293 2717          	jreq	L704
1269  0295 4a            	dec	a
1270  0296 2714          	jreq	L704
1271  0298 4a            	dec	a
1272  0299 2711          	jreq	L704
1273  029b 4a            	dec	a
1274  029c 270e          	jreq	L704
1275  029e 4a            	dec	a
1276  029f 2721          	jreq	L114
1277  02a1 4a            	dec	a
1278  02a2 272c          	jreq	L314
1279                     ; 468     default :
1279                     ; 469 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
1279                     ; 470       L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSAutorecovery, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
1281  02a4 ae080b        	ldw	x,#2059
1282  02a7 cd0000        	call	_L99PM62drv_ReportError
1284                     ; 472       return;                 /* parameter value out of range */
1286  02aa 20e3          	jra	L401
1287  02ac               L704:
1288                     ; 453     case L99PM62DRV_OUTHS_MODE_OFF:
1288                     ; 454     case L99PM62DRV_OUTHS_MODE_TIMER1:
1288                     ; 455     case L99PM62DRV_OUTHS_MODE_PWM4:
1288                     ; 456     case L99PM62DRV_OUTHS_MODE_TIMER2:
1288                     ; 457       CtrlReg1[1] &= (u8)~0xC8U;
1290  02ac c60023        	ld	a,L3_CtrlReg1+1
1291  02af a437          	and	a,#55
1292  02b1 c70023        	ld	L3_CtrlReg1+1,a
1293                     ; 458       CtrlReg1[1] |= ((u8)mode & 0x03U) << 6;
1295  02b4 7b02          	ld	a,(OFST+1,sp)
1296  02b6 a403          	and	a,#3
1297  02b8 97            	ld	xl,a
1298  02b9 a640          	ld	a,#64
1299  02bb 42            	mul	x,a
1300  02bc 9f            	ld	a,xl
1301  02bd ca0023        	or	a,L3_CtrlReg1+1
1302                     ; 459       break;
1304  02c0 2015          	jp	LC001
1305  02c2               L114:
1306                     ; 460     case L99PM62DRV_OUTHS_MODE_PWM3:
1306                     ; 461       CtrlReg1[1] &= (u8)~0xC8U;
1308  02c2 c60023        	ld	a,L3_CtrlReg1+1
1309  02c5 a437          	and	a,#55
1310  02c7 c70023        	ld	L3_CtrlReg1+1,a
1311                     ; 462       CtrlReg1[1] |= 0x08;
1313  02ca 72160023      	bset	L3_CtrlReg1+1,#3
1314                     ; 463       break;
1316  02ce 200a          	jra	L374
1317  02d0               L314:
1318                     ; 464     case L99PM62DRV_OUTHS_MODE_ON:
1318                     ; 465       CtrlReg1[1] &= (u8)~0xC8U;
1320  02d0 c60023        	ld	a,L3_CtrlReg1+1
1321  02d3 a437          	and	a,#55
1322                     ; 466       CtrlReg1[1] |= 0x48;
1324  02d5 aa48          	or	a,#72
1325  02d7               LC001:
1326  02d7 c70023        	ld	L3_CtrlReg1+1,a
1327                     ; 467       break;
1329  02da               L374:
1330                     ; 475   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
1330                     ; 476                         CtrlReg1,
1330                     ; 477                         &GlobalStatusRegister,
1330                     ; 478                         CtrlReg1_old);
1332  02da ae0020        	ldw	x,#L5_CtrlReg1_old
1333  02dd 89            	pushw	x
1334  02de ae0001        	ldw	x,#L54_GlobalStatusRegister
1335  02e1 89            	pushw	x
1336  02e2 ae0022        	ldw	x,#L3_CtrlReg1
1337  02e5 89            	pushw	x
1338  02e6 a601          	ld	a,#1
1339  02e8 cd0e70        	call	_ST_SPI_Send_16
1341  02eb 5b06          	addw	sp,#6
1342                     ; 479 }
1344  02ed 20a0          	jra	L401
1406                     ; 493 void L99PM62drv_SetOutHSAutorecovery (L99PM62drv_EnableType autorecoveryMode)
1406                     ; 494 {
1407                     	switch	.text
1408  02ef               _L99PM62drv_SetOutHSAutorecovery:
1410  02ef 88            	push	a
1411       00000000      OFST:	set	0
1414                     ; 497   if (!InitFlag)
1416  02f0 c60000        	ld	a,L74_InitFlag
1417  02f3 260b          	jrne	L135
1418                     ; 499     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSAutorecovery, L99PM62DRV_EID_UNINIT))
1420  02f5 ae0814        	ldw	x,#2068
1421  02f8 cd0000        	call	_L99PM62drv_ReportError
1423  02fb 4d            	tnz	a
1424  02fc 2602          	jrne	L135
1425                     ; 501       return;
1428  02fe 84            	pop	a
1429  02ff 81            	ret	
1430  0300               L135:
1431                     ; 505   switch (autorecoveryMode)
1433  0300 7b01          	ld	a,(OFST+1,sp)
1435                     ; 517       return;                 /* parameter value out of range */
1436  0302 270b          	jreq	L574
1437  0304 4a            	dec	a
1438  0305 270e          	jreq	L774
1439                     ; 513     default:
1439                     ; 514 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
1439                     ; 515       L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSAutorecovery, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
1441  0307 ae080b        	ldw	x,#2059
1442  030a cd0000        	call	_L99PM62drv_ReportError
1444                     ; 517       return;                 /* parameter value out of range */
1447  030d 84            	pop	a
1448  030e 81            	ret	
1449  030f               L574:
1450                     ; 507     case L99PM62DRV_DISABLE:
1450                     ; 508       CtrlReg4[1] &= (u8)~0x20U;
1452  030f 721b0017      	bres	L71_CtrlReg4+1,#5
1453                     ; 509       break;
1455  0313 2004          	jra	L735
1456  0315               L774:
1457                     ; 510     case L99PM62DRV_ENABLE:
1457                     ; 511       CtrlReg4[1] |= 0x20U;
1459  0315 721a0017      	bset	L71_CtrlReg4+1,#5
1460                     ; 512       break;
1462  0319               L735:
1463                     ; 519   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
1463                     ; 520                         CtrlReg4,
1463                     ; 521                         &GlobalStatusRegister,
1463                     ; 522                         CtrlReg4_old);
1465  0319 ae0014        	ldw	x,#L12_CtrlReg4_old
1466  031c 89            	pushw	x
1467  031d ae0001        	ldw	x,#L54_GlobalStatusRegister
1468  0320 89            	pushw	x
1469  0321 ae0016        	ldw	x,#L71_CtrlReg4
1470  0324 89            	pushw	x
1471  0325 a604          	ld	a,#4
1472  0327 cd0e70        	call	_ST_SPI_Send_16
1474  032a 5b06          	addw	sp,#6
1475                     ; 523 }
1478  032c 84            	pop	a
1479  032d 81            	ret	
1584                     ; 551 void L99PM62drv_SetRelayOutput (L99PM62drv_RelayOutputType value)
1584                     ; 552 {
1585                     	switch	.text
1586  032e               _L99PM62drv_SetRelayOutput:
1588  032e 88            	push	a
1589       00000000      OFST:	set	0
1592                     ; 555   if (!InitFlag)
1594  032f c60000        	ld	a,L74_InitFlag
1595  0332 260b          	jrne	L526
1596                     ; 557     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetRelayOutput, L99PM62DRV_EID_UNINIT))
1598  0334 ae0914        	ldw	x,#2324
1599  0337 cd0000        	call	_L99PM62drv_ReportError
1601  033a 4d            	tnz	a
1602  033b 2602          	jrne	L526
1603                     ; 559       return;
1606  033d 84            	pop	a
1607  033e 81            	ret	
1608  033f               L526:
1609                     ; 563   switch (value)
1611  033f 7b01          	ld	a,(OFST+1,sp)
1613                     ; 601       return;                 /* parameter value out of range */
1614  0341 271d          	jreq	L145
1615  0343 4a            	dec	a
1616  0344 2724          	jreq	L345
1617  0346 4a            	dec	a
1618  0347 272b          	jreq	L545
1619  0349 4a            	dec	a
1620  034a 272e          	jreq	L745
1621  034c 4a            	dec	a
1622  034d 2731          	jreq	L155
1623  034f 4a            	dec	a
1624  0350 2734          	jreq	L355
1625  0352 4a            	dec	a
1626  0353 2737          	jreq	L555
1627  0355 4a            	dec	a
1628  0356 273a          	jreq	L755
1629                     ; 597     default:
1629                     ; 598 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
1629                     ; 599       L99PM62drv_ReportError (SID_L99PM62drv_SetRelayOutput, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
1631  0358 ae090b        	ldw	x,#2315
1632  035b cd0000        	call	_L99PM62drv_ReportError
1634                     ; 601       return;                 /* parameter value out of range */
1637  035e 84            	pop	a
1638  035f 81            	ret	
1639  0360               L145:
1640                     ; 565     case RELAYOUTPUT_OFF_OFF:   /* Switch both relays off. */
1640                     ; 566       REL1_OFF;
1642  0360 721d0022      	bres	L3_CtrlReg1,#6
1643                     ; 567       REL2_OFF;
1645  0364 721f0022      	bres	L3_CtrlReg1,#7
1646                     ; 568       break;
1648  0368 202c          	jra	L336
1649  036a               L345:
1650                     ; 569     case RELAYOUTPUT_ON_OFF:    /* Switch relay REL1 on and REL2 off.*/
1650                     ; 570       REL1_ON;
1652  036a 721c0022      	bset	L3_CtrlReg1,#6
1653                     ; 571       REL2_OFF;
1655  036e 721f0022      	bres	L3_CtrlReg1,#7
1656                     ; 572       break;
1658  0372 2022          	jra	L336
1659  0374               L545:
1660                     ; 573     case RELAYOUTPUT_OFF_ON:    /* Switch relay REL1 off and REL2 on.*/
1660                     ; 574       REL1_OFF;
1662  0374 721d0022      	bres	L3_CtrlReg1,#6
1663                     ; 575       REL2_ON;
1664                     ; 576       break;
1666  0378 2018          	jp	L755
1667  037a               L745:
1668                     ; 577     case RELAYOUTPUT_ON_ON:     /* Switch both relays on.*/
1668                     ; 578       REL1_ON;
1670  037a 721c0022      	bset	L3_CtrlReg1,#6
1671                     ; 579       REL2_ON;
1672                     ; 580       break;
1674  037e 2012          	jp	L755
1675  0380               L155:
1676                     ; 581     case RELAYOUTPUT_OFF_X:     /* Switch relay REL1 off and refresh
1676                     ; 582                                               previous state of REL2 (don’t change).*/
1676                     ; 583       REL1_OFF;
1678  0380 721d0022      	bres	L3_CtrlReg1,#6
1679                     ; 584       break;
1681  0384 2010          	jra	L336
1682  0386               L355:
1683                     ; 585     case RELAYOUTPUT_ON_X:      /* Switch relay REL1 on and refresh
1683                     ; 586                                               previous stateof REL2 (don’t change).*/
1683                     ; 587       REL1_ON;
1685  0386 721c0022      	bset	L3_CtrlReg1,#6
1686                     ; 588       break;
1688  038a 200a          	jra	L336
1689  038c               L555:
1690                     ; 589     case RELAYOUTPUT_X_OFF:     /* Switch relay REL2 off and refresh
1690                     ; 590                                               previous state of REL1 (don’t change).*/
1690                     ; 591       REL2_OFF;
1692  038c 721f0022      	bres	L3_CtrlReg1,#7
1693                     ; 592       break;
1695  0390 2004          	jra	L336
1696  0392               L755:
1697                     ; 593     case RELAYOUTPUT_X_ON:      /* Switch relay REL2 on and refresh
1697                     ; 594                                               previous state of REL1 (don’t change).*/
1697                     ; 595       REL2_ON;
1701  0392 721e0022      	bset	L3_CtrlReg1,#7
1702                     ; 596       break;
1704  0396               L336:
1705                     ; 603   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
1705                     ; 604                         CtrlReg1,
1705                     ; 605                         &GlobalStatusRegister,
1705                     ; 606                         CtrlReg1_old);
1707  0396 ae0020        	ldw	x,#L5_CtrlReg1_old
1708  0399 89            	pushw	x
1709  039a ae0001        	ldw	x,#L54_GlobalStatusRegister
1710  039d 89            	pushw	x
1711  039e ae0022        	ldw	x,#L3_CtrlReg1
1712  03a1 89            	pushw	x
1713  03a2 a601          	ld	a,#1
1714  03a4 cd0e70        	call	_ST_SPI_Send_16
1716  03a7 5b06          	addw	sp,#6
1717                     ; 608 }
1720  03a9 84            	pop	a
1721  03aa 81            	ret	
1808                     ; 621 void L99PM62drv_SetVoltageReg2Mode (L99PM62drv_VoltageReg2ModeType mode)
1808                     ; 622 {
1809                     	switch	.text
1810  03ab               _L99PM62drv_SetVoltageReg2Mode:
1812  03ab 88            	push	a
1813  03ac 88            	push	a
1814       00000001      OFST:	set	1
1817                     ; 627   if (!InitFlag)
1819  03ad c60000        	ld	a,L74_InitFlag
1820  03b0 2609          	jrne	L176
1821                     ; 629     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetVoltageReg2Mode, L99PM62DRV_EID_UNINIT))
1823  03b2 ae0a14        	ldw	x,#2580
1824  03b5 cd0000        	call	_L99PM62drv_ReportError
1826  03b8 4d            	tnz	a
1827  03b9 2713          	jreq	L631
1828                     ; 631       return;
1830  03bb               L176:
1831                     ; 634   tmp = (s8)mode;
1833  03bb 7b02          	ld	a,(OFST+1,sp)
1834  03bd 6b01          	ld	(OFST+0,sp),a
1835                     ; 635   if ((tmp < (s8)L99PM62DRV_VOLTAGE_REG2_OFF) || (tmp > (s8)L99PM62DRV_VOLTAGE_REG2_ON))
1837  03bf 2b04          	jrmi	L776
1839  03c1 a104          	cp	a,#4
1840  03c3 2f0b          	jrslt	L576
1841  03c5               L776:
1842                     ; 637     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetVoltageReg2Mode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
1844  03c5 ae0a0b        	ldw	x,#2571
1845  03c8 cd0000        	call	_L99PM62drv_ReportError
1847  03cb 4d            	tnz	a
1848  03cc 2602          	jrne	L576
1849                     ; 639       return;
1850  03ce               L631:
1853  03ce 85            	popw	x
1854  03cf 81            	ret	
1855  03d0               L576:
1856                     ; 644   CtrlReg1[0] &= (u8)~0x30U;
1858  03d0 c60022        	ld	a,L3_CtrlReg1
1859  03d3 a4cf          	and	a,#207
1860  03d5 c70022        	ld	L3_CtrlReg1,a
1861                     ; 645   CtrlReg1[0] |= (u8)((mode & 0x03) << 4);
1863  03d8 7b02          	ld	a,(OFST+1,sp)
1864  03da a403          	and	a,#3
1865  03dc 97            	ld	xl,a
1866  03dd a610          	ld	a,#16
1867  03df 42            	mul	x,a
1868  03e0 9f            	ld	a,xl
1869  03e1 ca0022        	or	a,L3_CtrlReg1
1870  03e4 c70022        	ld	L3_CtrlReg1,a
1871                     ; 646   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
1871                     ; 647                         CtrlReg1,
1871                     ; 648                         &GlobalStatusRegister,
1871                     ; 649                         CtrlReg1_old);
1873  03e7 ae0020        	ldw	x,#L5_CtrlReg1_old
1874  03ea 89            	pushw	x
1875  03eb ae0001        	ldw	x,#L54_GlobalStatusRegister
1876  03ee 89            	pushw	x
1877  03ef ae0022        	ldw	x,#L3_CtrlReg1
1878  03f2 89            	pushw	x
1879  03f3 a601          	ld	a,#1
1880  03f5 cd0e70        	call	_ST_SPI_Send_16
1882  03f8 5b06          	addw	sp,#6
1883                     ; 650 }
1885  03fa 20d2          	jra	L631
2004                     ; 666 void L99PM62drv_SetTimer1 (L99PM62drv_Timer1PeriodType period, L99PM62drv_Timer1ONTimeType ontime)
2004                     ; 667 {
2005                     	switch	.text
2006  03fc               _L99PM62drv_SetTimer1:
2008  03fc 89            	pushw	x
2009  03fd 88            	push	a
2010       00000001      OFST:	set	1
2013                     ; 672   if (!InitFlag)
2015  03fe c60000        	ld	a,L74_InitFlag
2016  0401 2609          	jrne	L357
2017                     ; 674     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer1, L99PM62DRV_EID_UNINIT))
2019  0403 ae0b14        	ldw	x,#2836
2020  0406 cd0000        	call	_L99PM62drv_ReportError
2022  0409 4d            	tnz	a
2023  040a 2713          	jreq	L251
2024                     ; 676       return;
2026  040c               L357:
2027                     ; 679   tmp = (s8)period;
2029  040c 7b02          	ld	a,(OFST+1,sp)
2030  040e 6b01          	ld	(OFST+0,sp),a
2031                     ; 680   if ((tmp < (s8)L99PM62DRV_TIMER1PERIOD_1) || (tmp > (s8)L99PM62DRV_TIMER1PERIOD_4))
2033  0410 2b04          	jrmi	L167
2035  0412 a104          	cp	a,#4
2036  0414 2f0c          	jrslt	L757
2037  0416               L167:
2038                     ; 682     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer1, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
2040  0416 ae0b0b        	ldw	x,#2827
2041  0419 cd0000        	call	_L99PM62drv_ReportError
2043  041c 4d            	tnz	a
2044  041d 2603          	jrne	L757
2045                     ; 684       return;
2046  041f               L251:
2049  041f 5b03          	addw	sp,#3
2050  0421 81            	ret	
2051  0422               L757:
2052                     ; 687   if ((ontime != L99PM62DRV_TIMER1ONTIME_10) && (ontime != L99PM62DRV_TIMER1ONTIME_20))
2054  0422 7b03          	ld	a,(OFST+2,sp)
2055  0424 270c          	jreq	L567
2057  0426 4a            	dec	a
2058  0427 2709          	jreq	L567
2059                     ; 689     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer1, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
2061  0429 ae0b0c        	ldw	x,#2828
2062  042c cd0000        	call	_L99PM62drv_ReportError
2064  042f 4d            	tnz	a
2065  0430 27ed          	jreq	L251
2066                     ; 691       return;
2068  0432               L567:
2069                     ; 696   CtrlReg3[1] &= (u8)~0x70U;
2071  0432 c6001b        	ld	a,L31_CtrlReg3+1
2072  0435 a48f          	and	a,#143
2073  0437 c7001b        	ld	L31_CtrlReg3+1,a
2074                     ; 697   CtrlReg3[1] |= (u8)((u8)ontime << 6) & 0x40U;
2076  043a 7b03          	ld	a,(OFST+2,sp)
2077  043c 97            	ld	xl,a
2078  043d a640          	ld	a,#64
2079  043f 42            	mul	x,a
2080  0440 9f            	ld	a,xl
2081  0441 a440          	and	a,#64
2082  0443 ca001b        	or	a,L31_CtrlReg3+1
2083  0446 c7001b        	ld	L31_CtrlReg3+1,a
2084                     ; 698   CtrlReg3[1] |= (u8)((u8)period << 4) & 0x30U;
2086  0449 7b02          	ld	a,(OFST+1,sp)
2087  044b 97            	ld	xl,a
2088  044c a610          	ld	a,#16
2089  044e 42            	mul	x,a
2090  044f 9f            	ld	a,xl
2091  0450 a430          	and	a,#48
2092  0452 ca001b        	or	a,L31_CtrlReg3+1
2093  0455 c7001b        	ld	L31_CtrlReg3+1,a
2094                     ; 699   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
2094                     ; 700                         CtrlReg3,
2094                     ; 701                         &GlobalStatusRegister,
2094                     ; 702                         CtrlReg3_old);
2096  0458 ae0018        	ldw	x,#L51_CtrlReg3_old
2097  045b 89            	pushw	x
2098  045c ae0001        	ldw	x,#L54_GlobalStatusRegister
2099  045f 89            	pushw	x
2100  0460 ae001a        	ldw	x,#L31_CtrlReg3
2101  0463 89            	pushw	x
2102  0464 a603          	ld	a,#3
2103  0466 cd0e70        	call	_ST_SPI_Send_16
2105  0469 5b06          	addw	sp,#6
2106                     ; 703 }
2108  046b 20b2          	jra	L251
2227                     ; 719 void L99PM62drv_SetTimer2 (L99PM62drv_Timer2PeriodType period, L99PM62drv_Timer2ONTimeType ontime)
2227                     ; 720 {
2228                     	switch	.text
2229  046d               _L99PM62drv_SetTimer2:
2231  046d 89            	pushw	x
2232  046e 88            	push	a
2233       00000001      OFST:	set	1
2236                     ; 724   if (!InitFlag)
2238  046f c60000        	ld	a,L74_InitFlag
2239  0472 2609          	jrne	L1401
2240                     ; 726     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer2, L99PM62DRV_EID_UNINIT))
2242  0474 ae0c14        	ldw	x,#3092
2243  0477 cd0000        	call	_L99PM62drv_ReportError
2245  047a 4d            	tnz	a
2246  047b 2713          	jreq	L661
2247                     ; 728       return;
2249  047d               L1401:
2250                     ; 731   tmp = (s8)period;
2252  047d 7b02          	ld	a,(OFST+1,sp)
2253  047f 6b01          	ld	(OFST+0,sp),a
2254                     ; 732   if ((tmp < (s8)L99PM62DRV_TIMER2PERIOD_10) || (tmp > (s8)L99PM62DRV_TIMER2PERIOD_200))
2256  0481 2b04          	jrmi	L7401
2258  0483 a104          	cp	a,#4
2259  0485 2f0c          	jrslt	L5401
2260  0487               L7401:
2261                     ; 734     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer2, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
2263  0487 ae0c0b        	ldw	x,#3083
2264  048a cd0000        	call	_L99PM62drv_ReportError
2266  048d 4d            	tnz	a
2267  048e 2603          	jrne	L5401
2268                     ; 736       return;
2269  0490               L661:
2272  0490 5b03          	addw	sp,#3
2273  0492 81            	ret	
2274  0493               L5401:
2275                     ; 739   if ((ontime != L99PM62DRV_TIMER2ONTIME_01) && (ontime != L99PM62DRV_TIMER2ONTIME_1))
2277  0493 7b03          	ld	a,(OFST+2,sp)
2278  0495 270c          	jreq	L3501
2280  0497 4a            	dec	a
2281  0498 2709          	jreq	L3501
2282                     ; 741     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer2, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
2284  049a ae0c0c        	ldw	x,#3084
2285  049d cd0000        	call	_L99PM62drv_ReportError
2287  04a0 4d            	tnz	a
2288  04a1 27ed          	jreq	L661
2289                     ; 743       return;
2291  04a3               L3501:
2292                     ; 747   CtrlReg3[1] &= (u8)~0x07U;
2294  04a3 c6001b        	ld	a,L31_CtrlReg3+1
2295  04a6 a4f8          	and	a,#248
2296  04a8 c7001b        	ld	L31_CtrlReg3+1,a
2297                     ; 748   CtrlReg3[1] |= (u8)((u8)ontime << 2) & 0x04U;
2299  04ab 7b03          	ld	a,(OFST+2,sp)
2300  04ad 48            	sll	a
2301  04ae 48            	sll	a
2302  04af a404          	and	a,#4
2303  04b1 ca001b        	or	a,L31_CtrlReg3+1
2304  04b4 c7001b        	ld	L31_CtrlReg3+1,a
2305                     ; 749   CtrlReg3[1] |= (u8)((u8)period ) & 0x03U;
2307  04b7 7b02          	ld	a,(OFST+1,sp)
2308  04b9 a403          	and	a,#3
2309  04bb ca001b        	or	a,L31_CtrlReg3+1
2310  04be c7001b        	ld	L31_CtrlReg3+1,a
2311                     ; 750   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
2311                     ; 751                         CtrlReg3,
2311                     ; 752                         &GlobalStatusRegister,
2311                     ; 753                         CtrlReg3_old);
2313  04c1 ae0018        	ldw	x,#L51_CtrlReg3_old
2314  04c4 89            	pushw	x
2315  04c5 ae0001        	ldw	x,#L54_GlobalStatusRegister
2316  04c8 89            	pushw	x
2317  04c9 ae001a        	ldw	x,#L31_CtrlReg3
2318  04cc 89            	pushw	x
2319  04cd a603          	ld	a,#3
2320  04cf cd0e70        	call	_ST_SPI_Send_16
2322  04d2 5b06          	addw	sp,#6
2323                     ; 754 }
2325  04d4 20ba          	jra	L661
2396                     ; 782 void L99PM62drv_SetWUInputMode (u8 mask, L99PM62drv_WUInputModeType mode)
2396                     ; 783 {
2397                     	switch	.text
2398  04d6               _L99PM62drv_SetWUInputMode:
2400  04d6 89            	pushw	x
2401       00000000      OFST:	set	0
2404                     ; 786   if (!InitFlag)
2406  04d7 c60000        	ld	a,L74_InitFlag
2407  04da 2609          	jrne	L7011
2408                     ; 788     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetWUInputMode, L99PM62DRV_EID_UNINIT))
2410  04dc ae0d14        	ldw	x,#3348
2411  04df cd0000        	call	_L99PM62drv_ReportError
2413  04e2 4d            	tnz	a
2414  04e3 270f          	jreq	L202
2415                     ; 790       return;
2417  04e5               L7011:
2418                     ; 793   if (mask & (u8)~0x0FU)
2420  04e5 7b01          	ld	a,(OFST+1,sp)
2421  04e7 a5f0          	bcp	a,#240
2422  04e9 270b          	jreq	L3111
2423                     ; 795     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetWUInputMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
2425  04eb ae0d0b        	ldw	x,#3339
2426  04ee cd0000        	call	_L99PM62drv_ReportError
2428  04f1 4d            	tnz	a
2429  04f2 2602          	jrne	L3111
2430                     ; 797       return;
2431  04f4               L202:
2434  04f4 85            	popw	x
2435  04f5 81            	ret	
2436  04f6               L3111:
2437                     ; 800   if ((mode != L99PM62DRV_WU_INPUT_MODE_CUR_SINK) && (mode != L99PM62DRV_WU_INPUT_MODE_CUR_SOURCE))
2439  04f6 7b02          	ld	a,(OFST+2,sp)
2440  04f8 270c          	jreq	L7111
2442  04fa 4a            	dec	a
2443  04fb 2709          	jreq	L7111
2444                     ; 802     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetWUInputMode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
2446  04fd ae0d0c        	ldw	x,#3340
2447  0500 cd0000        	call	_L99PM62drv_ReportError
2449  0503 4d            	tnz	a
2450  0504 27ee          	jreq	L202
2451                     ; 804       return;
2453  0506               L7111:
2454                     ; 809   if (mask & L99PM62DRV_MASK_WU1)
2456  0506 7b01          	ld	a,(OFST+1,sp)
2457  0508 a501          	bcp	a,#1
2458  050a 270e          	jreq	L3211
2459                     ; 811     if (mode == L99PM62DRV_WU_INPUT_MODE_CUR_SINK)
2461  050c 0d02          	tnz	(OFST+2,sp)
2462  050e 2606          	jrne	L5211
2463                     ; 813       CtrlReg2[0] &= (u8)~0x10U;
2465  0510 7219001e      	bres	L7_CtrlReg2,#4
2467  0514 2004          	jra	L3211
2468  0516               L5211:
2469                     ; 817       CtrlReg2[0] |= 0x10U;
2471  0516 7218001e      	bset	L7_CtrlReg2,#4
2472  051a               L3211:
2473                     ; 820   if (mask & L99PM62DRV_MASK_WU2)
2475  051a a502          	bcp	a,#2
2476  051c 270e          	jreq	L1311
2477                     ; 822     if (mode == L99PM62DRV_WU_INPUT_MODE_CUR_SINK)
2479  051e 7b02          	ld	a,(OFST+2,sp)
2480  0520 2606          	jrne	L3311
2481                     ; 824       CtrlReg2[0] &= (u8)~0x20U;
2483  0522 721b001e      	bres	L7_CtrlReg2,#5
2485  0526 2004          	jra	L1311
2486  0528               L3311:
2487                     ; 828       CtrlReg2[0] |= 0x20U;
2489  0528 721a001e      	bset	L7_CtrlReg2,#5
2490  052c               L1311:
2491                     ; 831   if (mask & L99PM62DRV_MASK_WU3)
2493  052c 7b01          	ld	a,(OFST+1,sp)
2494  052e a504          	bcp	a,#4
2495  0530 270e          	jreq	L7311
2496                     ; 833     if (mode == L99PM62DRV_WU_INPUT_MODE_CUR_SINK)
2498  0532 7b02          	ld	a,(OFST+2,sp)
2499  0534 2606          	jrne	L1411
2500                     ; 835       CtrlReg2[0] &= (u8)~0x40U;
2502  0536 721d001e      	bres	L7_CtrlReg2,#6
2504  053a 2004          	jra	L7311
2505  053c               L1411:
2506                     ; 839       CtrlReg2[0] |= 0x40U;
2508  053c 721c001e      	bset	L7_CtrlReg2,#6
2509  0540               L7311:
2510                     ; 842   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR2,
2510                     ; 843                         CtrlReg2,
2510                     ; 844                         &GlobalStatusRegister,
2510                     ; 845                         CtrlReg2_old);
2512  0540 ae001c        	ldw	x,#L11_CtrlReg2_old
2513  0543 89            	pushw	x
2514  0544 ae0001        	ldw	x,#L54_GlobalStatusRegister
2515  0547 89            	pushw	x
2516  0548 ae001e        	ldw	x,#L7_CtrlReg2
2517  054b 89            	pushw	x
2518  054c a602          	ld	a,#2
2519  054e cd0e70        	call	_ST_SPI_Send_16
2521  0551 5b06          	addw	sp,#6
2522                     ; 846 }
2524  0553 209f          	jra	L202
2570                     ; 870 void L99PM62drv_EnableWakeupSource (u8 mask, u8 bitpattern)
2570                     ; 871 {
2571                     	switch	.text
2572  0555               _L99PM62drv_EnableWakeupSource:
2574  0555 89            	pushw	x
2575       00000000      OFST:	set	0
2578                     ; 874   if (!InitFlag)
2580  0556 c60000        	ld	a,L74_InitFlag
2581  0559 2609          	jrne	L3611
2582                     ; 876     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_EnableWakeupSource, L99PM62DRV_EID_UNINIT))
2584  055b ae0e14        	ldw	x,#3604
2585  055e cd0000        	call	_L99PM62drv_ReportError
2587  0561 4d            	tnz	a
2588  0562 272a          	jreq	L212
2589                     ; 878       return;
2591  0564               L3611:
2592                     ; 882   CtrlReg2[0] &= (u8)~(mask & 0x07U);
2594  0564 7b01          	ld	a,(OFST+1,sp)
2595  0566 a407          	and	a,#7
2596  0568 43            	cpl	a
2597  0569 c4001e        	and	a,L7_CtrlReg2
2598  056c c7001e        	ld	L7_CtrlReg2,a
2599                     ; 883   CtrlReg2[0] |= (bitpattern & mask) & 0x07U;
2601  056f 7b02          	ld	a,(OFST+2,sp)
2602  0571 1401          	and	a,(OFST+1,sp)
2603  0573 a407          	and	a,#7
2604  0575 ca001e        	or	a,L7_CtrlReg2
2605  0578 c7001e        	ld	L7_CtrlReg2,a
2606                     ; 884   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR2,
2606                     ; 885                         CtrlReg2,
2606                     ; 886                         &GlobalStatusRegister,
2606                     ; 887                         CtrlReg2_old);
2608  057b ae001c        	ldw	x,#L11_CtrlReg2_old
2609  057e 89            	pushw	x
2610  057f ae0001        	ldw	x,#L54_GlobalStatusRegister
2611  0582 89            	pushw	x
2612  0583 ae001e        	ldw	x,#L7_CtrlReg2
2613  0586 89            	pushw	x
2614  0587 a602          	ld	a,#2
2615  0589 cd0e70        	call	_ST_SPI_Send_16
2617  058c 5b06          	addw	sp,#6
2618                     ; 888 }
2619  058e               L212:
2622  058e 85            	popw	x
2623  058f 81            	ret	
2703                     ; 901 void L99PM62drv_SetResetThresholdLevel (L99PM62drv_ResetThresholdLevelType level)
2703                     ; 902 {
2704                     	switch	.text
2705  0590               _L99PM62drv_SetResetThresholdLevel:
2707  0590 88            	push	a
2708       00000000      OFST:	set	0
2711                     ; 905   if (!InitFlag)
2713  0591 c60000        	ld	a,L74_InitFlag
2714  0594 260b          	jrne	L3321
2715                     ; 907     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetResetThresholdLevel, L99PM62DRV_EID_UNINIT))
2717  0596 ae0f14        	ldw	x,#3860
2718  0599 cd0000        	call	_L99PM62drv_ReportError
2720  059c 4d            	tnz	a
2721  059d 2602          	jrne	L3321
2722                     ; 909       return;
2725  059f 84            	pop	a
2726  05a0 81            	ret	
2727  05a1               L3321:
2728                     ; 913   switch (level)
2730  05a1 7b01          	ld	a,(OFST+1,sp)
2732                     ; 933       return;
2733  05a3 2734          	jreq	L5711
2734  05a5 4a            	dec	a
2735  05a6 2723          	jreq	L3711
2736  05a8 4a            	dec	a
2737  05a9 2712          	jreq	L1711
2738  05ab 4a            	dec	a
2739  05ac 2708          	jreq	L7611
2740                     ; 929     default:
2740                     ; 930 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
2740                     ; 931       L99PM62drv_ReportError (SID_L99PM62drv_SetResetThresholdLevel, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
2742  05ae ae0f0b        	ldw	x,#3851
2743  05b1 cd0000        	call	_L99PM62drv_ReportError
2745                     ; 933       return;
2748  05b4 84            	pop	a
2749  05b5 81            	ret	
2750  05b6               L7611:
2751                     ; 915     case  L99PM62DRV_RESET_THRESHOLD_3800:
2751                     ; 916       CtrlReg4[1] |= (u8)0x03U;
2753  05b6 c60017        	ld	a,L71_CtrlReg4+1
2754  05b9 aa03          	or	a,#3
2755                     ; 917       break;
2757  05bb 2021          	jp	LC003
2758  05bd               L1711:
2759                     ; 918     case  L99PM62DRV_RESET_THRESHOLD_4100:
2759                     ; 919       CtrlReg4[1] &= (u8)~0x03U;
2761  05bd c60017        	ld	a,L71_CtrlReg4+1
2762  05c0 a4fc          	and	a,#252
2763  05c2 c70017        	ld	L71_CtrlReg4+1,a
2764                     ; 920       CtrlReg4[1] |= 0x02U;
2766  05c5 72120017      	bset	L71_CtrlReg4+1,#1
2767                     ; 921       break;
2769  05c9 2016          	jra	L1421
2770  05cb               L3711:
2771                     ; 922     case  L99PM62DRV_RESET_THRESHOLD_4350:
2771                     ; 923       CtrlReg4[1] &= (u8)~0x03U;
2773  05cb c60017        	ld	a,L71_CtrlReg4+1
2774  05ce a4fc          	and	a,#252
2775  05d0 c70017        	ld	L71_CtrlReg4+1,a
2776                     ; 924       CtrlReg4[1] |= 0x01U;
2778  05d3 72100017      	bset	L71_CtrlReg4+1,#0
2779                     ; 925       break;
2781  05d7 2008          	jra	L1421
2782  05d9               L5711:
2783                     ; 926     case  L99PM62DRV_RESET_THRESHOLD_4600:
2783                     ; 927       CtrlReg4[1] &= (u8)~0x03U;
2785  05d9 c60017        	ld	a,L71_CtrlReg4+1
2786  05dc a4fc          	and	a,#252
2787  05de               LC003:
2788  05de c70017        	ld	L71_CtrlReg4+1,a
2789                     ; 928       break;
2791  05e1               L1421:
2792                     ; 935   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
2792                     ; 936                         CtrlReg4,
2792                     ; 937                         &GlobalStatusRegister,
2792                     ; 938                         CtrlReg4_old);
2794  05e1 ae0014        	ldw	x,#L12_CtrlReg4_old
2795  05e4 89            	pushw	x
2796  05e5 ae0001        	ldw	x,#L54_GlobalStatusRegister
2797  05e8 89            	pushw	x
2798  05e9 ae0016        	ldw	x,#L71_CtrlReg4
2799  05ec 89            	pushw	x
2800  05ed a604          	ld	a,#4
2801  05ef cd0e70        	call	_ST_SPI_Send_16
2803  05f2 5b06          	addw	sp,#6
2804                     ; 939 }
2807  05f4 84            	pop	a
2808  05f5 81            	ret	
2902                     ; 965 void L99PM62drv_SetInputFilterMode (u8 mask, L99PM62drv_InputFilterModeType mode)
2902                     ; 966 {
2903                     	switch	.text
2904  05f6               _L99PM62drv_SetInputFilterMode:
2906  05f6 89            	pushw	x
2907  05f7 88            	push	a
2908       00000001      OFST:	set	1
2911                     ; 971   if (!InitFlag)
2913  05f8 c60000        	ld	a,L74_InitFlag
2914  05fb 2609          	jrne	L1031
2915                     ; 973     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetInputFilterMode, L99PM62DRV_EID_UNINIT))
2917  05fd ae1014        	ldw	x,#4116
2918  0600 cd0000        	call	_L99PM62drv_ReportError
2920  0603 4d            	tnz	a
2921  0604 270f          	jreq	L632
2922                     ; 975       return;
2924  0606               L1031:
2925                     ; 978   if (mask & (u8)~0x0FU)
2927  0606 7b02          	ld	a,(OFST+1,sp)
2928  0608 a5f0          	bcp	a,#240
2929  060a 270c          	jreq	L5031
2930                     ; 980     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetInputFilterMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
2932  060c ae100b        	ldw	x,#4107
2933  060f cd0000        	call	_L99PM62drv_ReportError
2935  0612 4d            	tnz	a
2936  0613 2603          	jrne	L5031
2937                     ; 982       return;
2938  0615               L632:
2941  0615 5b03          	addw	sp,#3
2942  0617 81            	ret	
2943  0618               L5031:
2944                     ; 985   tmp = (s8)mode;
2946  0618 7b03          	ld	a,(OFST+2,sp)
2947  061a 6b01          	ld	(OFST+0,sp),a
2948                     ; 986   if ((tmp < (s8)L99PM62DRV_IN_FILTER_64) || (tmp > (s8)L99PM62DRV_IN_FILTER_800_TIMER1))
2950  061c 2b04          	jrmi	L3131
2952  061e a104          	cp	a,#4
2953  0620 2f09          	jrslt	L1131
2954  0622               L3131:
2955                     ; 988     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetInputFilterMode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
2957  0622 ae100c        	ldw	x,#4108
2958  0625 cd0000        	call	_L99PM62drv_ReportError
2960  0628 4d            	tnz	a
2961  0629 27ea          	jreq	L632
2962                     ; 990       return;
2964  062b               L1131:
2965                     ; 995   if (mask & L99PM62DRV_MASK_WU1)
2967  062b 7b02          	ld	a,(OFST+1,sp)
2968  062d a501          	bcp	a,#1
2969  062f 2714          	jreq	L7131
2970                     ; 997     CtrlReg2[1] &= (u8)~0x03U;
2972  0631 c6001f        	ld	a,L7_CtrlReg2+1
2973  0634 a4fc          	and	a,#252
2974  0636 c7001f        	ld	L7_CtrlReg2+1,a
2975                     ; 998     CtrlReg2[1] |= (u8)((u8)mode) & 0x03U;
2977  0639 7b03          	ld	a,(OFST+2,sp)
2978  063b a403          	and	a,#3
2979  063d ca001f        	or	a,L7_CtrlReg2+1
2980  0640 c7001f        	ld	L7_CtrlReg2+1,a
2981  0643 7b02          	ld	a,(OFST+1,sp)
2982  0645               L7131:
2983                     ; 1000   if (mask & L99PM62DRV_MASK_WU2)
2985  0645 a502          	bcp	a,#2
2986  0647 2716          	jreq	L1231
2987                     ; 1002     CtrlReg2[1] &= (u8)~0x0CU;
2989  0649 c6001f        	ld	a,L7_CtrlReg2+1
2990  064c a4f3          	and	a,#243
2991  064e c7001f        	ld	L7_CtrlReg2+1,a
2992                     ; 1003     CtrlReg2[1] |= (u8)((u8)mode << 2) & 0x0CU;
2994  0651 7b03          	ld	a,(OFST+2,sp)
2995  0653 48            	sll	a
2996  0654 48            	sll	a
2997  0655 a40c          	and	a,#12
2998  0657 ca001f        	or	a,L7_CtrlReg2+1
2999  065a c7001f        	ld	L7_CtrlReg2+1,a
3000  065d 7b02          	ld	a,(OFST+1,sp)
3001  065f               L1231:
3002                     ; 1005   if (mask & L99PM62DRV_MASK_WU3)
3004  065f a504          	bcp	a,#4
3005  0661 2717          	jreq	L3231
3006                     ; 1007     CtrlReg2[1] &= (u8)~0x30U;
3008  0663 c6001f        	ld	a,L7_CtrlReg2+1
3009  0666 a4cf          	and	a,#207
3010  0668 c7001f        	ld	L7_CtrlReg2+1,a
3011                     ; 1008     CtrlReg2[1] |= (u8)((u8)mode << 4) & 0x30U;
3013  066b 7b03          	ld	a,(OFST+2,sp)
3014  066d 97            	ld	xl,a
3015  066e a610          	ld	a,#16
3016  0670 42            	mul	x,a
3017  0671 9f            	ld	a,xl
3018  0672 a430          	and	a,#48
3019  0674 ca001f        	or	a,L7_CtrlReg2+1
3020  0677 c7001f        	ld	L7_CtrlReg2+1,a
3021  067a               L3231:
3022                     ; 1011   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR2,
3022                     ; 1012                         CtrlReg2,
3022                     ; 1013                         &GlobalStatusRegister,
3022                     ; 1014                         CtrlReg2_old);
3024  067a ae001c        	ldw	x,#L11_CtrlReg2_old
3025  067d 89            	pushw	x
3026  067e ae0001        	ldw	x,#L54_GlobalStatusRegister
3027  0681 89            	pushw	x
3028  0682 ae001e        	ldw	x,#L7_CtrlReg2
3029  0685 89            	pushw	x
3030  0686 a602          	ld	a,#2
3031  0688 cd0e70        	call	_ST_SPI_Send_16
3033  068b 5b06          	addw	sp,#6
3034                     ; 1015 }
3036  068d 2086          	jra	L632
3088                     ; 1031 void L99PM62drv_LinSetup (L99PM62drv_EnableType pullUpMode, L99PM62drv_EnableType TxDToutMode)
3088                     ; 1032 {
3089                     	switch	.text
3090  068f               _L99PM62drv_LinSetup:
3092  068f 89            	pushw	x
3093       00000000      OFST:	set	0
3096                     ; 1035   if (!InitFlag)
3098  0690 c60000        	ld	a,L74_InitFlag
3099  0693 2609          	jrne	L7431
3100                     ; 1037     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_LinSetup, L99PM62DRV_EID_UNINIT))
3102  0695 ae1114        	ldw	x,#4372
3103  0698 cd0000        	call	_L99PM62drv_ReportError
3105  069b 4d            	tnz	a
3106  069c 2710          	jreq	L252
3107                     ; 1039       return;
3109  069e               L7431:
3110                     ; 1042   if (pullUpMode != L99PM62DRV_DISABLE && pullUpMode != L99PM62DRV_ENABLE )
3112  069e 7b01          	ld	a,(OFST+1,sp)
3113  06a0 270e          	jreq	L3531
3115  06a2 4a            	dec	a
3116  06a3 270b          	jreq	L3531
3117                     ; 1044     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_LinSetup, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
3119  06a5 ae110b        	ldw	x,#4363
3120  06a8 cd0000        	call	_L99PM62drv_ReportError
3122  06ab 4d            	tnz	a
3123  06ac 2602          	jrne	L3531
3124                     ; 1046       return;
3125  06ae               L252:
3128  06ae 85            	popw	x
3129  06af 81            	ret	
3130  06b0               L3531:
3131                     ; 1049   if (TxDToutMode != L99PM62DRV_DISABLE && TxDToutMode != L99PM62DRV_ENABLE )
3133  06b0 7b02          	ld	a,(OFST+2,sp)
3134  06b2 270c          	jreq	L7531
3136  06b4 4a            	dec	a
3137  06b5 2709          	jreq	L7531
3138                     ; 1051     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_LinSetup, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
3140  06b7 ae110c        	ldw	x,#4364
3141  06ba cd0000        	call	_L99PM62drv_ReportError
3143  06bd 4d            	tnz	a
3144  06be 27ee          	jreq	L252
3145                     ; 1053       return;
3147  06c0               L7531:
3148                     ; 1058   if (pullUpMode == L99PM62DRV_DISABLE)
3150  06c0 7b01          	ld	a,(OFST+1,sp)
3151  06c2 2606          	jrne	L3631
3152                     ; 1060     CtrlReg4[0] &= (u8)~0x80U;
3154  06c4 721f0016      	bres	L71_CtrlReg4,#7
3156  06c8 2007          	jra	L5631
3157  06ca               L3631:
3158                     ; 1062   else if (pullUpMode == L99PM62DRV_ENABLE)
3160  06ca 4a            	dec	a
3161  06cb 2604          	jrne	L5631
3162                     ; 1064     CtrlReg4[0] |= 0x80U;
3164  06cd 721e0016      	bset	L71_CtrlReg4,#7
3165  06d1               L5631:
3166                     ; 1067   if (TxDToutMode == L99PM62DRV_DISABLE)
3168  06d1 7b02          	ld	a,(OFST+2,sp)
3169  06d3 2606          	jrne	L1731
3170                     ; 1069     CtrlReg4[0] &= (u8)~0x20U;
3172  06d5 721b0016      	bres	L71_CtrlReg4,#5
3174  06d9 2007          	jra	L3731
3175  06db               L1731:
3176                     ; 1071   else if (TxDToutMode == L99PM62DRV_ENABLE)
3178  06db 4a            	dec	a
3179  06dc 2604          	jrne	L3731
3180                     ; 1073     CtrlReg4[0] |= 0x20U;
3182  06de 721a0016      	bset	L71_CtrlReg4,#5
3183  06e2               L3731:
3184                     ; 1076   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
3184                     ; 1077                         CtrlReg4,
3184                     ; 1078                         &GlobalStatusRegister,
3184                     ; 1079                         CtrlReg4_old);
3186  06e2 ae0014        	ldw	x,#L12_CtrlReg4_old
3187  06e5 89            	pushw	x
3188  06e6 ae0001        	ldw	x,#L54_GlobalStatusRegister
3189  06e9 89            	pushw	x
3190  06ea ae0016        	ldw	x,#L71_CtrlReg4
3191  06ed 89            	pushw	x
3192  06ee a604          	ld	a,#4
3193  06f0 cd0e70        	call	_ST_SPI_Send_16
3195  06f3 5b06          	addw	sp,#6
3196                     ; 1080 }
3198  06f5 20b7          	jra	L252
3240                     ; 1094 void L99PM62drv_SetVsLockoutMode (L99PM62drv_EnableType VsLockoutMode)
3240                     ; 1095 {
3241                     	switch	.text
3242  06f7               _L99PM62drv_SetVsLockoutMode:
3244  06f7 88            	push	a
3245       00000000      OFST:	set	0
3248                     ; 1098   if (!InitFlag)
3250  06f8 c60000        	ld	a,L74_InitFlag
3251  06fb 260b          	jrne	L3241
3252                     ; 1100     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetVsLockoutMode, L99PM62DRV_EID_UNINIT))
3254  06fd ae1214        	ldw	x,#4628
3255  0700 cd0000        	call	_L99PM62drv_ReportError
3257  0703 4d            	tnz	a
3258  0704 2602          	jrne	L3241
3259                     ; 1102       return;
3262  0706 84            	pop	a
3263  0707 81            	ret	
3264  0708               L3241:
3265                     ; 1106   switch (VsLockoutMode)
3267  0708 7b01          	ld	a,(OFST+1,sp)
3269                     ; 1118       return;
3270  070a 270b          	jreq	L7731
3271  070c 4a            	dec	a
3272  070d 270e          	jreq	L1041
3273                     ; 1114     default:
3273                     ; 1115 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
3273                     ; 1116       L99PM62drv_ReportError (SID_L99PM62drv_SetVsLockoutMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
3275  070f ae120b        	ldw	x,#4619
3276  0712 cd0000        	call	_L99PM62drv_ReportError
3278                     ; 1118       return;
3281  0715 84            	pop	a
3282  0716 81            	ret	
3283  0717               L7731:
3284                     ; 1108     case L99PM62DRV_DISABLE:
3284                     ; 1109       CtrlReg4[1] &= (u8)~0x10U;
3286  0717 72190017      	bres	L71_CtrlReg4+1,#4
3287                     ; 1110       break;
3289  071b 2004          	jra	L1341
3290  071d               L1041:
3291                     ; 1111     case L99PM62DRV_ENABLE:
3291                     ; 1112       CtrlReg4[1] |= 0x10U;
3293  071d 72180017      	bset	L71_CtrlReg4+1,#4
3294                     ; 1113       break;
3296  0721               L1341:
3297                     ; 1120   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
3297                     ; 1121                         CtrlReg4,
3297                     ; 1122                         &GlobalStatusRegister,
3297                     ; 1123                         CtrlReg4_old);
3299  0721 ae0014        	ldw	x,#L12_CtrlReg4_old
3300  0724 89            	pushw	x
3301  0725 ae0001        	ldw	x,#L54_GlobalStatusRegister
3302  0728 89            	pushw	x
3303  0729 ae0016        	ldw	x,#L71_CtrlReg4
3304  072c 89            	pushw	x
3305  072d a604          	ld	a,#4
3306  072f cd0e70        	call	_ST_SPI_Send_16
3308  0732 5b06          	addw	sp,#6
3309                     ; 1124 }
3312  0734 84            	pop	a
3313  0735 81            	ret	
3355                     ; 1140 void L99PM62drv_SetRelayShutdownMode (L99PM62drv_EnableType relayShutdownMode)
3355                     ; 1141 {
3356                     	switch	.text
3357  0736               _L99PM62drv_SetRelayShutdownMode:
3359  0736 88            	push	a
3360       00000000      OFST:	set	0
3363                     ; 1144   if (!InitFlag)
3365  0737 c60000        	ld	a,L74_InitFlag
3366  073a 260b          	jrne	L7541
3367                     ; 1146     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetRelayShutdownMode, L99PM62DRV_EID_UNINIT))
3369  073c ae1314        	ldw	x,#4884
3370  073f cd0000        	call	_L99PM62drv_ReportError
3372  0742 4d            	tnz	a
3373  0743 2602          	jrne	L7541
3374                     ; 1148       return;
3377  0745 84            	pop	a
3378  0746 81            	ret	
3379  0747               L7541:
3380                     ; 1153   switch (relayShutdownMode)
3382  0747 7b01          	ld	a,(OFST+1,sp)
3384                     ; 1165       return;
3385  0749 270b          	jreq	L3341
3386  074b 4a            	dec	a
3387  074c 270e          	jreq	L5341
3388                     ; 1161     default:
3388                     ; 1162 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
3388                     ; 1163       L99PM62drv_ReportError (SID_L99PM62drv_SetRelayShutdownMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
3390  074e ae130b        	ldw	x,#4875
3391  0751 cd0000        	call	_L99PM62drv_ReportError
3393                     ; 1165       return;
3396  0754 84            	pop	a
3397  0755 81            	ret	
3398  0756               L3341:
3399                     ; 1155     case L99PM62DRV_DISABLE:
3399                     ; 1156       CtrlReg4[1] &= (u8)~0x04U;
3401  0756 72150017      	bres	L71_CtrlReg4+1,#2
3402                     ; 1157       break;
3404  075a 2004          	jra	L5641
3405  075c               L5341:
3406                     ; 1158     case L99PM62DRV_ENABLE:
3406                     ; 1159       CtrlReg4[1] |= 0x04U;
3408  075c 72140017      	bset	L71_CtrlReg4+1,#2
3409                     ; 1160       break;
3411  0760               L5641:
3412                     ; 1167   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
3412                     ; 1168                         CtrlReg4,
3412                     ; 1169                         &GlobalStatusRegister,
3412                     ; 1170                         CtrlReg4_old);
3414  0760 ae0014        	ldw	x,#L12_CtrlReg4_old
3415  0763 89            	pushw	x
3416  0764 ae0001        	ldw	x,#L54_GlobalStatusRegister
3417  0767 89            	pushw	x
3418  0768 ae0016        	ldw	x,#L71_CtrlReg4
3419  076b 89            	pushw	x
3420  076c a604          	ld	a,#4
3421  076e cd0e70        	call	_ST_SPI_Send_16
3423  0771 5b06          	addw	sp,#6
3424                     ; 1171 }
3427  0773 84            	pop	a
3428  0774 81            	ret	
3471                     ; 1185 void L99PM62drv_SetVReg1CurrentMonitorMode (L99PM62drv_EnableType IcmpMode)
3471                     ; 1186 {
3472                     	switch	.text
3473  0775               _L99PM62drv_SetVReg1CurrentMonitorMode:
3475  0775 88            	push	a
3476       00000000      OFST:	set	0
3479                     ; 1189   if (!InitFlag)
3481  0776 c60000        	ld	a,L74_InitFlag
3482  0779 260b          	jrne	L3151
3483                     ; 1191     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetVReg1CurrentMonitorMode, L99PM62DRV_EID_UNINIT))
3485  077b ae1414        	ldw	x,#5140
3486  077e cd0000        	call	_L99PM62drv_ReportError
3488  0781 4d            	tnz	a
3489  0782 2602          	jrne	L3151
3490                     ; 1193       return;
3493  0784 84            	pop	a
3494  0785 81            	ret	
3495  0786               L3151:
3496                     ; 1198   switch (IcmpMode)
3498  0786 7b01          	ld	a,(OFST+1,sp)
3500                     ; 1210       return;
3501  0788 2711          	jreq	L1741
3502  078a 4a            	dec	a
3503  078b 2708          	jreq	L7641
3504                     ; 1206     default:
3504                     ; 1207 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
3504                     ; 1208       L99PM62drv_ReportError (SID_L99PM62drv_SetVReg1CurrentMonitorMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
3506  078d ae140b        	ldw	x,#5131
3507  0790 cd0000        	call	_L99PM62drv_ReportError
3509                     ; 1210       return;
3512  0793 84            	pop	a
3513  0794 81            	ret	
3514  0795               L7641:
3515                     ; 1200     case L99PM62DRV_ENABLE:
3515                     ; 1201       CtrlReg4[1] &= (u8)~0x40U;
3517  0795 721d0017      	bres	L71_CtrlReg4+1,#6
3518                     ; 1202       break;
3520  0799 2004          	jra	L1251
3521  079b               L1741:
3522                     ; 1203     case L99PM62DRV_DISABLE:
3522                     ; 1204       CtrlReg4[1] |= 0x40U;
3524  079b 721c0017      	bset	L71_CtrlReg4+1,#6
3525                     ; 1205       break;
3527  079f               L1251:
3528                     ; 1212   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
3528                     ; 1213                         CtrlReg4,
3528                     ; 1214                         &GlobalStatusRegister,
3528                     ; 1215                         CtrlReg4_old);
3530  079f ae0014        	ldw	x,#L12_CtrlReg4_old
3531  07a2 89            	pushw	x
3532  07a3 ae0001        	ldw	x,#L54_GlobalStatusRegister
3533  07a6 89            	pushw	x
3534  07a7 ae0016        	ldw	x,#L71_CtrlReg4
3535  07aa 89            	pushw	x
3536  07ab a604          	ld	a,#4
3537  07ad cd0e70        	call	_ST_SPI_Send_16
3539  07b0 5b06          	addw	sp,#6
3540                     ; 1216 }
3543  07b2 84            	pop	a
3544  07b3 81            	ret	
3608                     ; 1229 void L99PM62drv_SetPWMFrequ (L99PM62drv_PWMFrequType value )
3608                     ; 1230 {
3609                     	switch	.text
3610  07b4               _L99PM62drv_SetPWMFrequ:
3612  07b4 88            	push	a
3613       00000000      OFST:	set	0
3616                     ; 1233   if (!InitFlag)
3618  07b5 c60000        	ld	a,L74_InitFlag
3619  07b8 260b          	jrne	L7551
3620                     ; 1235     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetPWMFrequ, L99PM62DRV_EID_UNINIT))
3622  07ba ae1514        	ldw	x,#5396
3623  07bd cd0000        	call	_L99PM62drv_ReportError
3625  07c0 4d            	tnz	a
3626  07c1 2602          	jrne	L7551
3627                     ; 1237       return;
3630  07c3 84            	pop	a
3631  07c4 81            	ret	
3632  07c5               L7551:
3633                     ; 1241   switch (value)
3635  07c5 7b01          	ld	a,(OFST+1,sp)
3637                     ; 1253       return;
3638  07c7 270b          	jreq	L3251
3639  07c9 4a            	dec	a
3640  07ca 270e          	jreq	L5251
3641                     ; 1249     default:
3641                     ; 1250 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
3641                     ; 1251       L99PM62drv_ReportError (SID_L99PM62drv_SetPWMFrequ, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
3643  07cc ae150b        	ldw	x,#5387
3644  07cf cd0000        	call	_L99PM62drv_ReportError
3646                     ; 1253       return;
3649  07d2 84            	pop	a
3650  07d3 81            	ret	
3651  07d4               L3251:
3652                     ; 1243     case L99PM62DRV_PWMFREQU_100HZ:
3652                     ; 1244       CtrlReg5[0] &= (u8)~0x80U;
3654  07d4 721f0012      	bres	L32_CtrlReg5,#7
3655                     ; 1245       break;
3657  07d8 2004          	jra	L5651
3658  07da               L5251:
3659                     ; 1246     case L99PM62DRV_PWMFREQU_200HZ:
3659                     ; 1247       CtrlReg5[0] |= 0x80U;
3661  07da 721e0012      	bset	L32_CtrlReg5,#7
3662                     ; 1248       break;
3664  07de               L5651:
3665                     ; 1255   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR5,
3665                     ; 1256                         CtrlReg5,
3665                     ; 1257                         &GlobalStatusRegister,
3665                     ; 1258                         CtrlReg5_old);
3667  07de ae0010        	ldw	x,#L52_CtrlReg5_old
3668  07e1 89            	pushw	x
3669  07e2 ae0001        	ldw	x,#L54_GlobalStatusRegister
3670  07e5 89            	pushw	x
3671  07e6 ae0012        	ldw	x,#L32_CtrlReg5
3672  07e9 89            	pushw	x
3673  07ea a605          	ld	a,#5
3674  07ec cd0e70        	call	_ST_SPI_Send_16
3676  07ef 5b06          	addw	sp,#6
3677                     ; 1259 }
3680  07f1 84            	pop	a
3681  07f2 81            	ret	
3749                     ; 1293 void L99PM62drv_SetPWMDutyCycle (u8 mask, u8 dutyCycle)
3749                     ; 1294 {
3750                     	switch	.text
3751  07f3               _L99PM62drv_SetPWMDutyCycle:
3753  07f3 89            	pushw	x
3754  07f4 89            	pushw	x
3755       00000002      OFST:	set	2
3758                     ; 1298   if (!InitFlag)
3760  07f5 c60000        	ld	a,L74_InitFlag
3761  07f8 2609          	jrne	L5161
3762                     ; 1300     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetPWMDutyCycle, L99PM62DRV_EID_UNINIT))
3764  07fa ae1614        	ldw	x,#5652
3765  07fd cd0000        	call	_L99PM62drv_ReportError
3767  0800 4d            	tnz	a
3768  0801 270f          	jreq	L033
3769                     ; 1302       return;
3771  0803               L5161:
3772                     ; 1305   if (mask & (u8)~0x0FU)
3774  0803 7b03          	ld	a,(OFST+1,sp)
3775  0805 a5f0          	bcp	a,#240
3776  0807 270c          	jreq	L1261
3777                     ; 1307     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetPWMDutyCycle, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
3779  0809 ae160b        	ldw	x,#5643
3780  080c cd0000        	call	_L99PM62drv_ReportError
3782  080f 4d            	tnz	a
3783  0810 2603          	jrne	L1261
3784                     ; 1309       return;
3785  0812               L033:
3788  0812 5b04          	addw	sp,#4
3789  0814 81            	ret	
3790  0815               L1261:
3791                     ; 1312   if (dutyCycle & (u8)0x80)
3793  0815 7b04          	ld	a,(OFST+2,sp)
3794  0817 2a09          	jrpl	L5261
3795                     ; 1314     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetPWMDutyCycle, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
3797  0819 ae160c        	ldw	x,#5644
3798  081c cd0000        	call	_L99PM62drv_ReportError
3800  081f 4d            	tnz	a
3801  0820 27f0          	jreq	L033
3802                     ; 1316       return;
3804  0822               L5261:
3805                     ; 1320   send5 = FALSE;
3807  0822 0f01          	clr	(OFST-1,sp)
3808                     ; 1321   send6 = FALSE;
3810  0824 0f02          	clr	(OFST+0,sp)
3811                     ; 1322   if (mask & L99PM62DRV_MASK_PWM1)
3813  0826 7b03          	ld	a,(OFST+1,sp)
3814  0828 a501          	bcp	a,#1
3815  082a 2718          	jreq	L1361
3816                     ; 1324     CtrlReg5[0] &= 0x80U;
3818  082c c60012        	ld	a,L32_CtrlReg5
3819  082f a480          	and	a,#128
3820  0831 c70012        	ld	L32_CtrlReg5,a
3821                     ; 1325     CtrlReg5[0] |= dutyCycle & 0x7FU;
3823  0834 7b04          	ld	a,(OFST+2,sp)
3824  0836 a47f          	and	a,#127
3825  0838 ca0012        	or	a,L32_CtrlReg5
3826  083b c70012        	ld	L32_CtrlReg5,a
3827                     ; 1326     send5 = TRUE;
3829  083e a601          	ld	a,#1
3830  0840 6b01          	ld	(OFST-1,sp),a
3831  0842 7b03          	ld	a,(OFST+1,sp)
3832  0844               L1361:
3833                     ; 1328   if (mask & L99PM62DRV_MASK_PWM2)
3835  0844 a502          	bcp	a,#2
3836  0846 270e          	jreq	L3361
3837                     ; 1330     CtrlReg5[1] = ((u8)~dutyCycle) & 0x7FU;
3839  0848 7b04          	ld	a,(OFST+2,sp)
3840  084a 43            	cpl	a
3841  084b a47f          	and	a,#127
3842  084d c70013        	ld	L32_CtrlReg5+1,a
3843                     ; 1331     send5 = TRUE;
3845  0850 a601          	ld	a,#1
3846  0852 6b01          	ld	(OFST-1,sp),a
3847  0854 7b03          	ld	a,(OFST+1,sp)
3848  0856               L3361:
3849                     ; 1333   if (mask & L99PM62DRV_MASK_PWM3)
3851  0856 a504          	bcp	a,#4
3852  0858 270d          	jreq	L5361
3853                     ; 1335     CtrlReg6[0] = dutyCycle & 0x7fU;
3855  085a 7b04          	ld	a,(OFST+2,sp)
3856  085c a47f          	and	a,#127
3857  085e c7000e        	ld	L72_CtrlReg6,a
3858                     ; 1336     send6 = TRUE;
3860  0861 a601          	ld	a,#1
3861  0863 6b02          	ld	(OFST+0,sp),a
3862  0865 7b03          	ld	a,(OFST+1,sp)
3863  0867               L5361:
3864                     ; 1338   if (mask & L99PM62DRV_MASK_PWM4)
3866  0867 a508          	bcp	a,#8
3867  0869 270c          	jreq	L7361
3868                     ; 1340     CtrlReg6[1] = ((u8)~dutyCycle) & 0x7FU;
3870  086b 7b04          	ld	a,(OFST+2,sp)
3871  086d 43            	cpl	a
3872  086e a47f          	and	a,#127
3873  0870 c7000f        	ld	L72_CtrlReg6+1,a
3874                     ; 1341     send6 = TRUE;
3876  0873 a601          	ld	a,#1
3877  0875 6b02          	ld	(OFST+0,sp),a
3878  0877               L7361:
3879                     ; 1343   if (send5)
3881  0877 7b01          	ld	a,(OFST-1,sp)
3882  0879 2713          	jreq	L1461
3883                     ; 1345     L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR5,
3883                     ; 1346                           CtrlReg5,
3883                     ; 1347                           &GlobalStatusRegister,
3883                     ; 1348                           CtrlReg5_old);
3885  087b ae0010        	ldw	x,#L52_CtrlReg5_old
3886  087e 89            	pushw	x
3887  087f ae0001        	ldw	x,#L54_GlobalStatusRegister
3888  0882 89            	pushw	x
3889  0883 ae0012        	ldw	x,#L32_CtrlReg5
3890  0886 89            	pushw	x
3891  0887 a605          	ld	a,#5
3892  0889 cd0e70        	call	_ST_SPI_Send_16
3894  088c 5b06          	addw	sp,#6
3895  088e               L1461:
3896                     ; 1350   if (send6)
3898  088e 7b02          	ld	a,(OFST+0,sp)
3899  0890 2780          	jreq	L033
3900                     ; 1352     L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR6,
3900                     ; 1353                           CtrlReg6,
3900                     ; 1354                           &GlobalStatusRegister,
3900                     ; 1355                           CtrlReg6_old);
3902  0892 ae000c        	ldw	x,#L13_CtrlReg6_old
3903  0895 89            	pushw	x
3904  0896 ae0001        	ldw	x,#L54_GlobalStatusRegister
3905  0899 89            	pushw	x
3906  089a ae000e        	ldw	x,#L72_CtrlReg6
3907  089d 89            	pushw	x
3908  089e a606          	ld	a,#6
3909  08a0 cd0e70        	call	_ST_SPI_Send_16
3911  08a3 5b06          	addw	sp,#6
3912                     ; 1357 }
3914  08a5 cc0812        	jra	L033
4007                     ; 1371 void L99PM62drv_SetWDTiming (L99PM62drv_WDTimingType value, L99PM62drv_WDTimingType* oldValue  )
4007                     ; 1372 {
4008                     	switch	.text
4009  08a8               _L99PM62drv_SetWDTiming:
4011  08a8 88            	push	a
4012       00000000      OFST:	set	0
4015                     ; 1375   if (!InitFlag)
4017  08a9 c60000        	ld	a,L74_InitFlag
4018  08ac 260b          	jrne	L7271
4019                     ; 1377     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetWDTiming, L99PM62DRV_EID_UNINIT))
4021  08ae ae1714        	ldw	x,#5908
4022  08b1 cd0000        	call	_L99PM62drv_ReportError
4024  08b4 4d            	tnz	a
4025  08b5 2602          	jrne	L7271
4026                     ; 1379       return;
4029  08b7 84            	pop	a
4030  08b8 81            	ret	
4031  08b9               L7271:
4032                     ; 1384   switch (value)
4034  08b9 7b01          	ld	a,(OFST+1,sp)
4036                     ; 1404       return;
4037  08bb 2711          	jreq	L5461
4038  08bd 4a            	dec	a
4039  08be 2715          	jreq	L7461
4040  08c0 4a            	dec	a
4041  08c1 271c          	jreq	L1561
4042  08c3 4a            	dec	a
4043  08c4 2723          	jreq	L3561
4044                     ; 1400     default:
4044                     ; 1401 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
4044                     ; 1402       L99PM62drv_ReportError (SID_L99PM62drv_SetWDTiming, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
4046  08c6 ae170b        	ldw	x,#5899
4047  08c9 cd0000        	call	_L99PM62drv_ReportError
4049                     ; 1404       return;
4052  08cc 84            	pop	a
4053  08cd 81            	ret	
4054  08ce               L5461:
4055                     ; 1386     case L99PM62DRV_WDC_TRIG_10:
4055                     ; 1387       CtrlReg3[0] &= (u8)~0x30U;
4057  08ce c6001a        	ld	a,L31_CtrlReg3
4058  08d1 a4cf          	and	a,#207
4059                     ; 1388       break;
4061  08d3 2019          	jp	LC004
4062  08d5               L7461:
4063                     ; 1389     case L99PM62DRV_WDC_TRIG_50:
4063                     ; 1390       CtrlReg3[0] &= (u8)~0x20U;
4065  08d5 721b001a      	bres	L31_CtrlReg3,#5
4066                     ; 1391       CtrlReg3[0] |= 0x10U;
4068  08d9 7218001a      	bset	L31_CtrlReg3,#4
4069                     ; 1392       break;
4071  08dd 2012          	jra	L5371
4072  08df               L1561:
4073                     ; 1393     case L99PM62DRV_WDC_TRIG_100:
4073                     ; 1394       CtrlReg3[0] &= (u8)~0x10U;
4075  08df 7219001a      	bres	L31_CtrlReg3,#4
4076                     ; 1395       CtrlReg3[0] |= 0x20U;
4078  08e3 721a001a      	bset	L31_CtrlReg3,#5
4079                     ; 1396       break;
4081  08e7 2008          	jra	L5371
4082  08e9               L3561:
4083                     ; 1397     case L99PM62DRV_WDC_TRIG_200:
4083                     ; 1398       CtrlReg3[0] |= 0x30U;
4085  08e9 c6001a        	ld	a,L31_CtrlReg3
4086  08ec aa30          	or	a,#48
4087  08ee               LC004:
4088  08ee c7001a        	ld	L31_CtrlReg3,a
4089                     ; 1399       break;
4091  08f1               L5371:
4092                     ; 1406   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
4092                     ; 1407                         CtrlReg3,
4092                     ; 1408                         &GlobalStatusRegister,
4092                     ; 1409                         CtrlReg3_old);
4094  08f1 ae0018        	ldw	x,#L51_CtrlReg3_old
4095  08f4 89            	pushw	x
4096  08f5 ae0001        	ldw	x,#L54_GlobalStatusRegister
4097  08f8 89            	pushw	x
4098  08f9 ae001a        	ldw	x,#L31_CtrlReg3
4099  08fc 89            	pushw	x
4100  08fd a603          	ld	a,#3
4101  08ff cd0e70        	call	_ST_SPI_Send_16
4103  0902 5b06          	addw	sp,#6
4104                     ; 1410   trap();
4107  0904 83            	trap	
4109                     ; 1411   switch ((u8)CtrlReg3_old[0] & 0x30U)
4112  0905 c60018        	ld	a,L51_CtrlReg3_old
4113  0908 a430          	and	a,#48
4115                     ; 1424       break;
4116  090a 270e          	jreq	L7561
4117  090c a010          	sub	a,#16
4118  090e 270e          	jreq	L1661
4119  0910 a010          	sub	a,#16
4120  0912 270f          	jreq	L3661
4121  0914 a010          	sub	a,#16
4122  0916 2711          	jreq	L5661
4123  0918 2014          	jra	L1471
4124  091a               L7561:
4125                     ; 1413     case 0x00U:
4125                     ; 1414       *oldValue = L99PM62DRV_WDC_TRIG_10;
4127  091a 1e04          	ldw	x,(OFST+4,sp)
4128                     ; 1415       break;
4130  091c 200f          	jp	LC005
4131  091e               L1661:
4132                     ; 1416     case 0x10U:
4132                     ; 1417       *oldValue = L99PM62DRV_WDC_TRIG_50;
4134  091e 1e04          	ldw	x,(OFST+4,sp)
4135  0920 4c            	inc	a
4136                     ; 1418       break;
4138  0921 200a          	jp	LC005
4139  0923               L3661:
4140                     ; 1419     case 0x20U:
4140                     ; 1420       *oldValue = L99PM62DRV_WDC_TRIG_100;
4142  0923 1e04          	ldw	x,(OFST+4,sp)
4143  0925 a602          	ld	a,#2
4144                     ; 1421       break;
4146  0927 2004          	jp	LC005
4147  0929               L5661:
4148                     ; 1422     case 0x30U:
4148                     ; 1423       *oldValue = L99PM62DRV_WDC_TRIG_200;
4150  0929 1e04          	ldw	x,(OFST+4,sp)
4151  092b a603          	ld	a,#3
4152  092d               LC005:
4153  092d f7            	ld	(x),a
4154                     ; 1424       break;
4156  092e               L1471:
4157                     ; 1426 }
4160  092e 84            	pop	a
4161  092f 81            	ret	
4235                     ; 1447 void L99PM62drv_SetCyclicWakeUp (L99PM62drv_EnableType cyclicWakeMode, L99PM62drv_CyclicWakeUpTimerType timer)
4235                     ; 1448 {
4236                     	switch	.text
4237  0930               _L99PM62drv_SetCyclicWakeUp:
4239  0930 89            	pushw	x
4240       00000000      OFST:	set	0
4243                     ; 1451   if (!InitFlag)
4245  0931 c60000        	ld	a,L74_InitFlag
4246  0934 2609          	jrne	L5771
4247                     ; 1453     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer1, L99PM62DRV_EID_UNINIT))
4249  0936 ae0b14        	ldw	x,#2836
4250  0939 cd0000        	call	_L99PM62drv_ReportError
4252  093c 4d            	tnz	a
4253  093d 2712          	jreq	L453
4254                     ; 1455       return;
4256  093f               L5771:
4257                     ; 1458   if ((cyclicWakeMode !=  L99PM62DRV_ENABLE) && (cyclicWakeMode !=  L99PM62DRV_DISABLE) )
4259  093f 7b01          	ld	a,(OFST+1,sp)
4260  0941 4a            	dec	a
4261  0942 270f          	jreq	L1002
4263  0944 7b01          	ld	a,(OFST+1,sp)
4264  0946 270b          	jreq	L1002
4265                     ; 1460     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetCyclicWakeUp, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
4267  0948 ae180b        	ldw	x,#6155
4268  094b cd0000        	call	_L99PM62drv_ReportError
4270  094e 4d            	tnz	a
4271  094f 2602          	jrne	L1002
4272                     ; 1462       return;
4273  0951               L453:
4276  0951 85            	popw	x
4277  0952 81            	ret	
4278  0953               L1002:
4279                     ; 1465   if ((timer != L99PM62DRV_CYCLIC_WAKEUP_TIMER1) && (timer != L99PM62DRV_CYCLIC_WAKEUP_TIMER2))
4281  0953 7b02          	ld	a,(OFST+2,sp)
4282  0955 4a            	dec	a
4283  0956 270d          	jreq	L5002
4285  0958 7b02          	ld	a,(OFST+2,sp)
4286  095a 2709          	jreq	L5002
4287                     ; 1467     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetCyclicWakeUp, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
4289  095c ae180c        	ldw	x,#6156
4290  095f cd0000        	call	_L99PM62drv_ReportError
4292  0962 4d            	tnz	a
4293  0963 27ec          	jreq	L453
4294                     ; 1469       return;
4296  0965               L5002:
4297                     ; 1475   if (cyclicWakeMode ==  L99PM62DRV_ENABLE)
4299  0965 7b01          	ld	a,(OFST+1,sp)
4300  0967 4a            	dec	a
4301  0968 2606          	jrne	L1102
4302                     ; 1477     CtrlReg3[0] |= 0x02U;
4304  096a 7212001a      	bset	L31_CtrlReg3,#1
4306  096e 2008          	jra	L3102
4307  0970               L1102:
4308                     ; 1479   else if (cyclicWakeMode == L99PM62DRV_DISABLE)
4310  0970 7b01          	ld	a,(OFST+1,sp)
4311  0972 26dd          	jrne	L453
4312                     ; 1481     CtrlReg3[0] &= (u8)~0x02U;
4314  0974 7213001a      	bres	L31_CtrlReg3,#1
4316  0978               L3102:
4317                     ; 1485   if (timer == L99PM62DRV_CYCLIC_WAKEUP_TIMER1)
4319  0978 7b02          	ld	a,(OFST+2,sp)
4320  097a 4a            	dec	a
4321  097b 2606          	jrne	L1202
4322                     ; 1487     CtrlReg3[0] |= 0x01U;
4324  097d 7210001a      	bset	L31_CtrlReg3,#0
4326  0981 2008          	jra	L3202
4327                     ; 1483   else return;
4329  0983               L1202:
4330                     ; 1489   else if (timer == L99PM62DRV_CYCLIC_WAKEUP_TIMER2)
4332  0983 7b02          	ld	a,(OFST+2,sp)
4333  0985 26ca          	jrne	L453
4334                     ; 1491     CtrlReg3[0] &= (u8)~0x01U;
4336  0987 7211001a      	bres	L31_CtrlReg3,#0
4338  098b               L3202:
4339                     ; 1495   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
4339                     ; 1496                         CtrlReg3,
4339                     ; 1497                         &GlobalStatusRegister,
4339                     ; 1498                         CtrlReg3_old);
4341  098b ae0018        	ldw	x,#L51_CtrlReg3_old
4342  098e 89            	pushw	x
4343  098f ae0001        	ldw	x,#L54_GlobalStatusRegister
4344  0992 89            	pushw	x
4345  0993 ae001a        	ldw	x,#L31_CtrlReg3
4346  0996 89            	pushw	x
4347  0997 a603          	ld	a,#3
4348  0999 cd0e70        	call	_ST_SPI_Send_16
4350  099c 5b06          	addw	sp,#6
4351                     ; 1499 }
4353  099e 20b1          	jra	L453
4354                     ; 1493   else return;
4407                     ; 1515 void L99PM62drv_EnableBusWakeUp (L99PM62drv_EnableType LINWakeUp, L99PM62drv_EnableType CANWakeUp)
4407                     ; 1516 {
4408                     	switch	.text
4409  09a0               _L99PM62drv_EnableBusWakeUp:
4411  09a0 89            	pushw	x
4412       00000000      OFST:	set	0
4415                     ; 1520   if (!InitFlag)
4417  09a1 c60000        	ld	a,L74_InitFlag
4418  09a4 2609          	jrne	L3502
4419                     ; 1522     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_EnableBusWakeUp, L99PM62DRV_EID_UNINIT))
4421  09a6 ae1914        	ldw	x,#6420
4422  09a9 cd0000        	call	_L99PM62drv_ReportError
4424  09ac 4d            	tnz	a
4425  09ad 2712          	jreq	L073
4426                     ; 1524       return;
4428  09af               L3502:
4429                     ; 1527   if ((LINWakeUp !=  L99PM62DRV_ENABLE) && (LINWakeUp !=  L99PM62DRV_DISABLE) )
4431  09af 7b01          	ld	a,(OFST+1,sp)
4432  09b1 4a            	dec	a
4433  09b2 270f          	jreq	L7502
4435  09b4 7b01          	ld	a,(OFST+1,sp)
4436  09b6 270b          	jreq	L7502
4437                     ; 1529     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_EnableBusWakeUp, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
4439  09b8 ae190b        	ldw	x,#6411
4440  09bb cd0000        	call	_L99PM62drv_ReportError
4442  09be 4d            	tnz	a
4443  09bf 2602          	jrne	L7502
4444                     ; 1531       return;
4445  09c1               L073:
4448  09c1 85            	popw	x
4449  09c2 81            	ret	
4450  09c3               L7502:
4451                     ; 1534   if ((CANWakeUp !=  L99PM62DRV_ENABLE) && (CANWakeUp !=  L99PM62DRV_DISABLE) )
4453  09c3 7b02          	ld	a,(OFST+2,sp)
4454  09c5 4a            	dec	a
4455  09c6 270d          	jreq	L3602
4457  09c8 7b02          	ld	a,(OFST+2,sp)
4458  09ca 2709          	jreq	L3602
4459                     ; 1536     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_EnableBusWakeUp, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
4461  09cc ae190c        	ldw	x,#6412
4462  09cf cd0000        	call	_L99PM62drv_ReportError
4464  09d2 4d            	tnz	a
4465  09d3 27ec          	jreq	L073
4466                     ; 1538       return;
4468  09d5               L3602:
4469                     ; 1545   if (LINWakeUp ==  L99PM62DRV_DISABLE)
4471  09d5 7b01          	ld	a,(OFST+1,sp)
4472  09d7 2606          	jrne	L7602
4473                     ; 1547     CtrlReg3[0] &= (u8)~0x08U;
4475  09d9 7217001a      	bres	L31_CtrlReg3,#3
4477  09dd 2004          	jra	L1702
4478  09df               L7602:
4479                     ; 1551     CtrlReg3[0] |= 0x08U;
4481  09df 7216001a      	bset	L31_CtrlReg3,#3
4482  09e3               L1702:
4483                     ; 1553   if (CANWakeUp ==  L99PM62DRV_DISABLE)
4485  09e3 7b02          	ld	a,(OFST+2,sp)
4486  09e5 2606          	jrne	L3702
4487                     ; 1555     CtrlReg3[0] &= (u8)~0x04U;
4489  09e7 7215001a      	bres	L31_CtrlReg3,#2
4491  09eb 2004          	jra	L5702
4492  09ed               L3702:
4493                     ; 1559     CtrlReg3[0] |= 0x04U;
4495  09ed 7214001a      	bset	L31_CtrlReg3,#2
4496  09f1               L5702:
4497                     ; 1561   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
4497                     ; 1562                         CtrlReg3,
4497                     ; 1563                         &GlobalStatusRegister,
4497                     ; 1564                         CtrlReg3_old);
4499  09f1 ae0018        	ldw	x,#L51_CtrlReg3_old
4500  09f4 89            	pushw	x
4501  09f5 ae0001        	ldw	x,#L54_GlobalStatusRegister
4502  09f8 89            	pushw	x
4503  09f9 ae001a        	ldw	x,#L31_CtrlReg3
4504  09fc 89            	pushw	x
4505  09fd a603          	ld	a,#3
4506  09ff cd0e70        	call	_ST_SPI_Send_16
4508  0a02 5b06          	addw	sp,#6
4509                     ; 1565 }
4511  0a04 20bb          	jra	L073
4553                     ; 1579 void L99PM62drv_SetCanStandbyMode (L99PM62drv_EnableType CanSleep)
4553                     ; 1580 {
4554                     	switch	.text
4555  0a06               _L99PM62drv_SetCanStandbyMode:
4557  0a06 88            	push	a
4558       00000000      OFST:	set	0
4561                     ; 1583   if (!InitFlag)
4563  0a07 c60000        	ld	a,L74_InitFlag
4564  0a0a 260b          	jrne	L5112
4565                     ; 1585     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetCanStandbyMode, L99PM62DRV_EID_UNINIT))
4567  0a0c ae2014        	ldw	x,#8212
4568  0a0f cd0000        	call	_L99PM62drv_ReportError
4570  0a12 4d            	tnz	a
4571  0a13 2602          	jrne	L5112
4572                     ; 1587       return;
4575  0a15 84            	pop	a
4576  0a16 81            	ret	
4577  0a17               L5112:
4578                     ; 1590   if ((CanSleep !=  L99PM62DRV_ENABLE) && (CanSleep !=  L99PM62DRV_DISABLE) )
4580  0a17 7b01          	ld	a,(OFST+1,sp)
4581  0a19 4a            	dec	a
4582  0a1a 270f          	jreq	L1212
4584  0a1c 7b01          	ld	a,(OFST+1,sp)
4585  0a1e 270b          	jreq	L1212
4586                     ; 1592     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetCanStandbyMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
4588  0a20 ae200b        	ldw	x,#8203
4589  0a23 cd0000        	call	_L99PM62drv_ReportError
4591  0a26 4d            	tnz	a
4592  0a27 2602          	jrne	L1212
4593                     ; 1594       return;
4596  0a29 84            	pop	a
4597  0a2a 81            	ret	
4598  0a2b               L1212:
4599                     ; 1601   if (CanSleep ==  L99PM62DRV_DISABLE)
4601  0a2b 7b01          	ld	a,(OFST+1,sp)
4602  0a2d 2606          	jrne	L5212
4603                     ; 1603     CtrlReg4[0] &= (u8)~0x10U;
4605  0a2f 72190016      	bres	L71_CtrlReg4,#4
4607  0a33 2004          	jra	L7212
4608  0a35               L5212:
4609                     ; 1607     CtrlReg4[0] |= 0x10U;
4611  0a35 72180016      	bset	L71_CtrlReg4,#4
4612  0a39               L7212:
4613                     ; 1610   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
4613                     ; 1611                         CtrlReg4,
4613                     ; 1612                         &GlobalStatusRegister,
4613                     ; 1613                         CtrlReg4_old);
4615  0a39 ae0014        	ldw	x,#L12_CtrlReg4_old
4616  0a3c 89            	pushw	x
4617  0a3d ae0001        	ldw	x,#L54_GlobalStatusRegister
4618  0a40 89            	pushw	x
4619  0a41 ae0016        	ldw	x,#L71_CtrlReg4
4620  0a44 89            	pushw	x
4621  0a45 a604          	ld	a,#4
4622  0a47 cd0e70        	call	_ST_SPI_Send_16
4624  0a4a 5b06          	addw	sp,#6
4625                     ; 1615 }
4628  0a4c 84            	pop	a
4629  0a4d 81            	ret	
4656                     ; 1631 u8 L99PM62drv_GetGlobalStatusRegister (void)
4656                     ; 1632 {
4657                     	switch	.text
4658  0a4e               _L99PM62drv_GetGlobalStatusRegister:
4662                     ; 1635   if (!InitFlag)
4664  0a4e c60000        	ld	a,L74_InitFlag
4665  0a51 260b          	jrne	L1412
4666                     ; 1637     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_GetGlobalStatusRegister, L99PM62DRV_EID_UNINIT))
4668  0a53 ae1a14        	ldw	x,#6676
4669  0a56 cd0000        	call	_L99PM62drv_ReportError
4671  0a59 4d            	tnz	a
4672  0a5a 2602          	jrne	L1412
4673                     ; 1639       return (TRUE);          /* return Global error to upper function */
4675  0a5c 4c            	inc	a
4678  0a5d 81            	ret	
4679  0a5e               L1412:
4680                     ; 1643   return (GlobalStatusRegister);
4682  0a5e c60001        	ld	a,L54_GlobalStatusRegister
4685  0a61 81            	ret	
4814                     ; 1659 void L99PM62drv_ReadStatus (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr)
4814                     ; 1660 {
4815                     	switch	.text
4816  0a62               _L99PM62drv_ReadStatus:
4818  0a62 88            	push	a
4819  0a63 89            	pushw	x
4820       00000002      OFST:	set	2
4823                     ; 1663   if (!InitFlag)
4825  0a64 c60000        	ld	a,L74_InitFlag
4826  0a67 2609          	jrne	L7222
4827                     ; 1665     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_ReadStatus, L99PM62DRV_EID_UNINIT))
4829  0a69 ae1b14        	ldw	x,#6932
4830  0a6c cd0000        	call	_L99PM62drv_ReportError
4832  0a6f 4d            	tnz	a
4833  0a70 2712          	jreq	L224
4834                     ; 1667       return;
4836  0a72               L7222:
4837                     ; 1672   switch (regID)
4839  0a72 7b03          	ld	a,(OFST+1,sp)
4841                     ; 1699       return;
4842  0a74 a011          	sub	a,#17
4843  0a76 270f          	jreq	L5412
4844  0a78 4a            	dec	a
4845  0a79 272b          	jreq	L7412
4846  0a7b 4a            	dec	a
4847  0a7c 2751          	jreq	L1512
4848                     ; 1695     default:
4848                     ; 1696 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
4848                     ; 1697       L99PM62drv_ReportError (SID_L99PM62drv_ReadStatus, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
4850  0a7e ae1b0c        	ldw	x,#6924
4851  0a81 cd0000        	call	_L99PM62drv_ReportError
4853                     ; 1699       return;
4854  0a84               L224:
4857  0a84 5b03          	addw	sp,#3
4858  0a86 81            	ret	
4859  0a87               L5412:
4860                     ; 1674     case L99PM62DRV_SR1:
4860                     ; 1675       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_SR1,
4860                     ; 1676                             StatReg1,
4860                     ; 1677                             &GlobalStatusRegister,
4860                     ; 1678                             StatReg1);
4862  0a87 ae000a        	ldw	x,#L33_StatReg1
4863  0a8a 89            	pushw	x
4864  0a8b ae0001        	ldw	x,#L54_GlobalStatusRegister
4865  0a8e 89            	pushw	x
4866  0a8f ae000a        	ldw	x,#L33_StatReg1
4867  0a92 89            	pushw	x
4868  0a93 a651          	ld	a,#81
4869  0a95 cd0e70        	call	_ST_SPI_Send_16
4871  0a98 5b06          	addw	sp,#6
4872                     ; 1679       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg1[1] << 8 ) + (L99PM62drv_RegType)StatReg1[0] ;
4874  0a9a c6000a        	ld	a,L33_StatReg1
4875  0a9d 5f            	clrw	x
4876  0a9e 97            	ld	xl,a
4877  0a9f 1f01          	ldw	(OFST-1,sp),x
4878  0aa1 c6000b        	ld	a,L33_StatReg1+1
4879                     ; 1680       break;
4881  0aa4 201d          	jp	LC006
4882  0aa6               L7412:
4883                     ; 1681     case L99PM62DRV_SR2:
4883                     ; 1682       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_SR2,
4883                     ; 1683                             StatReg2,
4883                     ; 1684                             &GlobalStatusRegister,
4883                     ; 1685                             StatReg2);
4885  0aa6 ae0008        	ldw	x,#L53_StatReg2
4886  0aa9 89            	pushw	x
4887  0aaa ae0001        	ldw	x,#L54_GlobalStatusRegister
4888  0aad 89            	pushw	x
4889  0aae ae0008        	ldw	x,#L53_StatReg2
4890  0ab1 89            	pushw	x
4891  0ab2 a652          	ld	a,#82
4892  0ab4 cd0e70        	call	_ST_SPI_Send_16
4894  0ab7 5b06          	addw	sp,#6
4895                     ; 1686       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg2[1] << 8) + (L99PM62drv_RegType)StatReg2[0] ;
4897  0ab9 c60008        	ld	a,L53_StatReg2
4898  0abc 5f            	clrw	x
4899  0abd 97            	ld	xl,a
4900  0abe 1f01          	ldw	(OFST-1,sp),x
4901  0ac0 c60009        	ld	a,L53_StatReg2+1
4902  0ac3               LC006:
4903  0ac3 97            	ld	xl,a
4904  0ac4 4f            	clr	a
4905  0ac5 02            	rlwa	x,a
4906  0ac6 1606          	ldw	y,(OFST+4,sp)
4907  0ac8 72fb01        	addw	x,(OFST-1,sp)
4908  0acb 90ff          	ldw	(y),x
4909                     ; 1687       break;
4911  0acd 20b5          	jra	L224
4912  0acf               L1512:
4913                     ; 1688     case L99PM62DRV_SR3:
4913                     ; 1689       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_SR3,
4913                     ; 1690                             StatReg3,
4913                     ; 1691                             &GlobalStatusRegister,
4913                     ; 1692                             StatReg3);
4915  0acf ae0006        	ldw	x,#L73_StatReg3
4916  0ad2 89            	pushw	x
4917  0ad3 ae0001        	ldw	x,#L54_GlobalStatusRegister
4918  0ad6 89            	pushw	x
4919  0ad7 ae0006        	ldw	x,#L73_StatReg3
4920  0ada 89            	pushw	x
4921  0adb a653          	ld	a,#83
4922  0add cd0e70        	call	_ST_SPI_Send_16
4924  0ae0 5b06          	addw	sp,#6
4925                     ; 1693       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg3[1] << 8) + (L99PM62drv_RegType)StatReg3[0] ;
4927  0ae2 c60006        	ld	a,L73_StatReg3
4928  0ae5 5f            	clrw	x
4929  0ae6 97            	ld	xl,a
4930  0ae7 1f01          	ldw	(OFST-1,sp),x
4931  0ae9 c60007        	ld	a,L73_StatReg3+1
4932                     ; 1694       break;
4934                     ; 1701 }
4936  0aec 20d5          	jp	LC006
4989                     ; 1717 void L99PM62drv_ReadClearStatus (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr)
4989                     ; 1718 {
4990                     	switch	.text
4991  0aee               _L99PM62drv_ReadClearStatus:
4993  0aee 88            	push	a
4994  0aef 89            	pushw	x
4995       00000002      OFST:	set	2
4998                     ; 1721   if (!InitFlag)
5000  0af0 c60000        	ld	a,L74_InitFlag
5001  0af3 2609          	jrne	L1722
5002                     ; 1723     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_ReadClearStatus, L99PM62DRV_EID_UNINIT))
5004  0af5 ae1c14        	ldw	x,#7188
5005  0af8 cd0000        	call	_L99PM62drv_ReportError
5007  0afb 4d            	tnz	a
5008  0afc 2712          	jreq	L044
5009                     ; 1725       return;
5011  0afe               L1722:
5012                     ; 1730   switch (regID)
5014  0afe 7b03          	ld	a,(OFST+1,sp)
5016                     ; 1757       return;
5017  0b00 a011          	sub	a,#17
5018  0b02 270f          	jreq	L7322
5019  0b04 4a            	dec	a
5020  0b05 272b          	jreq	L1422
5021  0b07 4a            	dec	a
5022  0b08 2751          	jreq	L3422
5023                     ; 1753     default:
5023                     ; 1754 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
5023                     ; 1755       L99PM62drv_ReportError (SID_L99PM62drv_ReadClearStatus, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
5025  0b0a ae1c0c        	ldw	x,#7180
5026  0b0d cd0000        	call	_L99PM62drv_ReportError
5028                     ; 1757       return;
5029  0b10               L044:
5032  0b10 5b03          	addw	sp,#3
5033  0b12 81            	ret	
5034  0b13               L7322:
5035                     ; 1732     case L99PM62DRV_SR1:
5035                     ; 1733       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ_CLEAR | L99PM62DRV_SR1,
5035                     ; 1734                             StatReg1,
5035                     ; 1735                             &GlobalStatusRegister,
5035                     ; 1736                             StatReg1);
5037  0b13 ae000a        	ldw	x,#L33_StatReg1
5038  0b16 89            	pushw	x
5039  0b17 ae0001        	ldw	x,#L54_GlobalStatusRegister
5040  0b1a 89            	pushw	x
5041  0b1b ae000a        	ldw	x,#L33_StatReg1
5042  0b1e 89            	pushw	x
5043  0b1f a691          	ld	a,#145
5044  0b21 cd0e70        	call	_ST_SPI_Send_16
5046  0b24 5b06          	addw	sp,#6
5047                     ; 1737       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg1[1] << 8) + (L99PM62drv_RegType)StatReg1[0] ;
5049  0b26 c6000a        	ld	a,L33_StatReg1
5050  0b29 5f            	clrw	x
5051  0b2a 97            	ld	xl,a
5052  0b2b 1f01          	ldw	(OFST-1,sp),x
5053  0b2d c6000b        	ld	a,L33_StatReg1+1
5054                     ; 1738       break;
5056  0b30 201d          	jp	LC007
5057  0b32               L1422:
5058                     ; 1739     case L99PM62DRV_SR2:
5058                     ; 1740       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ_CLEAR | L99PM62DRV_SR2,
5058                     ; 1741                             StatReg2,
5058                     ; 1742                             &GlobalStatusRegister,
5058                     ; 1743                             StatReg2);
5060  0b32 ae0008        	ldw	x,#L53_StatReg2
5061  0b35 89            	pushw	x
5062  0b36 ae0001        	ldw	x,#L54_GlobalStatusRegister
5063  0b39 89            	pushw	x
5064  0b3a ae0008        	ldw	x,#L53_StatReg2
5065  0b3d 89            	pushw	x
5066  0b3e a692          	ld	a,#146
5067  0b40 cd0e70        	call	_ST_SPI_Send_16
5069  0b43 5b06          	addw	sp,#6
5070                     ; 1744       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg2[1] << 8) + (L99PM62drv_RegType)StatReg2[0] ;
5072  0b45 c60008        	ld	a,L53_StatReg2
5073  0b48 5f            	clrw	x
5074  0b49 97            	ld	xl,a
5075  0b4a 1f01          	ldw	(OFST-1,sp),x
5076  0b4c c60009        	ld	a,L53_StatReg2+1
5077  0b4f               LC007:
5078  0b4f 97            	ld	xl,a
5079  0b50 4f            	clr	a
5080  0b51 02            	rlwa	x,a
5081  0b52 1606          	ldw	y,(OFST+4,sp)
5082  0b54 72fb01        	addw	x,(OFST-1,sp)
5083  0b57 90ff          	ldw	(y),x
5084                     ; 1745       break;
5086  0b59 20b5          	jra	L044
5087  0b5b               L3422:
5088                     ; 1746     case L99PM62DRV_SR3:
5088                     ; 1747       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ_CLEAR | L99PM62DRV_SR3,
5088                     ; 1748                             StatReg3,
5088                     ; 1749                             &GlobalStatusRegister,
5088                     ; 1750                             StatReg3);
5090  0b5b ae0006        	ldw	x,#L73_StatReg3
5091  0b5e 89            	pushw	x
5092  0b5f ae0001        	ldw	x,#L54_GlobalStatusRegister
5093  0b62 89            	pushw	x
5094  0b63 ae0006        	ldw	x,#L73_StatReg3
5095  0b66 89            	pushw	x
5096  0b67 a693          	ld	a,#147
5097  0b69 cd0e70        	call	_ST_SPI_Send_16
5099  0b6c 5b06          	addw	sp,#6
5100                     ; 1751       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg3[1] << 8) + (L99PM62drv_RegType)StatReg3[0] ;
5102  0b6e c60006        	ld	a,L73_StatReg3
5103  0b71 5f            	clrw	x
5104  0b72 97            	ld	xl,a
5105  0b73 1f01          	ldw	(OFST-1,sp),x
5106  0b75 c60007        	ld	a,L73_StatReg3+1
5107                     ; 1752       break;
5109                     ; 1759 }
5111  0b78 20d5          	jp	LC007
5168                     ; 1773 void L99PM62drv_ReadControl (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr)
5168                     ; 1774 {
5169                     	switch	.text
5170  0b7a               _L99PM62drv_ReadControl:
5172  0b7a 88            	push	a
5173  0b7b 89            	pushw	x
5174       00000002      OFST:	set	2
5177                     ; 1777   if (!InitFlag)
5179  0b7c c60000        	ld	a,L74_InitFlag
5180  0b7f 2609          	jrne	L3432
5181                     ; 1779     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_ReadControl, L99PM62DRV_EID_UNINIT))
5183  0b81 ae1d14        	ldw	x,#7444
5184  0b84 cd0000        	call	_L99PM62drv_ReportError
5186  0b87 4d            	tnz	a
5187  0b88 2727          	jreq	L664
5188                     ; 1781       return;
5190  0b8a               L3432:
5191                     ; 1786   switch (regID)
5193  0b8a 7b03          	ld	a,(OFST+1,sp)
5195                     ; 1841       return;
5196  0b8c 4a            	dec	a
5197  0b8d 2725          	jreq	L1032
5198  0b8f 4a            	dec	a
5199  0b90 2742          	jreq	L3032
5200  0b92 4a            	dec	a
5201  0b93 275e          	jreq	L5032
5202  0b95 4a            	dec	a
5203  0b96 277a          	jreq	L7032
5204  0b98 4a            	dec	a
5205  0b99 2603cc0c31    	jreq	L1132
5206  0b9e 4a            	dec	a
5207  0b9f 2603cc0c50    	jreq	L3132
5208  0ba4 a039          	sub	a,#57
5209  0ba6 2603cc0c7a    	jreq	L5132
5210                     ; 1837     default:
5210                     ; 1838 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
5210                     ; 1839       L99PM62drv_ReportError (SID_L99PM62drv_ReadControl, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
5212  0bab ae1d0c        	ldw	x,#7436
5213  0bae cd0000        	call	_L99PM62drv_ReportError
5215                     ; 1841       return;
5216  0bb1               L664:
5219  0bb1 5b03          	addw	sp,#3
5220  0bb3 81            	ret	
5221  0bb4               L1032:
5222                     ; 1788     case L99PM62DRV_CR1:
5222                     ; 1789       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR1,
5222                     ; 1790                             CtrlReg1,
5222                     ; 1791                             &GlobalStatusRegister,
5222                     ; 1792                             CtrlReg1);
5224  0bb4 ae0022        	ldw	x,#L3_CtrlReg1
5225  0bb7 89            	pushw	x
5226  0bb8 ae0001        	ldw	x,#L54_GlobalStatusRegister
5227  0bbb 89            	pushw	x
5228  0bbc ae0022        	ldw	x,#L3_CtrlReg1
5229  0bbf 89            	pushw	x
5230  0bc0 a641          	ld	a,#65
5231  0bc2 cd0e70        	call	_ST_SPI_Send_16
5233  0bc5 5b06          	addw	sp,#6
5234                     ; 1793       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg1[1] << 8 ) + (L99PM62drv_RegType)CtrlReg1[0] ;
5236  0bc7 c60022        	ld	a,L3_CtrlReg1
5237  0bca 5f            	clrw	x
5238  0bcb 97            	ld	xl,a
5239  0bcc 1f01          	ldw	(OFST-1,sp),x
5240  0bce c60023        	ld	a,L3_CtrlReg1+1
5241                     ; 1794       break;
5243  0bd1 cc0c6d        	jp	LC008
5244  0bd4               L3032:
5245                     ; 1795     case L99PM62DRV_CR2:
5245                     ; 1796       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR2,
5245                     ; 1797                             CtrlReg2,
5245                     ; 1798                             &GlobalStatusRegister,
5245                     ; 1799                             CtrlReg2);
5247  0bd4 ae001e        	ldw	x,#L7_CtrlReg2
5248  0bd7 89            	pushw	x
5249  0bd8 ae0001        	ldw	x,#L54_GlobalStatusRegister
5250  0bdb 89            	pushw	x
5251  0bdc ae001e        	ldw	x,#L7_CtrlReg2
5252  0bdf 89            	pushw	x
5253  0be0 a642          	ld	a,#66
5254  0be2 cd0e70        	call	_ST_SPI_Send_16
5256  0be5 5b06          	addw	sp,#6
5257                     ; 1800       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg2[1] << 8 ) + (L99PM62drv_RegType)CtrlReg2[0] ;
5259  0be7 c6001e        	ld	a,L7_CtrlReg2
5260  0bea 5f            	clrw	x
5261  0beb 97            	ld	xl,a
5262  0bec 1f01          	ldw	(OFST-1,sp),x
5263  0bee c6001f        	ld	a,L7_CtrlReg2+1
5264                     ; 1801       break;
5266  0bf1 207a          	jp	LC008
5267  0bf3               L5032:
5268                     ; 1802     case L99PM62DRV_CR3:
5268                     ; 1803       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR3,
5268                     ; 1804                             CtrlReg3,
5268                     ; 1805                             &GlobalStatusRegister,
5268                     ; 1806                             CtrlReg3);
5270  0bf3 ae001a        	ldw	x,#L31_CtrlReg3
5271  0bf6 89            	pushw	x
5272  0bf7 ae0001        	ldw	x,#L54_GlobalStatusRegister
5273  0bfa 89            	pushw	x
5274  0bfb ae001a        	ldw	x,#L31_CtrlReg3
5275  0bfe 89            	pushw	x
5276  0bff a643          	ld	a,#67
5277  0c01 cd0e70        	call	_ST_SPI_Send_16
5279  0c04 5b06          	addw	sp,#6
5280                     ; 1807       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg3[1] << 8) + (L99PM62drv_RegType)CtrlReg3[0] ;
5282  0c06 c6001a        	ld	a,L31_CtrlReg3
5283  0c09 5f            	clrw	x
5284  0c0a 97            	ld	xl,a
5285  0c0b 1f01          	ldw	(OFST-1,sp),x
5286  0c0d c6001b        	ld	a,L31_CtrlReg3+1
5287                     ; 1808       break;
5289  0c10 205b          	jp	LC008
5290  0c12               L7032:
5291                     ; 1809     case L99PM62DRV_CR4:
5291                     ; 1810       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR4,
5291                     ; 1811                             CtrlReg4,
5291                     ; 1812                             &GlobalStatusRegister,
5291                     ; 1813                             CtrlReg4);
5293  0c12 ae0016        	ldw	x,#L71_CtrlReg4
5294  0c15 89            	pushw	x
5295  0c16 ae0001        	ldw	x,#L54_GlobalStatusRegister
5296  0c19 89            	pushw	x
5297  0c1a ae0016        	ldw	x,#L71_CtrlReg4
5298  0c1d 89            	pushw	x
5299  0c1e a644          	ld	a,#68
5300  0c20 cd0e70        	call	_ST_SPI_Send_16
5302  0c23 5b06          	addw	sp,#6
5303                     ; 1814       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg4[1] << 8) + (L99PM62drv_RegType)CtrlReg4[0] ;
5305  0c25 c60016        	ld	a,L71_CtrlReg4
5306  0c28 5f            	clrw	x
5307  0c29 97            	ld	xl,a
5308  0c2a 1f01          	ldw	(OFST-1,sp),x
5309  0c2c c60017        	ld	a,L71_CtrlReg4+1
5310                     ; 1815       break;
5312  0c2f 203c          	jp	LC008
5313  0c31               L1132:
5314                     ; 1816     case L99PM62DRV_CR5:
5314                     ; 1817       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR5,
5314                     ; 1818                             CtrlReg5,
5314                     ; 1819                             &GlobalStatusRegister,
5314                     ; 1820                             CtrlReg5);
5316  0c31 ae0012        	ldw	x,#L32_CtrlReg5
5317  0c34 89            	pushw	x
5318  0c35 ae0001        	ldw	x,#L54_GlobalStatusRegister
5319  0c38 89            	pushw	x
5320  0c39 ae0012        	ldw	x,#L32_CtrlReg5
5321  0c3c 89            	pushw	x
5322  0c3d a645          	ld	a,#69
5323  0c3f cd0e70        	call	_ST_SPI_Send_16
5325  0c42 5b06          	addw	sp,#6
5326                     ; 1821       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg5[1] << 8) + (L99PM62drv_RegType)CtrlReg5[0] ;
5328  0c44 c60012        	ld	a,L32_CtrlReg5
5329  0c47 5f            	clrw	x
5330  0c48 97            	ld	xl,a
5331  0c49 1f01          	ldw	(OFST-1,sp),x
5332  0c4b c60013        	ld	a,L32_CtrlReg5+1
5333                     ; 1822       break;
5335  0c4e 201d          	jp	LC008
5336  0c50               L3132:
5337                     ; 1823     case L99PM62DRV_CR6:
5337                     ; 1824       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR6,
5337                     ; 1825                             CtrlReg6,
5337                     ; 1826                             &GlobalStatusRegister,
5337                     ; 1827                             CtrlReg6);
5339  0c50 ae000e        	ldw	x,#L72_CtrlReg6
5340  0c53 89            	pushw	x
5341  0c54 ae0001        	ldw	x,#L54_GlobalStatusRegister
5342  0c57 89            	pushw	x
5343  0c58 ae000e        	ldw	x,#L72_CtrlReg6
5344  0c5b 89            	pushw	x
5345  0c5c a646          	ld	a,#70
5346  0c5e cd0e70        	call	_ST_SPI_Send_16
5348  0c61 5b06          	addw	sp,#6
5349                     ; 1828       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg6[1] << 8) + (L99PM62drv_RegType)CtrlReg6[0] ;
5351  0c63 c6000e        	ld	a,L72_CtrlReg6
5352  0c66 5f            	clrw	x
5353  0c67 97            	ld	xl,a
5354  0c68 1f01          	ldw	(OFST-1,sp),x
5355  0c6a c6000f        	ld	a,L72_CtrlReg6+1
5356  0c6d               LC008:
5357  0c6d 97            	ld	xl,a
5358  0c6e 4f            	clr	a
5359  0c6f 02            	rlwa	x,a
5360  0c70 1606          	ldw	y,(OFST+4,sp)
5361  0c72 72fb01        	addw	x,(OFST-1,sp)
5362  0c75 90ff          	ldw	(y),x
5363                     ; 1829       break;
5365  0c77 cc0bb1        	jra	L664
5366  0c7a               L5132:
5367                     ; 1830     case L99PM62DRV_CFR:
5367                     ; 1831       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CFR,
5367                     ; 1832                             ConfigReg,
5367                     ; 1833                             &GlobalStatusRegister,
5367                     ; 1834                             ConfigReg);
5369  0c7a ae0004        	ldw	x,#L14_ConfigReg
5370  0c7d 89            	pushw	x
5371  0c7e ae0001        	ldw	x,#L54_GlobalStatusRegister
5372  0c81 89            	pushw	x
5373  0c82 ae0004        	ldw	x,#L14_ConfigReg
5374  0c85 89            	pushw	x
5375  0c86 a67f          	ld	a,#127
5376  0c88 cd0e70        	call	_ST_SPI_Send_16
5378  0c8b 5b06          	addw	sp,#6
5379                     ; 1835       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)ConfigReg[1] << 8) + (L99PM62drv_RegType)ConfigReg[0] ;
5381  0c8d c60004        	ld	a,L14_ConfigReg
5382  0c90 5f            	clrw	x
5383  0c91 97            	ld	xl,a
5384  0c92 1f01          	ldw	(OFST-1,sp),x
5385  0c94 c60005        	ld	a,L14_ConfigReg+1
5386                     ; 1836       break;
5388                     ; 1843 }
5390  0c97 20d4          	jp	LC008
5445                     ; 1857 void L99PM62drv_GetControl (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr )
5445                     ; 1858 {
5446                     	switch	.text
5447  0c99               _L99PM62drv_GetControl:
5449  0c99 88            	push	a
5450  0c9a 89            	pushw	x
5451       00000002      OFST:	set	2
5454                     ; 1861   if (!InitFlag)
5456  0c9b c60000        	ld	a,L74_InitFlag
5457  0c9e 2609          	jrne	L5142
5458                     ; 1863     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_GetControl, L99PM62DRV_EID_UNINIT))
5460  0ca0 ae1f14        	ldw	x,#7956
5461  0ca3 cd0000        	call	_L99PM62drv_ReportError
5463  0ca6 4d            	tnz	a
5464  0ca7 271e          	jreq	L674
5465                     ; 1865       return;
5467  0ca9               L5142:
5468                     ; 1870   switch (regID)
5470  0ca9 7b03          	ld	a,(OFST+1,sp)
5472                     ; 1897       return;
5473  0cab 4a            	dec	a
5474  0cac 271c          	jreq	L3532
5475  0cae 4a            	dec	a
5476  0caf 2725          	jreq	L5532
5477  0cb1 4a            	dec	a
5478  0cb2 272e          	jreq	L7532
5479  0cb4 4a            	dec	a
5480  0cb5 2737          	jreq	L1632
5481  0cb7 4a            	dec	a
5482  0cb8 2740          	jreq	L3632
5483  0cba 4a            	dec	a
5484  0cbb 2749          	jreq	L5632
5485  0cbd a039          	sub	a,#57
5486  0cbf 275b          	jreq	L7632
5487                     ; 1893     default:
5487                     ; 1894 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
5487                     ; 1895       L99PM62drv_ReportError (SID_L99PM62drv_GetControl, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
5489  0cc1 ae1f0c        	ldw	x,#7948
5490  0cc4 cd0000        	call	_L99PM62drv_ReportError
5492                     ; 1897       return;
5493  0cc7               L674:
5496  0cc7 5b03          	addw	sp,#3
5497  0cc9 81            	ret	
5498  0cca               L3532:
5499                     ; 1872     case L99PM62DRV_CR1:
5499                     ; 1873       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg1_old[1] << 8) + (L99PM62drv_RegType)CtrlReg1_old[0] ;
5501  0cca c60020        	ld	a,L5_CtrlReg1_old
5502  0ccd 5f            	clrw	x
5503  0cce 97            	ld	xl,a
5504  0ccf 1f01          	ldw	(OFST-1,sp),x
5505  0cd1 c60021        	ld	a,L5_CtrlReg1_old+1
5506                     ; 1874       break;
5508  0cd4 203a          	jp	LC009
5509  0cd6               L5532:
5510                     ; 1875     case L99PM62DRV_CR2:
5510                     ; 1876       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg2_old[1] << 8) + (L99PM62drv_RegType)CtrlReg2_old[0] ;
5512  0cd6 c6001c        	ld	a,L11_CtrlReg2_old
5513  0cd9 5f            	clrw	x
5514  0cda 97            	ld	xl,a
5515  0cdb 1f01          	ldw	(OFST-1,sp),x
5516  0cdd c6001d        	ld	a,L11_CtrlReg2_old+1
5517                     ; 1877       break;
5519  0ce0 202e          	jp	LC009
5520  0ce2               L7532:
5521                     ; 1878     case L99PM62DRV_CR3:
5521                     ; 1879       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg3_old[1] << 8) + (L99PM62drv_RegType)CtrlReg3_old[0] ;
5523  0ce2 c60018        	ld	a,L51_CtrlReg3_old
5524  0ce5 5f            	clrw	x
5525  0ce6 97            	ld	xl,a
5526  0ce7 1f01          	ldw	(OFST-1,sp),x
5527  0ce9 c60019        	ld	a,L51_CtrlReg3_old+1
5528                     ; 1880       break;
5530  0cec 2022          	jp	LC009
5531  0cee               L1632:
5532                     ; 1881     case L99PM62DRV_CR4:
5532                     ; 1882       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg4_old[1] << 8) + (L99PM62drv_RegType)CtrlReg4_old[0] ;
5534  0cee c60014        	ld	a,L12_CtrlReg4_old
5535  0cf1 5f            	clrw	x
5536  0cf2 97            	ld	xl,a
5537  0cf3 1f01          	ldw	(OFST-1,sp),x
5538  0cf5 c60015        	ld	a,L12_CtrlReg4_old+1
5539                     ; 1883       break;
5541  0cf8 2016          	jp	LC009
5542  0cfa               L3632:
5543                     ; 1884     case L99PM62DRV_CR5:
5543                     ; 1885       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg5_old[1] << 8) + (L99PM62drv_RegType)CtrlReg5_old[0] ;
5545  0cfa c60010        	ld	a,L52_CtrlReg5_old
5546  0cfd 5f            	clrw	x
5547  0cfe 97            	ld	xl,a
5548  0cff 1f01          	ldw	(OFST-1,sp),x
5549  0d01 c60011        	ld	a,L52_CtrlReg5_old+1
5550                     ; 1886       break;
5552  0d04 200a          	jp	LC009
5553  0d06               L5632:
5554                     ; 1887     case L99PM62DRV_CR6:
5554                     ; 1888       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg6_old[1] << 8) + (L99PM62drv_RegType)CtrlReg6_old[0] ;
5556  0d06 c6000c        	ld	a,L13_CtrlReg6_old
5557  0d09 5f            	clrw	x
5558  0d0a 97            	ld	xl,a
5559  0d0b 1f01          	ldw	(OFST-1,sp),x
5560  0d0d c6000d        	ld	a,L13_CtrlReg6_old+1
5561  0d10               LC009:
5562  0d10 97            	ld	xl,a
5563  0d11 4f            	clr	a
5564  0d12 02            	rlwa	x,a
5565  0d13 1606          	ldw	y,(OFST+4,sp)
5566  0d15 72fb01        	addw	x,(OFST-1,sp)
5567  0d18 90ff          	ldw	(y),x
5568                     ; 1889       break;
5570  0d1a 20ab          	jra	L674
5571  0d1c               L7632:
5572                     ; 1890     case L99PM62DRV_CFR:
5572                     ; 1891       *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)ConfigReg_old[1] << 8) + (L99PM62drv_RegType)ConfigReg_old[0] ;
5574  0d1c c60002        	ld	a,L34_ConfigReg_old
5575  0d1f 5f            	clrw	x
5576  0d20 97            	ld	xl,a
5577  0d21 1f01          	ldw	(OFST-1,sp),x
5578  0d23 c60003        	ld	a,L34_ConfigReg_old+1
5579                     ; 1892       break;
5581                     ; 1899 }
5583  0d26 20e8          	jp	LC009
5647                     ; 1913 void L99PM62drv_WriteControl (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr)
5647                     ; 1914 {
5648                     	switch	.text
5649  0d28               _L99PM62drv_WriteControl:
5651  0d28 88            	push	a
5652  0d29 88            	push	a
5653       00000001      OFST:	set	1
5656                     ; 1917   if (!InitFlag)
5658  0d2a c60000        	ld	a,L74_InitFlag
5659  0d2d 2609          	jrne	L7642
5660                     ; 1919     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_WriteControl, L99PM62DRV_EID_UNINIT))
5662  0d2f ae4014        	ldw	x,#16404
5663  0d32 cd0000        	call	_L99PM62drv_ReportError
5665  0d35 4d            	tnz	a
5666  0d36 272a          	jreq	L425
5667                     ; 1921       return;
5669  0d38               L7642:
5670                     ; 1926   switch (regID)
5672  0d38 7b02          	ld	a,(OFST+1,sp)
5674                     ; 1988       return;
5675  0d3a 4a            	dec	a
5676  0d3b 2727          	jreq	L5242
5677  0d3d 4a            	dec	a
5678  0d3e 274f          	jreq	L7242
5679  0d40 4a            	dec	a
5680  0d41 276c          	jreq	L1342
5681  0d43 4a            	dec	a
5682  0d44 2603cc0dce    	jreq	L3342
5683  0d49 4a            	dec	a
5684  0d4a 2603cc0ded    	jreq	L5342
5685  0d4f 4a            	dec	a
5686  0d50 2603cc0e0c    	jreq	L7342
5687  0d55 a039          	sub	a,#57
5688  0d57 2603cc0e2b    	jreq	L1442
5689                     ; 1984     default:
5689                     ; 1985 #ifdef  L99PM62DRV_DEV_ERROR_DETECT
5689                     ; 1986       L99PM62drv_ReportError (SID_L99PM62drv_WriteControl, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
5691  0d5c ae400c        	ldw	x,#16396
5692  0d5f cd0000        	call	_L99PM62drv_ReportError
5694                     ; 1988       return;
5695  0d62               L425:
5698  0d62 85            	popw	x
5699  0d63 81            	ret	
5700  0d64               L5242:
5701                     ; 1928     case L99PM62DRV_CR1:
5701                     ; 1929       CtrlReg1[1] = (u8)(*DataPtr >> 8);
5703  0d64 1e05          	ldw	x,(OFST+4,sp)
5704  0d66 fe            	ldw	x,(x)
5705  0d67 01            	rrwa	x,a
5706  0d68 9f            	ld	a,xl
5707  0d69 c70023        	ld	L3_CtrlReg1+1,a
5708                     ; 1930       CtrlReg1[0] = (CtrlReg1[0] & 0x01U) | ((u8)(*DataPtr) & ~0x01U);
5710  0d6c 1e05          	ldw	x,(OFST+4,sp)
5711  0d6e e601          	ld	a,(1,x)
5712  0d70 a4fe          	and	a,#254
5713  0d72 6b01          	ld	(OFST+0,sp),a
5714  0d74 c60022        	ld	a,L3_CtrlReg1
5715  0d77 a401          	and	a,#1
5716  0d79 1a01          	or	a,(OFST+0,sp)
5717  0d7b c70022        	ld	L3_CtrlReg1,a
5718                     ; 1931       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
5718                     ; 1932                             CtrlReg1,
5718                     ; 1933                             &GlobalStatusRegister,
5718                     ; 1934                             CtrlReg1_old);
5720  0d7e ae0020        	ldw	x,#L5_CtrlReg1_old
5721  0d81 89            	pushw	x
5722  0d82 ae0001        	ldw	x,#L54_GlobalStatusRegister
5723  0d85 89            	pushw	x
5724  0d86 ae0022        	ldw	x,#L3_CtrlReg1
5725  0d89 89            	pushw	x
5726  0d8a a601          	ld	a,#1
5728                     ; 1935       break;
5730  0d8c cc0e48        	jra	L5742
5731  0d8f               L7242:
5732                     ; 1936     case L99PM62DRV_CR2:
5732                     ; 1937       CtrlReg2[1] = (u8)(*DataPtr >> 8);
5734  0d8f 1e05          	ldw	x,(OFST+4,sp)
5735  0d91 fe            	ldw	x,(x)
5736  0d92 01            	rrwa	x,a
5737  0d93 9f            	ld	a,xl
5738  0d94 c7001f        	ld	L7_CtrlReg2+1,a
5739                     ; 1938       CtrlReg2[0] = (u8)(*DataPtr);
5741  0d97 1e05          	ldw	x,(OFST+4,sp)
5742  0d99 e601          	ld	a,(1,x)
5743  0d9b c7001e        	ld	L7_CtrlReg2,a
5744                     ; 1939       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR2,
5744                     ; 1940                             CtrlReg2,
5744                     ; 1941                             &GlobalStatusRegister,
5744                     ; 1942                             CtrlReg2_old);
5746  0d9e ae001c        	ldw	x,#L11_CtrlReg2_old
5747  0da1 89            	pushw	x
5748  0da2 ae0001        	ldw	x,#L54_GlobalStatusRegister
5749  0da5 89            	pushw	x
5750  0da6 ae001e        	ldw	x,#L7_CtrlReg2
5751  0da9 89            	pushw	x
5752  0daa a602          	ld	a,#2
5754                     ; 1943       break;
5756  0dac cc0e48        	jra	L5742
5757  0daf               L1342:
5758                     ; 1944     case L99PM62DRV_CR3:
5758                     ; 1945       CtrlReg3[1] = (u8)(*DataPtr >> 8);
5760  0daf 1e05          	ldw	x,(OFST+4,sp)
5761  0db1 fe            	ldw	x,(x)
5762  0db2 01            	rrwa	x,a
5763  0db3 9f            	ld	a,xl
5764  0db4 c7001b        	ld	L31_CtrlReg3+1,a
5765                     ; 1946       CtrlReg3[0] = (u8)(*DataPtr);
5767  0db7 1e05          	ldw	x,(OFST+4,sp)
5768  0db9 e601          	ld	a,(1,x)
5769  0dbb c7001a        	ld	L31_CtrlReg3,a
5770                     ; 1947       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
5770                     ; 1948                             CtrlReg3,
5770                     ; 1949                             &GlobalStatusRegister,
5770                     ; 1950                             CtrlReg3_old);
5772  0dbe ae0018        	ldw	x,#L51_CtrlReg3_old
5773  0dc1 89            	pushw	x
5774  0dc2 ae0001        	ldw	x,#L54_GlobalStatusRegister
5775  0dc5 89            	pushw	x
5776  0dc6 ae001a        	ldw	x,#L31_CtrlReg3
5777  0dc9 89            	pushw	x
5778  0dca a603          	ld	a,#3
5780                     ; 1951       break;
5782  0dcc 207a          	jra	L5742
5783  0dce               L3342:
5784                     ; 1952     case L99PM62DRV_CR4:
5784                     ; 1953       CtrlReg4[1] = (u8)(*DataPtr >> 8);
5786  0dce 1e05          	ldw	x,(OFST+4,sp)
5787  0dd0 fe            	ldw	x,(x)
5788  0dd1 01            	rrwa	x,a
5789  0dd2 9f            	ld	a,xl
5790  0dd3 c70017        	ld	L71_CtrlReg4+1,a
5791                     ; 1954       CtrlReg4[0] = (u8)(*DataPtr);
5793  0dd6 1e05          	ldw	x,(OFST+4,sp)
5794  0dd8 e601          	ld	a,(1,x)
5795  0dda c70016        	ld	L71_CtrlReg4,a
5796                     ; 1955       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
5796                     ; 1956                             CtrlReg4,
5796                     ; 1957                             &GlobalStatusRegister,
5796                     ; 1958                             CtrlReg4_old);
5798  0ddd ae0014        	ldw	x,#L12_CtrlReg4_old
5799  0de0 89            	pushw	x
5800  0de1 ae0001        	ldw	x,#L54_GlobalStatusRegister
5801  0de4 89            	pushw	x
5802  0de5 ae0016        	ldw	x,#L71_CtrlReg4
5803  0de8 89            	pushw	x
5804  0de9 a604          	ld	a,#4
5806                     ; 1959       break;
5808  0deb 205b          	jra	L5742
5809  0ded               L5342:
5810                     ; 1960     case L99PM62DRV_CR5:
5810                     ; 1961       CtrlReg5[1] = (u8)(*DataPtr >> 8);
5812  0ded 1e05          	ldw	x,(OFST+4,sp)
5813  0def fe            	ldw	x,(x)
5814  0df0 01            	rrwa	x,a
5815  0df1 9f            	ld	a,xl
5816  0df2 c70013        	ld	L32_CtrlReg5+1,a
5817                     ; 1962       CtrlReg5[0] = (u8)(*DataPtr);
5819  0df5 1e05          	ldw	x,(OFST+4,sp)
5820  0df7 e601          	ld	a,(1,x)
5821  0df9 c70012        	ld	L32_CtrlReg5,a
5822                     ; 1963       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR5,
5822                     ; 1964                             CtrlReg5,
5822                     ; 1965                             &GlobalStatusRegister,
5822                     ; 1966                             CtrlReg5_old);
5824  0dfc ae0010        	ldw	x,#L52_CtrlReg5_old
5825  0dff 89            	pushw	x
5826  0e00 ae0001        	ldw	x,#L54_GlobalStatusRegister
5827  0e03 89            	pushw	x
5828  0e04 ae0012        	ldw	x,#L32_CtrlReg5
5829  0e07 89            	pushw	x
5830  0e08 a605          	ld	a,#5
5832                     ; 1967       break;
5834  0e0a 203c          	jra	L5742
5835  0e0c               L7342:
5836                     ; 1968     case L99PM62DRV_CR6:
5836                     ; 1969       CtrlReg6[1] = (u8)(*DataPtr >> 8);
5838  0e0c 1e05          	ldw	x,(OFST+4,sp)
5839  0e0e fe            	ldw	x,(x)
5840  0e0f 01            	rrwa	x,a
5841  0e10 9f            	ld	a,xl
5842  0e11 c7000f        	ld	L72_CtrlReg6+1,a
5843                     ; 1970       CtrlReg6[0] = (u8)(*DataPtr);
5845  0e14 1e05          	ldw	x,(OFST+4,sp)
5846  0e16 e601          	ld	a,(1,x)
5847  0e18 c7000e        	ld	L72_CtrlReg6,a
5848                     ; 1971       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR6,
5848                     ; 1972                             CtrlReg6,
5848                     ; 1973                             &GlobalStatusRegister,
5848                     ; 1974                             CtrlReg6_old);
5850  0e1b ae000c        	ldw	x,#L13_CtrlReg6_old
5851  0e1e 89            	pushw	x
5852  0e1f ae0001        	ldw	x,#L54_GlobalStatusRegister
5853  0e22 89            	pushw	x
5854  0e23 ae000e        	ldw	x,#L72_CtrlReg6
5855  0e26 89            	pushw	x
5856  0e27 a606          	ld	a,#6
5858                     ; 1975       break;
5860  0e29 201d          	jra	L5742
5861  0e2b               L1442:
5862                     ; 1976     case L99PM62DRV_CFR:
5862                     ; 1977       ConfigReg[1] = (u8)(*DataPtr >> 8);
5864  0e2b 1e05          	ldw	x,(OFST+4,sp)
5865  0e2d fe            	ldw	x,(x)
5866  0e2e 01            	rrwa	x,a
5867  0e2f 9f            	ld	a,xl
5868  0e30 c70005        	ld	L14_ConfigReg+1,a
5869                     ; 1978       ConfigReg[0] = (u8)(*DataPtr);
5871  0e33 1e05          	ldw	x,(OFST+4,sp)
5872  0e35 e601          	ld	a,(1,x)
5873  0e37 c70004        	ld	L14_ConfigReg,a
5874                     ; 1979       L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CFR,
5874                     ; 1980                             ConfigReg,
5874                     ; 1981                             &GlobalStatusRegister,
5874                     ; 1982                             ConfigReg_old);
5876  0e3a ae0002        	ldw	x,#L34_ConfigReg_old
5877  0e3d 89            	pushw	x
5878  0e3e ae0001        	ldw	x,#L54_GlobalStatusRegister
5879  0e41 89            	pushw	x
5880  0e42 ae0004        	ldw	x,#L14_ConfigReg
5881  0e45 89            	pushw	x
5882  0e46 a63f          	ld	a,#63
5884                     ; 1983       break;
5886  0e48               L5742:
5887  0e48 ad26          	call	_ST_SPI_Send_16
5888  0e4a 5b06          	addw	sp,#6
5889                     ; 1990 }
5892  0e4c 85            	popw	x
5893  0e4d 81            	ret	
5923                     ; 2003 void L99PM62drv_ClearStatusRegisters (void)
5923                     ; 2004 {
5924                     	switch	.text
5925  0e4e               _L99PM62drv_ClearStatusRegisters:
5929                     ; 2007   if (!InitFlag)
5931  0e4e c60000        	ld	a,L74_InitFlag
5932  0e51 260a          	jrne	L7052
5933                     ; 2009     if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_ClearStatusRegisters, L99PM62DRV_EID_UNINIT))
5935  0e53 ae1e14        	ldw	x,#7700
5936  0e56 cd0000        	call	_L99PM62drv_ReportError
5938  0e59 4d            	tnz	a
5939  0e5a 2601          	jrne	L7052
5940                     ; 2011       return;
5943  0e5c 81            	ret	
5944  0e5d               L7052:
5945                     ; 2015   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ_CLEAR | L99PM62DRV_CFR,
5945                     ; 2016                         ConfigReg,
5945                     ; 2017                         &GlobalStatusRegister,
5945                     ; 2018                         ConfigReg_old);
5947  0e5d ae0002        	ldw	x,#L34_ConfigReg_old
5948  0e60 89            	pushw	x
5949  0e61 ae0001        	ldw	x,#L54_GlobalStatusRegister
5950  0e64 89            	pushw	x
5951  0e65 ae0004        	ldw	x,#L14_ConfigReg
5952  0e68 89            	pushw	x
5953  0e69 a6bf          	ld	a,#191
5954  0e6b ad03          	call	_ST_SPI_Send_16
5956  0e6d 5b06          	addw	sp,#6
5957                     ; 2019 }
5960  0e6f 81            	ret	
6035                     ; 2032 void L99PM62DRV_AL_SPI_WR( u8  commandByte,  u8*  dataIn,
6035                     ; 2033                            u8*  globalStatus,  u8*  dataOut)
6035                     ; 2034 {
6036                     	switch	.text
6037  0e70               _ST_SPI_Send_16:
6039  0e70 88            	push	a
6040  0e71 88            	push	a
6041       00000001      OFST:	set	1
6044                     ; 2038   temp = GPIOE->ODR;
6046  0e72 c65014        	ld	a,20500
6047                     ; 2039   temp &= 0xDF;
6049  0e75 a4df          	and	a,#223
6050  0e77 6b01          	ld	(OFST+0,sp),a
6051                     ; 2040   GPIOE->ODR = temp;
6053  0e79 c75014        	ld	20500,a
6054                     ; 2042   SPI_SendData(commandByte);
6056  0e7c 7b02          	ld	a,(OFST+1,sp)
6057  0e7e cd0000        	call	_SPI_SendData
6060  0e81               L7552:
6061                     ; 2043   while (!SPI_GetFlagStatus(SPI_FLAG_TXE));
6063  0e81 a602          	ld	a,#2
6064  0e83 cd0000        	call	_SPI_GetFlagStatus
6066  0e86 4d            	tnz	a
6067  0e87 27f8          	jreq	L7552
6069  0e89               L5652:
6070                     ; 2045   while (!SPI_GetFlagStatus(SPI_FLAG_RXNE));
6072  0e89 a601          	ld	a,#1
6073  0e8b cd0000        	call	_SPI_GetFlagStatus
6075  0e8e 4d            	tnz	a
6076  0e8f 27f8          	jreq	L5652
6077                     ; 2046   globalStatus[0] = SPI_ReceiveData();
6079  0e91 cd0000        	call	_SPI_ReceiveData
6081  0e94 1e07          	ldw	x,(OFST+6,sp)
6082  0e96 f7            	ld	(x),a
6083                     ; 2049   if (globalStatus[0] != L99PM62_NoError)
6085  0e97 a120          	cp	a,#32
6086  0e99 2774          	jreq	L1752
6087                     ; 2051     ErrorState = TRUE;
6089  0e9b 35010000      	mov	_ErrorState,#1
6090                     ; 2052     if (StartupCompleted == TRUE) /* To allow leds display at startup */
6092  0e9f c60000        	ld	a,_StartupCompleted
6093  0ea2 4a            	dec	a
6094  0ea3 266e          	jrne	L3062
6095                     ; 2054       count ++;
6097  0ea5 725c0001      	inc	_count
6098                     ; 2055       if (count > 20)
6100  0ea9 c60001        	ld	a,_count
6101  0eac a115          	cp	a,#21
6102  0eae 250c          	jrult	L5752
6103                     ; 2057         GPIO_TOGGLE(GPIOA, GPIO_PIN_3);
6105  0eb0 c65000        	ld	a,20480
6106  0eb3 a808          	xor	a,#8
6107  0eb5 c75000        	ld	20480,a
6108                     ; 2058         count = 0;
6110  0eb8 725f0001      	clr	_count
6111  0ebc               L5752:
6112                     ; 2060       switch (globalStatus[0])
6114  0ebc f6            	ld	a,(x)
6116                     ; 2094           break;
6117  0ebd a0a1          	sub	a,#161
6118  0ebf 2724          	jreq	L3152
6119  0ec1 4a            	dec	a
6120  0ec2 272b          	jreq	L5152
6121  0ec4 4a            	dec	a
6122  0ec5 2728          	jreq	L5152
6123  0ec7 a005          	sub	a,#5
6124  0ec9 2732          	jreq	L7152
6125  0ecb a011          	sub	a,#17
6126  0ecd 272e          	jreq	L7152
6127  0ecf a007          	sub	a,#7
6128  0ed1 2712          	jreq	L3152
6129                     ; 2089         default:
6129                     ; 2090           GPIO_LOW(GPIOD, GPIO_PIN_3);
6131  0ed3 7217500f      	bres	20495,#3
6132                     ; 2091           GPIO_LOW(GPIOD, GPIO_PIN_0);
6134  0ed7 7211500f      	bres	20495,#0
6135                     ; 2092           GPIO_LOW(GPIOE, GPIO_PIN_3);
6137  0edb 72175014      	bres	20500,#3
6138                     ; 2093           GPIO_HIGH(GPIOC, GPIO_PIN_3);
6140  0edf 7216500a      	bset	20490,#3
6141                     ; 2094           break;
6143  0ee3 202e          	jra	L3062
6144  0ee5               L3152:
6145                     ; 2062         case (L99PM62_CommError):
6145                     ; 2063               case (L99PM62_WD_SPI_Error):
6145                     ; 2064                   /* LD4 ON Invalid clock count*/
6145                     ; 2065                   GPIO_HIGH(GPIOD, GPIO_PIN_3);
6147  0ee5 7216500f      	bset	20495,#3
6148                     ; 2066           GPIO_LOW(GPIOD, GPIO_PIN_0);
6150  0ee9 7211500f      	bres	20495,#0
6151                     ; 2067           GPIO_LOW(GPIOE, GPIO_PIN_3);
6152                     ; 2068           GPIO_LOW(GPIOC, GPIO_PIN_3);
6153                     ; 2069           break;
6155  0eed 2008          	jp	LC011
6156  0eef               L5152:
6157                     ; 2071         case (L99PM62_VsOverVUnderV):
6157                     ; 2072               case (L99PM62_VsOverVUnderVFS):
6157                     ; 2073                   /* LD5 ON Vs out of range */
6157                     ; 2074                   GPIO_LOW(GPIOD, GPIO_PIN_3);
6159  0eef 7217500f      	bres	20495,#3
6160                     ; 2075           GPIO_HIGH(GPIOD, GPIO_PIN_0);
6162  0ef3 7210500f      	bset	20495,#0
6163                     ; 2076           GPIO_LOW(GPIOE, GPIO_PIN_3);
6165  0ef7               LC011:
6167  0ef7 72175014      	bres	20500,#3
6168                     ; 2077           GPIO_LOW(GPIOC, GPIO_PIN_3);
6169                     ; 2078           break;
6171  0efb 200c          	jp	LC010
6172  0efd               L7152:
6173                     ; 2080         case (L99PM62_TSD1):
6173                     ; 2081               case (L99PM62_TSD2):
6173                     ; 2082                   /* LD7 ON Thermal shutdown */
6173                     ; 2083                   GPIO_LOW(GPIOD, GPIO_PIN_3);
6175  0efd 7217500f      	bres	20495,#3
6176                     ; 2084           GPIO_LOW(GPIOD, GPIO_PIN_0);
6178  0f01 7211500f      	bres	20495,#0
6179                     ; 2085           GPIO_HIGH(GPIOE, GPIO_PIN_3);
6181  0f05 72165014      	bset	20500,#3
6182                     ; 2086           GPIO_LOW(GPIOC, GPIO_PIN_3);
6184  0f09               LC010:
6187  0f09 7217500a      	bres	20490,#3
6188                     ; 2087           break;
6190  0f0d 2004          	jra	L3062
6191  0f0f               L1752:
6192                     ; 2100     ErrorState = FALSE;
6194  0f0f 725f0000      	clr	_ErrorState
6195  0f13               L3062:
6196                     ; 2103   SPI_SendData(dataIn[1]);
6198  0f13 1e05          	ldw	x,(OFST+4,sp)
6199  0f15 e601          	ld	a,(1,x)
6200  0f17 cd0000        	call	_SPI_SendData
6203  0f1a               L7062:
6204                     ; 2104   while (!SPI_GetFlagStatus(SPI_FLAG_TXE));
6206  0f1a a602          	ld	a,#2
6207  0f1c cd0000        	call	_SPI_GetFlagStatus
6209  0f1f 4d            	tnz	a
6210  0f20 27f8          	jreq	L7062
6212  0f22               L5162:
6213                     ; 2106   while (!SPI_GetFlagStatus(SPI_FLAG_RXNE));
6215  0f22 a601          	ld	a,#1
6216  0f24 cd0000        	call	_SPI_GetFlagStatus
6218  0f27 4d            	tnz	a
6219  0f28 27f8          	jreq	L5162
6220                     ; 2107   dataOut[1] = SPI_ReceiveData();
6222  0f2a cd0000        	call	_SPI_ReceiveData
6224  0f2d 1e09          	ldw	x,(OFST+8,sp)
6225  0f2f e701          	ld	(1,x),a
6226                     ; 2109   SPI_SendData(dataIn[0]);
6228  0f31 1e05          	ldw	x,(OFST+4,sp)
6229  0f33 f6            	ld	a,(x)
6230  0f34 cd0000        	call	_SPI_SendData
6233  0f37               L3262:
6234                     ; 2110   while (!SPI_GetFlagStatus(SPI_FLAG_TXE));
6236  0f37 a602          	ld	a,#2
6237  0f39 cd0000        	call	_SPI_GetFlagStatus
6239  0f3c 4d            	tnz	a
6240  0f3d 27f8          	jreq	L3262
6242  0f3f               L1362:
6243                     ; 2112   while (!SPI_GetFlagStatus(SPI_FLAG_RXNE));
6245  0f3f a601          	ld	a,#1
6246  0f41 cd0000        	call	_SPI_GetFlagStatus
6248  0f44 4d            	tnz	a
6249  0f45 27f8          	jreq	L1362
6250                     ; 2113   dataOut[0] = SPI_ReceiveData();
6252  0f47 cd0000        	call	_SPI_ReceiveData
6254  0f4a 1e09          	ldw	x,(OFST+8,sp)
6255  0f4c f7            	ld	(x),a
6256                     ; 2116   temp = GPIOE->ODR;
6258  0f4d c65014        	ld	a,20500
6259                     ; 2117   temp |= 0x20;
6261  0f50 aa20          	or	a,#32
6262                     ; 2118   GPIOE->ODR = (uint8_t)temp;
6264  0f52 c75014        	ld	20500,a
6265                     ; 2119 }
6268  0f55 85            	popw	x
6269  0f56 81            	ret	
6309                     ; 2132 void L99PM62drv_SetCanLoopBackMode (L99PM62drv_EnableType CanLoop)
6309                     ; 2133 {
6310                     	switch	.text
6311  0f57               _L99PM62drv_SetCanLoopBackMode:
6315                     ; 2135   if (CanLoop ==  L99PM62DRV_DISABLE)
6317  0f57 4d            	tnz	a
6318  0f58 2606          	jrne	L3562
6319                     ; 2137     CtrlReg4[0] &= (u8)~0x08U;
6321  0f5a 72170016      	bres	L71_CtrlReg4,#3
6323  0f5e 2004          	jra	L5562
6324  0f60               L3562:
6325                     ; 2141     CtrlReg4[0] |= 0x08U;
6327  0f60 72160016      	bset	L71_CtrlReg4,#3
6328  0f64               L5562:
6329                     ; 2144   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
6329                     ; 2145                         CtrlReg4,
6329                     ; 2146                         &GlobalStatusRegister,
6329                     ; 2147                         CtrlReg4_old);
6331  0f64 ae0014        	ldw	x,#L12_CtrlReg4_old
6332  0f67 89            	pushw	x
6333  0f68 ae0001        	ldw	x,#L54_GlobalStatusRegister
6334  0f6b 89            	pushw	x
6335  0f6c ae0016        	ldw	x,#L71_CtrlReg4
6336  0f6f 89            	pushw	x
6337  0f70 a604          	ld	a,#4
6338  0f72 cd0e70        	call	_ST_SPI_Send_16
6340  0f75 5b06          	addw	sp,#6
6341                     ; 2149 }
6344  0f77 81            	ret	
6384                     ; 2161 void L99PM62drv_SetCanPatternWakeUp (L99PM62drv_EnableType CanPattern)
6384                     ; 2162 {
6385                     	switch	.text
6386  0f78               _L99PM62drv_SetCanPatternWakeUp:
6390                     ; 2164   if (CanPattern ==  L99PM62DRV_DISABLE)
6392  0f78 4d            	tnz	a
6393  0f79 2606          	jrne	L5762
6394                     ; 2166     CtrlReg4[0] &= (u8)~0x04U;
6396  0f7b 72150016      	bres	L71_CtrlReg4,#2
6398  0f7f 2004          	jra	L7762
6399  0f81               L5762:
6400                     ; 2170     CtrlReg4[0] |= 0x04U;
6402  0f81 72140016      	bset	L71_CtrlReg4,#2
6403  0f85               L7762:
6404                     ; 2173   L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
6404                     ; 2174                         CtrlReg4,
6404                     ; 2175                         &GlobalStatusRegister,
6404                     ; 2176                         CtrlReg4_old);
6406  0f85 ae0014        	ldw	x,#L12_CtrlReg4_old
6407  0f88 89            	pushw	x
6408  0f89 ae0001        	ldw	x,#L54_GlobalStatusRegister
6409  0f8c 89            	pushw	x
6410  0f8d ae0016        	ldw	x,#L71_CtrlReg4
6411  0f90 89            	pushw	x
6412  0f91 a604          	ld	a,#4
6413  0f93 cd0e70        	call	_ST_SPI_Send_16
6415  0f96 5b06          	addw	sp,#6
6416                     ; 2178 }
6419  0f98 81            	ret	
6636                     	xref	_StartupCompleted
6637                     	switch	.bss
6638  0000               _ErrorState:
6639  0000 00            	ds.b	1
6640                     	xdef	_ErrorState
6641                     	xdef	_count
6642  0001               L54_GlobalStatusRegister:
6643  0001 00            	ds.b	1
6644  0002               L34_ConfigReg_old:
6645  0002 0000          	ds.b	2
6646  0004               L14_ConfigReg:
6647  0004 0000          	ds.b	2
6648  0006               L73_StatReg3:
6649  0006 0000          	ds.b	2
6650  0008               L53_StatReg2:
6651  0008 0000          	ds.b	2
6652  000a               L33_StatReg1:
6653  000a 0000          	ds.b	2
6654  000c               L13_CtrlReg6_old:
6655  000c 0000          	ds.b	2
6656  000e               L72_CtrlReg6:
6657  000e 0000          	ds.b	2
6658  0010               L52_CtrlReg5_old:
6659  0010 0000          	ds.b	2
6660  0012               L32_CtrlReg5:
6661  0012 0000          	ds.b	2
6662  0014               L12_CtrlReg4_old:
6663  0014 0000          	ds.b	2
6664  0016               L71_CtrlReg4:
6665  0016 0000          	ds.b	2
6666  0018               L51_CtrlReg3_old:
6667  0018 0000          	ds.b	2
6668  001a               L31_CtrlReg3:
6669  001a 0000          	ds.b	2
6670  001c               L11_CtrlReg2_old:
6671  001c 0000          	ds.b	2
6672  001e               L7_CtrlReg2:
6673  001e 0000          	ds.b	2
6674  0020               L5_CtrlReg1_old:
6675  0020 0000          	ds.b	2
6676  0022               L3_CtrlReg1:
6677  0022 0000          	ds.b	2
6678                     	xdef	_L99PM62drv_SetCanPatternWakeUp
6679                     	xdef	_L99PM62drv_SetCanLoopBackMode
6680                     	xdef	_ST_SPI_Send_16
6681                     	xdef	_L99PM62drv_ClearStatusRegisters
6682                     	xdef	_L99PM62drv_WriteControl
6683                     	xdef	_L99PM62drv_GetControl
6684                     	xdef	_L99PM62drv_ReadControl
6685                     	xdef	_L99PM62drv_ReadClearStatus
6686                     	xdef	_L99PM62drv_ReadStatus
6687                     	xdef	_L99PM62drv_GetGlobalStatusRegister
6688                     	xdef	_L99PM62drv_SetCanStandbyMode
6689                     	xdef	_L99PM62drv_EnableBusWakeUp
6690                     	xdef	_L99PM62drv_SetCyclicWakeUp
6691                     	xdef	_L99PM62drv_SetWDTiming
6692                     	xdef	_L99PM62drv_SetPWMDutyCycle
6693                     	xdef	_L99PM62drv_SetPWMFrequ
6694                     	xdef	_L99PM62drv_SetVReg1CurrentMonitorMode
6695                     	xdef	_L99PM62drv_SetRelayShutdownMode
6696                     	xdef	_L99PM62drv_SetVsLockoutMode
6697                     	xdef	_L99PM62drv_LinSetup
6698                     	xdef	_L99PM62drv_SetInputFilterMode
6699                     	xdef	_L99PM62drv_SetResetThresholdLevel
6700                     	xdef	_L99PM62drv_EnableWakeupSource
6701                     	xdef	_L99PM62drv_SetWUInputMode
6702                     	xdef	_L99PM62drv_SetTimer2
6703                     	xdef	_L99PM62drv_SetTimer1
6704                     	xdef	_L99PM62drv_SetVoltageReg2Mode
6705                     	xdef	_L99PM62drv_SetRelayOutput
6706                     	xdef	_L99PM62drv_SetOutHSAutorecovery
6707                     	xdef	_L99PM62drv_SetOutHSMode
6708                     	xdef	_L99PM62drv_SetOut4Mode
6709                     	xdef	_L99PM62drv_SetOut3Mode
6710                     	xdef	_L99PM62drv_SetOut2Mode
6711                     	xdef	_L99PM62drv_SetOut1Mode
6712                     	xdef	_L99PM62drv_SetStandbyMode
6713                     	xdef	_L99PM62drv_WdgTrigger
6714                     	xdef	_L99PM62drv_Init
6715                     	xdef	_L99PM62drv_ReportError
6716                     	xref	_SPI_GetFlagStatus
6717                     	xref	_SPI_ReceiveData
6718                     	xref	_SPI_SendData
6738                     	end
