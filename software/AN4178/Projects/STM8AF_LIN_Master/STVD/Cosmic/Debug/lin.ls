   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  19                     	switch	.data
  20  0000               L3_DataToSend:
  21  0000 00            	dc.b	0
  22  0001 00            	dc.b	0
  23  0002 00            	dc.b	0
  24  0003 00            	dc.b	0
  25  0004 00            	dc.b	0
  26  0005 00            	dc.b	0
  27  0006 00            	dc.b	0
  28  0007 00            	dc.b	0
  29  0008 00            	dc.b	0
  30  0009               L5_DataBuffer:
  31  0009 00            	dc.b	0
  32  000a 000000000000  	ds.b	7
  33  0011 000000000000  	ds.b	24
  34  0029               L7_LINChecksumBuffer:
  35  0029 00            	dc.b	0
  36  002a 000000000000  	ds.b	9
  37  0033               L11_LINScheduleTableNumberOfFrame:
  38  0033 04            	dc.b	4
  39  0034               L31_ScheduleTableIndex:
  40  0034 ff            	dc.b	255
  41  0035               L51_ResponseDataByteIndex:
  42  0035 00            	dc.b	0
  43  0036               L71_ScheduleTableTick:
  44  0036 00            	dc.b	0
  45  0037               L52_DataCheck:
  46  0037 00            	dc.b	0
  47  0038               L13_ChecksumError:
  48  0038 00            	dc.b	0
  49  0039               L33_Index:
  50  0039 00            	dc.b	0
  51  003a               L53_LINTick:
  52  003a 00            	dc.b	0
  53  003b               _DataReceived:
  54  003b 00            	dc.b	0
  55  003c               _HeaderReceived:
  56  003c 00            	dc.b	0
  57  003d               _BreakReceived:
  58  003d 00            	dc.b	0
  59  003e               _IdentifierParityError:
  60  003e 00            	dc.b	0
  61  003f               _LINReceptionTimeoutValue:
  62  003f 00            	dc.b	0
  63  0040               _LINReceptionTimeout:
  64  0040 00            	dc.b	0
  65  0041               _LINSlave:
  66  0041 00            	dc.b	0
  67  0042               _UART3_SR_Buf:
  68  0042 00            	dc.b	0
  69  0043               _UART3Data:
  70  0043 00            	dc.b	0
  71  0044               _ReceptionError:
  72  0044 00            	dc.b	0
 107                     ; 152 void LIN_MasterConfig(void)
 107                     ; 153 {
 109                     	switch	.text
 110  0000               _LIN_MasterConfig:
 114                     ; 155   UART3_DeInit();
 116  0000 cd0000        	call	_UART3_DeInit
 118                     ; 158   UART3_Init((uint32_t)19200, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
 118                     ; 159              UART3_MODE_TXRX_ENABLE);
 120  0003 4b0c          	push	#12
 121  0005 4b00          	push	#0
 122  0007 4b00          	push	#0
 123  0009 4b00          	push	#0
 124  000b ae4b00        	ldw	x,#19200
 125  000e 89            	pushw	x
 126  000f 5f            	clrw	x
 127  0010 89            	pushw	x
 128  0011 cd0000        	call	_UART3_Init
 130  0014 5b08          	addw	sp,#8
 131                     ; 161   UART3_LINConfig(UART3_LIN_MODE_MASTER, UART3_LIN_AUTOSYNC_DISABLE,
 131                     ; 162                   UART3_LIN_DIVUP_LBRR1);
 133  0016 4b00          	push	#0
 134  0018 5f            	clrw	x
 135  0019 cd0000        	call	_UART3_LINConfig
 137  001c 84            	pop	a
 138                     ; 164   UART3_LINBreakDetectionConfig(UART3_LINBREAKDETECTIONLENGTH_11BITS);
 140  001d a601          	ld	a,#1
 141  001f cd0000        	call	_UART3_LINBreakDetectionConfig
 143                     ; 166   UART3_LINCmd(ENABLE); /* Enable LIN mode */
 145  0022 a601          	ld	a,#1
 146  0024 cd0000        	call	_UART3_LINCmd
 148                     ; 169   UART3_ITConfig(UART3_IT_RXNE_OR, ENABLE);
 150  0027 4b01          	push	#1
 151  0029 ae0205        	ldw	x,#517
 152  002c cd0000        	call	_UART3_ITConfig
 154  002f 84            	pop	a
 155                     ; 170   UART3_ITConfig(UART3_IT_LBDF, DISABLE);
 157  0030 4b00          	push	#0
 158  0032 ae0346        	ldw	x,#838
 159  0035 cd0000        	call	_UART3_ITConfig
 161  0038 84            	pop	a
 162                     ; 171 }
 165  0039 81            	ret	
 189                     ; 178 void InitScheduleTable(void)
 189                     ; 179 {
 190                     	switch	.text
 191  003a               _InitScheduleTable:
 195                     ; 180   LINScheduleTable[0].LINScheduleTableFrame.LINFrameIdentifier = MS0ID;
 197  003a 35c10012      	mov	_LINScheduleTable,#193
 198                     ; 181   LINScheduleTable[0].LINScheduleTableFrame.LINFrameDirection = TRANSMIT;
 200  003e 35010013      	mov	_LINScheduleTable+1,#1
 201                     ; 182   LINScheduleTable[0].LINScheduleTableFrame.LINFrameDataLength = 8;
 203  0042 35080014      	mov	_LINScheduleTable+2,#8
 204                     ; 183   LINScheduleTable[0].LINScheduleTableFrame.LINFrameBuffer[0] = 0;
 206  0046 725f0015      	clr	_LINScheduleTable+3
 207                     ; 184   LINScheduleTable[0].LINScheduleTableFrame.LINFrameBuffer[1] = 0;
 209  004a 725f0016      	clr	_LINScheduleTable+4
 210                     ; 185   LINScheduleTable[0].LINScheduleTableFrame.LINFrameBuffer[2] = 0;
 212  004e 725f0017      	clr	_LINScheduleTable+5
 213                     ; 186   LINScheduleTable[0].LINScheduleTableFrame.LINFrameBuffer[3] = 0;
 215  0052 725f0018      	clr	_LINScheduleTable+6
 216                     ; 187   LINScheduleTable[0].LINScheduleTableFrame.LINFrameBuffer[4] = 0;
 218  0056 725f0019      	clr	_LINScheduleTable+7
 219                     ; 188   LINScheduleTable[0].LINScheduleTableFrame.LINFrameBuffer[5] = 0;
 221  005a 725f001a      	clr	_LINScheduleTable+8
 222                     ; 189   LINScheduleTable[0].LINScheduleTableFrame.LINFrameBuffer[6] = 0;
 224  005e 725f001b      	clr	_LINScheduleTable+9
 225                     ; 190   LINScheduleTable[0].LINScheduleTableFrame.LINFrameBuffer[7] = 0;
 227  0062 725f001c      	clr	_LINScheduleTable+10
 228                     ; 192   LINScheduleTable[1].LINScheduleTableFrame.LINFrameIdentifier = MS2ID;
 230  0066 3503001f      	mov	_LINScheduleTable+13,#3
 231                     ; 193   LINScheduleTable[1].LINScheduleTableFrame.LINFrameDirection = RECEIVE;
 233  006a 725f0020      	clr	_LINScheduleTable+14
 234                     ; 194   LINScheduleTable[1].LINScheduleTableFrame.LINFrameDataLength = 8;
 236  006e 35080021      	mov	_LINScheduleTable+15,#8
 237                     ; 196   LINScheduleTable[2].LINScheduleTableFrame.LINFrameIdentifier = SM1ID;
 239  0072 3542002c      	mov	_LINScheduleTable+26,#66
 240                     ; 197   LINScheduleTable[2].LINScheduleTableFrame.LINFrameDirection = TRANSMIT;
 242  0076 3501002d      	mov	_LINScheduleTable+27,#1
 243                     ; 198   LINScheduleTable[2].LINScheduleTableFrame.LINFrameDataLength = 4;
 245  007a 3504002e      	mov	_LINScheduleTable+28,#4
 246                     ; 199   LINScheduleTable[2].LINScheduleTableFrame.LINFrameBuffer[0] = 0;
 248  007e 725f002f      	clr	_LINScheduleTable+29
 249                     ; 200   LINScheduleTable[2].LINScheduleTableFrame.LINFrameBuffer[1] = 0;
 251  0082 725f0030      	clr	_LINScheduleTable+30
 252                     ; 201   LINScheduleTable[2].LINScheduleTableFrame.LINFrameBuffer[2] = 0;
 254  0086 725f0031      	clr	_LINScheduleTable+31
 255                     ; 202   LINScheduleTable[2].LINScheduleTableFrame.LINFrameBuffer[3] = 0;
 257  008a 725f0032      	clr	_LINScheduleTable+32
 258                     ; 204   LINScheduleTable[3].LINScheduleTableFrame.LINFrameIdentifier = SM3ID;
 260  008e 35c40039      	mov	_LINScheduleTable+39,#196
 261                     ; 205   LINScheduleTable[3].LINScheduleTableFrame.LINFrameDirection = RECEIVE;
 263  0092 725f003a      	clr	_LINScheduleTable+40
 264                     ; 206   LINScheduleTable[3].LINScheduleTableFrame.LINFrameDataLength = 4;
 266  0096 3504003b      	mov	_LINScheduleTable+41,#4
 267                     ; 208   LINScheduleTable[0].LINScheduleTableFrameDelay = DELAY_10MS;
 269  009a 350a001e      	mov	_LINScheduleTable+12,#10
 270                     ; 209   LINScheduleTable[1].LINScheduleTableFrameDelay = DELAY_10MS;
 272  009e 350a002b      	mov	_LINScheduleTable+25,#10
 273                     ; 210   LINScheduleTable[2].LINScheduleTableFrameDelay = DELAY_10MS;
 275  00a2 350a0038      	mov	_LINScheduleTable+38,#10
 276                     ; 211   LINScheduleTable[3].LINScheduleTableFrameDelay = DELAY_20MS;
 278  00a6 35140045      	mov	_LINScheduleTable+51,#20
 279                     ; 212 }
 282  00aa 81            	ret	
 346                     ; 219 void LIN_Task(void)
 346                     ; 220 {
 347                     	switch	.text
 348  00ab               _LIN_Task:
 350  00ab 88            	push	a
 351       00000001      OFST:	set	1
 354                     ; 227     if (ErrorState) LIN_FSM = Idle;
 356  00ac c60000        	ld	a,_ErrorState
 357  00af 2704          	jreq	L141
 360  00b1 725f0046      	clr	_LIN_FSM
 361  00b5               L141:
 362                     ; 229     if (TestLINTimebaseTick())
 364  00b5 cd0351        	call	L15_TestLINTimebaseTick
 366  00b8 4d            	tnz	a
 367  00b9 2707          	jreq	L341
 368                     ; 231       ClearLINTimebaseTick();
 370  00bb cd034c        	call	L35_ClearLINTimebaseTick
 372                     ; 232       IncrementScheduleTableTick();
 374  00be 725c0036      	inc	L71_ScheduleTableTick
 376  00c2               L341:
 377                     ; 235     if (LINReceptionTimeoutElapsed())
 379  00c2 cd0334        	call	L74_LINReceptionTimeoutElapsed
 381  00c5 4d            	tnz	a
 382  00c6 2707          	jreq	L541
 383                     ; 237       StopLINReceptionTimeout();
 385  00c8 cd032b        	call	L54_StopLINReceptionTimeout
 387                     ; 238       LIN_FSM = Idle;
 389  00cb 725f0046      	clr	_LIN_FSM
 390  00cf               L541:
 391                     ; 241     switch ( (LIN_FSM_state)LIN_FSM )
 393  00cf c60046        	ld	a,_LIN_FSM
 395                     ; 395       default:
 395                     ; 396         break;
 396  00d2 271e          	jreq	L501
 397  00d4 4a            	dec	a
 398  00d5 2749          	jreq	L701
 399  00d7 4a            	dec	a
 400  00d8 2603cc015c    	jreq	L111
 401  00dd 4a            	dec	a
 402  00de 2603cc0178    	jreq	L311
 403  00e3 4a            	dec	a
 404  00e4 2603cc01ba    	jreq	L511
 405  00e9 4a            	dec	a
 406  00ea 2603cc0212    	jreq	L711
 407  00ef cc0295        	jra	L151
 408  00f2               L501:
 409                     ; 247       case Idle:
 409                     ; 248 
 409                     ; 249         if ( ScheduleTableTick >= LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrameDelay )
 411  00f2 c60034        	ld	a,L31_ScheduleTableIndex
 412  00f5 97            	ld	xl,a
 413  00f6 a60d          	ld	a,#13
 414  00f8 42            	mul	x,a
 415  00f9 d6001e        	ld	a,(_LINScheduleTable+12,x)
 416  00fc c10036        	cp	a,L71_ScheduleTableTick
 417  00ff 22ee          	jrugt	L151
 418                     ; 252           ClearScheduleTableTick();
 421  0101 725f0036      	clr	L71_ScheduleTableTick
 422                     ; 253           ResponseDataByteIndex = 0;
 425  0105 725f0035      	clr	L51_ResponseDataByteIndex
 426                     ; 254           ScheduleTableIndex++;
 428  0109 725c0034      	inc	L31_ScheduleTableIndex
 429                     ; 255           if (ScheduleTableIndex >= LINScheduleTableNumberOfFrame) ScheduleTableIndex = 0;
 431  010d c60034        	ld	a,L31_ScheduleTableIndex
 432  0110 c10033        	cp	a,L11_LINScheduleTableNumberOfFrame
 433  0113 2504          	jrult	L551
 436  0115 725f0034      	clr	L31_ScheduleTableIndex
 437  0119               L551:
 438                     ; 256           LIN_FSM = Break;
 440  0119 35010046      	mov	_LIN_FSM,#1
 442  011d cc0295        	jra	L151
 443  0120               L701:
 444                     ; 264       case Break:
 444                     ; 265 
 444                     ; 266         UART3_BDIE();
 446  0120 cd02e9        	call	_UART3_BDIE
 448                     ; 267         UART3_SendBreak();
 450  0123 cd0000        	call	_UART3_SendBreak
 452                     ; 270           for (Index = 0;Index < LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameDataLength;Index++)
 454  0126 0f01          	clr	(OFST+0,sp)
 456  0128 201d          	jra	L361
 457  012a               L751:
 458                     ; 272             LINTransmitBuffer[Index] = LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameBuffer[ScheduleTableIndex];
 460  012a 7b01          	ld	a,(OFST+0,sp)
 461  012c 5f            	clrw	x
 462  012d 97            	ld	xl,a
 463  012e 89            	pushw	x
 464  012f c60034        	ld	a,L31_ScheduleTableIndex
 465  0132 97            	ld	xl,a
 466  0133 a60d          	ld	a,#13
 467  0135 42            	mul	x,a
 468  0136 01            	rrwa	x,a
 469  0137 cb0034        	add	a,L31_ScheduleTableIndex
 470  013a 2401          	jrnc	L44
 471  013c 5c            	incw	x
 472  013d               L44:
 473  013d 02            	rlwa	x,a
 474  013e d60015        	ld	a,(_LINScheduleTable+3,x)
 475  0141 85            	popw	x
 476  0142 d70009        	ld	(L12_LINTransmitBuffer,x),a
 477                     ; 270           for (Index = 0;Index < LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameDataLength;Index++)
 479  0145 0c01          	inc	(OFST+0,sp)
 480  0147               L361:
 483  0147 c60034        	ld	a,L31_ScheduleTableIndex
 484  014a 97            	ld	xl,a
 485  014b a60d          	ld	a,#13
 486  014d 42            	mul	x,a
 487  014e d60014        	ld	a,(_LINScheduleTable+2,x)
 488  0151 1101          	cp	a,(OFST+0,sp)
 489  0153 22d5          	jrugt	L751
 490                     ; 275         LIN_FSM = SynchField;
 492  0155 35020046      	mov	_LIN_FSM,#2
 493                     ; 276         break;
 495  0159 cc0295        	jra	L151
 496  015c               L111:
 497                     ; 281       case SynchField:
 497                     ; 282 
 497                     ; 283         if (BreakReceived)
 499  015c 725d003d      	tnz	_BreakReceived
 500  0160 27f7          	jreq	L151
 501                     ; 285           BreakReceived = 0;
 503  0162 c7003d        	ld	_BreakReceived,a
 504                     ; 286           UART3_RIE();
 506  0165 cd02d6        	call	L14_UART3_RIE
 508                     ; 287           UART3_SendData8(0x55);
 510  0168 a655          	ld	a,#85
 511  016a cd0000        	call	_UART3_SendData8
 513                     ; 288           DataCheck = 0x55;
 515  016d 35550037      	mov	L52_DataCheck,#85
 516                     ; 289           LIN_FSM = Identifier;
 518  0171 35030046      	mov	_LIN_FSM,#3
 519  0175 cc0295        	jra	L151
 520  0178               L311:
 521                     ; 296       case Identifier:
 521                     ; 297 
 521                     ; 298         if (DataReceived)
 523  0178 725d003b      	tnz	_DataReceived
 524  017c 27f7          	jreq	L151
 525                     ; 300           DataReceived = 0;
 527  017e c7003b        	ld	_DataReceived,a
 528                     ; 301           if (UART3Data == DataCheck)
 530  0181 c60043        	ld	a,_UART3Data
 531  0184 c10037        	cp	a,L52_DataCheck
 532  0187 26ec          	jrne	L151
 533                     ; 303             DataCheck = LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameIdentifier;
 535  0189 c60034        	ld	a,L31_ScheduleTableIndex
 536  018c 97            	ld	xl,a
 537  018d a60d          	ld	a,#13
 538  018f 42            	mul	x,a
 539  0190 d60012        	ld	a,(_LINScheduleTable,x)
 540  0193 c70037        	ld	L52_DataCheck,a
 541                     ; 304             LINChecksumBuffer[0] = DataCheck;
 543  0196 c70029        	ld	L7_LINChecksumBuffer,a
 544                     ; 305             UART3_SendData8(DataCheck);
 546  0199 cd0000        	call	_UART3_SendData8
 548                     ; 307             if (LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameDirection == TRANSMIT)
 550  019c c60034        	ld	a,L31_ScheduleTableIndex
 551  019f 97            	ld	xl,a
 552  01a0 a60d          	ld	a,#13
 553  01a2 42            	mul	x,a
 554  01a3 d60013        	ld	a,(_LINScheduleTable+1,x)
 555  01a6 4a            	dec	a
 556  01a7 2607          	jrne	L571
 557                     ; 309               LIN_FSM = DataTransmission;
 559  01a9 35040046      	mov	_LIN_FSM,#4
 561  01ad cc0295        	jra	L151
 562  01b0               L571:
 563                     ; 313               LIN_FSM = DataReception;
 565  01b0 35050046      	mov	_LIN_FSM,#5
 566                     ; 314               StartLINReceptionTimeout();
 568  01b4 cd0322        	call	L34_StartLINReceptionTimeout
 570  01b7 cc0295        	jra	L151
 571  01ba               L511:
 572                     ; 327       case DataTransmission:
 572                     ; 328 
 572                     ; 329         if (DataReceived)
 574  01ba 725d003b      	tnz	_DataReceived
 575  01be 27f7          	jreq	L151
 576                     ; 331           DataReceived = 0;
 578  01c0 c7003b        	ld	_DataReceived,a
 579                     ; 332           if (UART3Data == DataCheck)
 581  01c3 c60043        	ld	a,_UART3Data
 582  01c6 c10037        	cp	a,L52_DataCheck
 583  01c9 26ec          	jrne	L151
 584                     ; 334             if (ResponseDataByteIndex < LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameDataLength)
 586  01cb c60034        	ld	a,L31_ScheduleTableIndex
 587  01ce 97            	ld	xl,a
 588  01cf a60d          	ld	a,#13
 589  01d1 42            	mul	x,a
 590  01d2 d60014        	ld	a,(_LINScheduleTable+2,x)
 591  01d5 c10035        	cp	a,L51_ResponseDataByteIndex
 592  01d8 231b          	jrule	L702
 593                     ; 336               DataCheck = LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameBuffer[ResponseDataByteIndex];
 595  01da 01            	rrwa	x,a
 596  01db cb0035        	add	a,L51_ResponseDataByteIndex
 597  01de 2401          	jrnc	L65
 598  01e0 5c            	incw	x
 599  01e1               L65:
 600  01e1 02            	rlwa	x,a
 601  01e2 d60015        	ld	a,(_LINScheduleTable+3,x)
 602  01e5 c70037        	ld	L52_DataCheck,a
 603                     ; 337               LINChecksumBuffer[ResponseDataByteIndex+1] = DataCheck;
 605  01e8 5f            	clrw	x
 606  01e9 c60035        	ld	a,L51_ResponseDataByteIndex
 607  01ec 97            	ld	xl,a
 608  01ed c60037        	ld	a,L52_DataCheck
 609  01f0 d7002a        	ld	(L7_LINChecksumBuffer+1,x),a
 610                     ; 338               UART3_SendData8(DataCheck);
 612                     ; 339               ResponseDataByteIndex++;
 614  01f3 2018          	jp	LC003
 615  01f5               L702:
 616                     ; 341             else if (ResponseDataByteIndex == LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameDataLength)
 618  01f5 c10035        	cp	a,L51_ResponseDataByteIndex
 619  01f8 2703cc0291    	jrne	LC001
 620                     ; 343               DataCheck = LINChecksum(LINChecksumBuffer, ResponseDataByteIndex + 1);
 622  01fd c60035        	ld	a,L51_ResponseDataByteIndex
 623  0200 4c            	inc	a
 624  0201 88            	push	a
 625  0202 ae0029        	ldw	x,#L7_LINChecksumBuffer
 626  0205 cd0297        	call	L73_LINChecksum
 628  0208 5b01          	addw	sp,#1
 629  020a c70037        	ld	L52_DataCheck,a
 630                     ; 344               UART3_SendData8(DataCheck);
 632  020d               LC003:
 634  020d cd0000        	call	_UART3_SendData8
 636                     ; 345               ResponseDataByteIndex++;
 638  0210 2031          	jp	LC002
 639                     ; 349               LIN_FSM = Idle;
 640  0212               L711:
 641                     ; 362       case DataReception:
 641                     ; 363 
 641                     ; 364         if (DataReceived)
 643  0212 725d003b      	tnz	_DataReceived
 644  0216 277d          	jreq	L151
 645                     ; 366           DataReceived = 0;
 647  0218 c7003b        	ld	_DataReceived,a
 648                     ; 368           if (ResponseDataByteIndex < LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameDataLength)
 650  021b c60034        	ld	a,L31_ScheduleTableIndex
 651  021e 97            	ld	xl,a
 652  021f a60d          	ld	a,#13
 653  0221 42            	mul	x,a
 654  0222 d60014        	ld	a,(_LINScheduleTable+2,x)
 655  0225 c10035        	cp	a,L51_ResponseDataByteIndex
 656  0228 231f          	jrule	L322
 657                     ; 370             StartLINReceptionTimeout();
 659  022a cd0322        	call	L34_StartLINReceptionTimeout
 661                     ; 371             LINReceiveBuffer[ResponseDataByteIndex] = UART3Data;
 663  022d c60035        	ld	a,L51_ResponseDataByteIndex
 664  0230 5f            	clrw	x
 665  0231 97            	ld	xl,a
 666  0232 c60043        	ld	a,_UART3Data
 667  0235 d70000        	ld	(L32_LINReceiveBuffer,x),a
 668                     ; 372             LINChecksumBuffer[ResponseDataByteIndex+1] = UART3Data;
 670  0238 5f            	clrw	x
 671  0239 c60035        	ld	a,L51_ResponseDataByteIndex
 672  023c 97            	ld	xl,a
 673  023d c60043        	ld	a,_UART3Data
 674  0240 d7002a        	ld	(L7_LINChecksumBuffer+1,x),a
 675                     ; 373             ResponseDataByteIndex++;
 677  0243               LC002:
 680  0243 725c0035      	inc	L51_ResponseDataByteIndex
 682  0247 204c          	jra	L151
 683  0249               L322:
 684                     ; 377             StopLINReceptionTimeout();
 686  0249 cd032b        	call	L54_StopLINReceptionTimeout
 688                     ; 378             if (!ErrorState) GPIO_WriteLow(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3); /* LD3 red LED OFF */
 690  024c c60000        	ld	a,_ErrorState
 691  024f 2609          	jrne	L722
 694  0251 4b08          	push	#8
 695  0253 ae5000        	ldw	x,#20480
 696  0256 cd0000        	call	_GPIO_WriteLow
 698  0259 84            	pop	a
 699  025a               L722:
 700                     ; 379             LINChecksum(LINChecksumBuffer, ResponseDataByteIndex + 1);
 702  025a c60035        	ld	a,L51_ResponseDataByteIndex
 703  025d 4c            	inc	a
 704  025e 88            	push	a
 705  025f ae0029        	ldw	x,#L7_LINChecksumBuffer
 706  0262 ad33          	call	L73_LINChecksum
 708  0264 84            	pop	a
 709                     ; 382               for (Index = 0;Index < ResponseDataByteIndex;Index++)
 711  0265 0f01          	clr	(OFST+0,sp)
 713  0267 201d          	jra	L532
 714  0269               L132:
 715                     ; 384                 LINScheduleTable[ScheduleTableIndex].LINScheduleTableFrame.LINFrameBuffer[Index] = LINReceiveBuffer[Index+1];
 717  0269 c60034        	ld	a,L31_ScheduleTableIndex
 718  026c 97            	ld	xl,a
 719  026d a60d          	ld	a,#13
 720  026f 42            	mul	x,a
 721  0270 01            	rrwa	x,a
 722  0271 1b01          	add	a,(OFST+0,sp)
 723  0273 2401          	jrnc	L67
 724  0275 5c            	incw	x
 725  0276               L67:
 726  0276 02            	rlwa	x,a
 727  0277 7b01          	ld	a,(OFST+0,sp)
 728  0279 905f          	clrw	y
 729  027b 9097          	ld	yl,a
 730  027d 90d60001      	ld	a,(L32_LINReceiveBuffer+1,y)
 731  0281 d70015        	ld	(_LINScheduleTable+3,x),a
 732                     ; 382               for (Index = 0;Index < ResponseDataByteIndex;Index++)
 734  0284 0c01          	inc	(OFST+0,sp)
 735  0286               L532:
 738  0286 7b01          	ld	a,(OFST+0,sp)
 739  0288 c10035        	cp	a,L51_ResponseDataByteIndex
 740  028b 25dc          	jrult	L132
 741                     ; 387             ResponseDataByteIndex++;
 743  028d 725c0035      	inc	L51_ResponseDataByteIndex
 744                     ; 388             LIN_FSM = Idle;
 746  0291               LC001:
 748  0291 725f0046      	clr	_LIN_FSM
 749                     ; 395       default:
 749                     ; 396         break;
 751  0295               L151:
 752                     ; 401 }
 755  0295 84            	pop	a
 756  0296 81            	ret	
 819                     ; 411 uint8_t LINChecksum (uint8_t* Checksum_Buffer, uint8_t Data_Number)
 819                     ; 412 {
 820                     	switch	.text
 821  0297               L73_LINChecksum:
 823  0297 89            	pushw	x
 824  0298 5205          	subw	sp,#5
 825       00000005      OFST:	set	5
 828                     ; 413   uint8_t i = 0;
 830                     ; 414   uint16_t Sum = 0;
 832  029a 5f            	clrw	x
 833  029b 1f04          	ldw	(OFST-1,sp),x
 834                     ; 415   uint16_t Sum1 = 0;
 836                     ; 417   for (i = 0;i < Data_Number;i++)
 838  029d 0f03          	clr	(OFST-2,sp)
 840  029f 2029          	jra	L372
 841  02a1               L762:
 842                     ; 419     Sum = Sum + *(Checksum_Buffer + i);
 844  02a1 7b06          	ld	a,(OFST+1,sp)
 845  02a3 97            	ld	xl,a
 846  02a4 7b07          	ld	a,(OFST+2,sp)
 847  02a6 1b03          	add	a,(OFST-2,sp)
 848  02a8 2401          	jrnc	L201
 849  02aa 5c            	incw	x
 850  02ab               L201:
 851  02ab 02            	rlwa	x,a
 852  02ac f6            	ld	a,(x)
 853  02ad 1b05          	add	a,(OFST+0,sp)
 854  02af 6b05          	ld	(OFST+0,sp),a
 855  02b1 2402          	jrnc	L401
 856  02b3 0c04          	inc	(OFST-1,sp)
 857  02b5               L401:
 858                     ; 421     Sum1 = Sum >> 8;
 860  02b5 1e04          	ldw	x,(OFST-1,sp)
 861  02b7 4f            	clr	a
 862  02b8 01            	rrwa	x,a
 863  02b9 1f01          	ldw	(OFST-4,sp),x
 864                     ; 422     if ( Sum1 > 0 )
 866  02bb 270b          	jreq	L772
 867                     ; 424       Sum++;
 869  02bd 1e04          	ldw	x,(OFST-1,sp)
 870  02bf 5c            	incw	x
 871  02c0 1f04          	ldw	(OFST-1,sp),x
 872                     ; 425       Sum &= ~0x0100;
 874  02c2 7b04          	ld	a,(OFST-1,sp)
 875  02c4 a4fe          	and	a,#254
 876  02c6 6b04          	ld	(OFST-1,sp),a
 877  02c8               L772:
 878                     ; 417   for (i = 0;i < Data_Number;i++)
 880  02c8 0c03          	inc	(OFST-2,sp)
 881  02ca               L372:
 884  02ca 7b03          	ld	a,(OFST-2,sp)
 885  02cc 110a          	cp	a,(OFST+5,sp)
 886  02ce 25d1          	jrult	L762
 887                     ; 429   return (uint8_t)(~Sum);
 889  02d0 7b05          	ld	a,(OFST+0,sp)
 890  02d2 43            	cpl	a
 893  02d3 5b07          	addw	sp,#7
 894  02d5 81            	ret	
 918                     ; 437 void UART3_RIE (void)
 918                     ; 438 {
 919                     	switch	.text
 920  02d6               L14_UART3_RIE:
 924                     ; 441   UART3_ITConfig(UART3_IT_LBDF, DISABLE);
 926  02d6 4b00          	push	#0
 927  02d8 ae0346        	ldw	x,#838
 928  02db cd0000        	call	_UART3_ITConfig
 930  02de 84            	pop	a
 931                     ; 442   UART3_ITConfig(UART3_IT_RXNE_OR, ENABLE);
 933  02df 4b01          	push	#1
 934  02e1 ae0205        	ldw	x,#517
 935  02e4 cd0000        	call	_UART3_ITConfig
 937  02e7 84            	pop	a
 938                     ; 443 }
 941  02e8 81            	ret	
 965                     ; 450 void UART3_BDIE (void)
 965                     ; 451 {
 966                     	switch	.text
 967  02e9               _UART3_BDIE:
 971                     ; 454   UART3_ITConfig(UART3_IT_RXNE_OR, DISABLE);
 973  02e9 4b00          	push	#0
 974  02eb ae0205        	ldw	x,#517
 975  02ee cd0000        	call	_UART3_ITConfig
 977  02f1 84            	pop	a
 978                     ; 455   UART3_ITConfig(UART3_IT_LBDF, ENABLE);
 980  02f2 4b01          	push	#1
 981  02f4 ae0346        	ldw	x,#838
 982  02f7 cd0000        	call	_UART3_ITConfig
 984  02fa 84            	pop	a
 985                     ; 457 }
 988  02fb 81            	ret	
1028                     ; 465 uint8_t LIN_ReadData(uint8_t FrameNumber, uint8_t BytePosition)
1028                     ; 466 {
1029                     	switch	.text
1030  02fc               _LIN_ReadData:
1032  02fc 89            	pushw	x
1033       00000000      OFST:	set	0
1036                     ; 467         return (LINScheduleTable[FrameNumber].LINScheduleTableFrame.LINFrameBuffer[BytePosition]);
1038  02fd 9e            	ld	a,xh
1039  02fe 97            	ld	xl,a
1040  02ff a60d          	ld	a,#13
1041  0301 42            	mul	x,a
1042  0302 01            	rrwa	x,a
1043  0303 1b02          	add	a,(OFST+2,sp)
1044  0305 2401          	jrnc	L421
1045  0307 5c            	incw	x
1046  0308               L421:
1047  0308 02            	rlwa	x,a
1048  0309 d60015        	ld	a,(_LINScheduleTable+3,x)
1051  030c 85            	popw	x
1052  030d 81            	ret	
1099                     ; 477 void LIN_WriteData(uint8_t FrameNumber, uint8_t BytePosition, uint8_t Value)
1099                     ; 478 {
1100                     	switch	.text
1101  030e               _LIN_WriteData:
1103  030e 89            	pushw	x
1104       00000000      OFST:	set	0
1107                     ; 479         LINScheduleTable[FrameNumber].LINScheduleTableFrame.LINFrameBuffer[BytePosition] = Value;
1109  030f 9e            	ld	a,xh
1110  0310 97            	ld	xl,a
1111  0311 a60d          	ld	a,#13
1112  0313 42            	mul	x,a
1113  0314 01            	rrwa	x,a
1114  0315 1b02          	add	a,(OFST+2,sp)
1115  0317 2401          	jrnc	L031
1116  0319 5c            	incw	x
1117  031a               L031:
1118  031a 02            	rlwa	x,a
1119  031b 7b05          	ld	a,(OFST+5,sp)
1120  031d d70015        	ld	(_LINScheduleTable+3,x),a
1121                     ; 480 }
1124  0320 85            	popw	x
1125  0321 81            	ret	
1151                     ; 487 void StartLINReceptionTimeout(void)
1151                     ; 488 {
1152                     	switch	.text
1153  0322               L34_StartLINReceptionTimeout:
1157                     ; 489   LINReceptionTimeout = TRUE;
1159  0322 35010040      	mov	_LINReceptionTimeout,#1
1160                     ; 490   LINReceptionTimeoutValue = 0;
1162  0326 725f003f      	clr	_LINReceptionTimeoutValue
1163                     ; 491 }
1166  032a 81            	ret	
1192                     ; 498 void StopLINReceptionTimeout(void)
1192                     ; 499 {
1193                     	switch	.text
1194  032b               L54_StopLINReceptionTimeout:
1198                     ; 500   LINReceptionTimeout = FALSE;
1200  032b 725f0040      	clr	_LINReceptionTimeout
1201                     ; 501   LINReceptionTimeoutValue = 0;
1203  032f 725f003f      	clr	_LINReceptionTimeoutValue
1204                     ; 502 }
1207  0333 81            	ret	
1255                     ; 509 bool LINReceptionTimeoutElapsed(void)
1255                     ; 510 {
1256                     	switch	.text
1257  0334               L74_LINReceptionTimeoutElapsed:
1261                     ; 512     if (LINReceptionTimeoutValue > LIN_MASTER_RECEPTION_TIMEOUT)
1263  0334 c6003f        	ld	a,_LINReceptionTimeoutValue
1264  0337 a105          	cp	a,#5
1265  0339 250a          	jrult	L714
1266                     ; 514       if (!ErrorState) LINError();
1268  033b c60000        	ld	a,_ErrorState
1269  033e 2602          	jrne	L124
1272  0340 ad17          	call	L55_LINError
1274  0342               L124:
1275                     ; 515       return(TRUE);
1277  0342 a601          	ld	a,#1
1280  0344 81            	ret	
1281  0345               L714:
1282                     ; 517     else return (FALSE);
1284  0345 4f            	clr	a
1287  0346 81            	ret	
1311                     ; 526 void SetLINTimebaseTick(void)
1311                     ; 527 {
1312                     	switch	.text
1313  0347               _SetLINTimebaseTick:
1317                     ; 528   LINTick = TRUE;
1319  0347 3501003a      	mov	L53_LINTick,#1
1320                     ; 529 }
1323  034b 81            	ret	
1348                     ; 536 void ClearLINTimebaseTick(void)
1348                     ; 537 {
1349                     	switch	.text
1350  034c               L35_ClearLINTimebaseTick:
1354                     ; 538   LINTick = FALSE;
1356  034c 725f003a      	clr	L53_LINTick
1357                     ; 539 }
1360  0350 81            	ret	
1385                     ; 546 uint8_t TestLINTimebaseTick(void)
1385                     ; 547 {
1386                     	switch	.text
1387  0351               L15_TestLINTimebaseTick:
1391                     ; 548   if (LINTick) return 1;
1393  0351 c6003a        	ld	a,L53_LINTick
1394  0354 2702          	jreq	L554
1397  0356 a601          	ld	a,#1
1400  0358               L554:
1401                     ; 549   else return 0;
1405  0358 81            	ret	
1429                     ; 557 void LINError(void)
1429                     ; 558 {
1430                     	switch	.text
1431  0359               L55_LINError:
1435                     ; 559   GPIO_WriteHigh(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3); /* LD3 red LED ON */
1437  0359 4b08          	push	#8
1438  035b ae5000        	ldw	x,#20480
1439  035e cd0000        	call	_GPIO_WriteHigh
1441  0361 84            	pop	a
1442                     ; 560 }
1445  0362 81            	ret	
1791                     	xdef	_SetLINTimebaseTick
1792                     	xdef	_LIN_WriteData
1793                     	xdef	_LIN_ReadData
1794                     	xdef	_LIN_Task
1795                     	xdef	_InitScheduleTable
1796                     	xdef	_LIN_MasterConfig
1797                     	xdef	_UART3_BDIE
1798                     	xdef	_ReceptionError
1799                     	xdef	_UART3Data
1800                     	xdef	_UART3_SR_Buf
1801                     	xdef	_LINSlave
1802                     	xdef	_LINReceptionTimeout
1803                     	xdef	_LINReceptionTimeoutValue
1804                     	xdef	_IdentifierParityError
1805                     	xdef	_BreakReceived
1806                     	xdef	_HeaderReceived
1807                     	xdef	_DataReceived
1808                     	switch	.bss
1809  0000               L32_LINReceiveBuffer:
1810  0000 000000000000  	ds.b	9
1811  0009               L12_LINTransmitBuffer:
1812  0009 000000000000  	ds.b	9
1813  0012               _LINScheduleTable:
1814  0012 000000000000  	ds.b	52
1815                     	xdef	_LINScheduleTable
1816  0046               _LIN_FSM:
1817  0046 00            	ds.b	1
1818                     	xdef	_LIN_FSM
1819                     	xref	_ErrorState
1820                     	xref	_UART3_SendBreak
1821                     	xref	_UART3_SendData8
1822                     	xref	_UART3_LINCmd
1823                     	xref	_UART3_LINConfig
1824                     	xref	_UART3_LINBreakDetectionConfig
1825                     	xref	_UART3_ITConfig
1826                     	xref	_UART3_Init
1827                     	xref	_UART3_DeInit
1828                     	xref	_GPIO_WriteLow
1829                     	xref	_GPIO_WriteHigh
1849                     	end
