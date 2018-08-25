   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  47                     ; 43 void TIM4_DeInit(void)
  47                     ; 44 {
  49                     	switch	.text
  50  0000               _TIM4_DeInit:
  54                     ; 45     TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  56  0000 725f5340      	clr	21312
  57                     ; 46     TIM4->IER = TIM4_IER_RESET_VALUE;
  59  0004 725f5341      	clr	21313
  60                     ; 47     TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  62  0008 725f5344      	clr	21316
  63                     ; 48     TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  65  000c 725f5345      	clr	21317
  66                     ; 49     TIM4->ARR = TIM4_ARR_RESET_VALUE;
  68  0010 35ff5346      	mov	21318,#255
  69                     ; 50     TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  71  0014 725f5342      	clr	21314
  72                     ; 51 }
  75  0018 81            	ret	
 180                     ; 59 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
 180                     ; 60 {
 181                     	switch	.text
 182  0019               _TIM4_TimeBaseInit:
 184  0019 89            	pushw	x
 185       00000000      OFST:	set	0
 188                     ; 62     assert_param(IS_TIM4_PRESCALER_OK(TIM4_Prescaler));
 190  001a 9e            	ld	a,xh
 191  001b 4d            	tnz	a
 192  001c 2730          	jreq	L41
 193  001e 9e            	ld	a,xh
 194  001f 4a            	dec	a
 195  0020 272c          	jreq	L41
 196  0022 9e            	ld	a,xh
 197  0023 a102          	cp	a,#2
 198  0025 2727          	jreq	L41
 199  0027 9e            	ld	a,xh
 200  0028 a103          	cp	a,#3
 201  002a 2722          	jreq	L41
 202  002c 9e            	ld	a,xh
 203  002d a104          	cp	a,#4
 204  002f 271d          	jreq	L41
 205  0031 9e            	ld	a,xh
 206  0032 a105          	cp	a,#5
 207  0034 2718          	jreq	L41
 208  0036 9e            	ld	a,xh
 209  0037 a106          	cp	a,#6
 210  0039 2713          	jreq	L41
 211  003b 9e            	ld	a,xh
 212  003c a107          	cp	a,#7
 213  003e 270e          	jreq	L41
 214  0040 ae003e        	ldw	x,#62
 215  0043 89            	pushw	x
 216  0044 5f            	clrw	x
 217  0045 89            	pushw	x
 218  0046 ae0000        	ldw	x,#L56
 219  0049 cd0000        	call	_assert_failed
 221  004c 5b04          	addw	sp,#4
 222  004e               L41:
 223                     ; 64     TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
 225  004e 7b01          	ld	a,(OFST+1,sp)
 226  0050 c75345        	ld	21317,a
 227                     ; 66     TIM4->ARR = (uint8_t)(TIM4_Period);
 229  0053 7b02          	ld	a,(OFST+2,sp)
 230  0055 c75346        	ld	21318,a
 231                     ; 67 }
 234  0058 85            	popw	x
 235  0059 81            	ret	
 291                     ; 77 void TIM4_Cmd(FunctionalState NewState)
 291                     ; 78 {
 292                     	switch	.text
 293  005a               _TIM4_Cmd:
 295  005a 88            	push	a
 296       00000000      OFST:	set	0
 299                     ; 80     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 301  005b 4d            	tnz	a
 302  005c 2711          	jreq	L62
 303  005e 4a            	dec	a
 304  005f 270e          	jreq	L62
 305  0061 ae0050        	ldw	x,#80
 306  0064 89            	pushw	x
 307  0065 5f            	clrw	x
 308  0066 89            	pushw	x
 309  0067 ae0000        	ldw	x,#L56
 310  006a cd0000        	call	_assert_failed
 312  006d 5b04          	addw	sp,#4
 313  006f               L62:
 314                     ; 83     if (NewState != DISABLE)
 316  006f 7b01          	ld	a,(OFST+1,sp)
 317  0071 2706          	jreq	L511
 318                     ; 85         TIM4->CR1 |= TIM4_CR1_CEN;
 320  0073 72105340      	bset	21312,#0
 322  0077 2004          	jra	L711
 323  0079               L511:
 324                     ; 89         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
 326  0079 72115340      	bres	21312,#0
 327  007d               L711:
 328                     ; 91 }
 331  007d 84            	pop	a
 332  007e 81            	ret	
 391                     ; 103 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 391                     ; 104 {
 392                     	switch	.text
 393  007f               _TIM4_ITConfig:
 395  007f 89            	pushw	x
 396       00000000      OFST:	set	0
 399                     ; 106     assert_param(IS_TIM4_IT_OK(TIM4_IT));
 401  0080 9e            	ld	a,xh
 402  0081 4a            	dec	a
 403  0082 270e          	jreq	L63
 404  0084 ae006a        	ldw	x,#106
 405  0087 89            	pushw	x
 406  0088 5f            	clrw	x
 407  0089 89            	pushw	x
 408  008a ae0000        	ldw	x,#L56
 409  008d cd0000        	call	_assert_failed
 411  0090 5b04          	addw	sp,#4
 412  0092               L63:
 413                     ; 107     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 415  0092 7b02          	ld	a,(OFST+2,sp)
 416  0094 2711          	jreq	L64
 417  0096 4a            	dec	a
 418  0097 270e          	jreq	L64
 419  0099 ae006b        	ldw	x,#107
 420  009c 89            	pushw	x
 421  009d 5f            	clrw	x
 422  009e 89            	pushw	x
 423  009f ae0000        	ldw	x,#L56
 424  00a2 cd0000        	call	_assert_failed
 426  00a5 5b04          	addw	sp,#4
 427  00a7               L64:
 428                     ; 109     if (NewState != DISABLE)
 430  00a7 7b02          	ld	a,(OFST+2,sp)
 431  00a9 2707          	jreq	L151
 432                     ; 112         TIM4->IER |= (uint8_t)TIM4_IT;
 434  00ab c65341        	ld	a,21313
 435  00ae 1a01          	or	a,(OFST+1,sp)
 437  00b0 2006          	jra	L351
 438  00b2               L151:
 439                     ; 117         TIM4->IER &= (uint8_t)(~TIM4_IT);
 441  00b2 7b01          	ld	a,(OFST+1,sp)
 442  00b4 43            	cpl	a
 443  00b5 c45341        	and	a,21313
 444  00b8               L351:
 445  00b8 c75341        	ld	21313,a
 446                     ; 119 }
 449  00bb 85            	popw	x
 450  00bc 81            	ret	
 487                     ; 127 void TIM4_UpdateDisableConfig(FunctionalState NewState)
 487                     ; 128 {
 488                     	switch	.text
 489  00bd               _TIM4_UpdateDisableConfig:
 491  00bd 88            	push	a
 492       00000000      OFST:	set	0
 495                     ; 130     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 497  00be 4d            	tnz	a
 498  00bf 2711          	jreq	L06
 499  00c1 4a            	dec	a
 500  00c2 270e          	jreq	L06
 501  00c4 ae0082        	ldw	x,#130
 502  00c7 89            	pushw	x
 503  00c8 5f            	clrw	x
 504  00c9 89            	pushw	x
 505  00ca ae0000        	ldw	x,#L56
 506  00cd cd0000        	call	_assert_failed
 508  00d0 5b04          	addw	sp,#4
 509  00d2               L06:
 510                     ; 133     if (NewState != DISABLE)
 512  00d2 7b01          	ld	a,(OFST+1,sp)
 513  00d4 2706          	jreq	L371
 514                     ; 135         TIM4->CR1 |= TIM4_CR1_UDIS;
 516  00d6 72125340      	bset	21312,#1
 518  00da 2004          	jra	L571
 519  00dc               L371:
 520                     ; 139         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
 522  00dc 72135340      	bres	21312,#1
 523  00e0               L571:
 524                     ; 141 }
 527  00e0 84            	pop	a
 528  00e1 81            	ret	
 587                     ; 151 void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
 587                     ; 152 {
 588                     	switch	.text
 589  00e2               _TIM4_UpdateRequestConfig:
 591  00e2 88            	push	a
 592       00000000      OFST:	set	0
 595                     ; 154     assert_param(IS_TIM4_UPDATE_SOURCE_OK(TIM4_UpdateSource));
 597  00e3 4d            	tnz	a
 598  00e4 2711          	jreq	L27
 599  00e6 4a            	dec	a
 600  00e7 270e          	jreq	L27
 601  00e9 ae009a        	ldw	x,#154
 602  00ec 89            	pushw	x
 603  00ed 5f            	clrw	x
 604  00ee 89            	pushw	x
 605  00ef ae0000        	ldw	x,#L56
 606  00f2 cd0000        	call	_assert_failed
 608  00f5 5b04          	addw	sp,#4
 609  00f7               L27:
 610                     ; 157     if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
 612  00f7 7b01          	ld	a,(OFST+1,sp)
 613  00f9 2706          	jreq	L522
 614                     ; 159         TIM4->CR1 |= TIM4_CR1_URS;
 616  00fb 72145340      	bset	21312,#2
 618  00ff 2004          	jra	L722
 619  0101               L522:
 620                     ; 163         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
 622  0101 72155340      	bres	21312,#2
 623  0105               L722:
 624                     ; 165 }
 627  0105 84            	pop	a
 628  0106 81            	ret	
 686                     ; 175 void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
 686                     ; 176 {
 687                     	switch	.text
 688  0107               _TIM4_SelectOnePulseMode:
 690  0107 88            	push	a
 691       00000000      OFST:	set	0
 694                     ; 178     assert_param(IS_TIM4_OPM_MODE_OK(TIM4_OPMode));
 696  0108 a101          	cp	a,#1
 697  010a 2711          	jreq	L401
 698  010c 4d            	tnz	a
 699  010d 270e          	jreq	L401
 700  010f ae00b2        	ldw	x,#178
 701  0112 89            	pushw	x
 702  0113 5f            	clrw	x
 703  0114 89            	pushw	x
 704  0115 ae0000        	ldw	x,#L56
 705  0118 cd0000        	call	_assert_failed
 707  011b 5b04          	addw	sp,#4
 708  011d               L401:
 709                     ; 181     if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
 711  011d 7b01          	ld	a,(OFST+1,sp)
 712  011f 2706          	jreq	L752
 713                     ; 183         TIM4->CR1 |= TIM4_CR1_OPM;
 715  0121 72165340      	bset	21312,#3
 717  0125 2004          	jra	L162
 718  0127               L752:
 719                     ; 187         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_OPM);
 721  0127 72175340      	bres	21312,#3
 722  012b               L162:
 723                     ; 190 }
 726  012b 84            	pop	a
 727  012c 81            	ret	
 796                     ; 212 void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
 796                     ; 213 {
 797                     	switch	.text
 798  012d               _TIM4_PrescalerConfig:
 800  012d 89            	pushw	x
 801       00000000      OFST:	set	0
 804                     ; 215     assert_param(IS_TIM4_PRESCALER_RELOAD_OK(TIM4_PSCReloadMode));
 806  012e 9f            	ld	a,xl
 807  012f 4d            	tnz	a
 808  0130 2712          	jreq	L611
 809  0132 9f            	ld	a,xl
 810  0133 4a            	dec	a
 811  0134 270e          	jreq	L611
 812  0136 ae00d7        	ldw	x,#215
 813  0139 89            	pushw	x
 814  013a 5f            	clrw	x
 815  013b 89            	pushw	x
 816  013c ae0000        	ldw	x,#L56
 817  013f cd0000        	call	_assert_failed
 819  0142 5b04          	addw	sp,#4
 820  0144               L611:
 821                     ; 216     assert_param(IS_TIM4_PRESCALER_OK(Prescaler));
 823  0144 7b01          	ld	a,(OFST+1,sp)
 824  0146 272c          	jreq	L621
 825  0148 a101          	cp	a,#1
 826  014a 2728          	jreq	L621
 827  014c a102          	cp	a,#2
 828  014e 2724          	jreq	L621
 829  0150 a103          	cp	a,#3
 830  0152 2720          	jreq	L621
 831  0154 a104          	cp	a,#4
 832  0156 271c          	jreq	L621
 833  0158 a105          	cp	a,#5
 834  015a 2718          	jreq	L621
 835  015c a106          	cp	a,#6
 836  015e 2714          	jreq	L621
 837  0160 a107          	cp	a,#7
 838  0162 2710          	jreq	L621
 839  0164 ae00d8        	ldw	x,#216
 840  0167 89            	pushw	x
 841  0168 5f            	clrw	x
 842  0169 89            	pushw	x
 843  016a ae0000        	ldw	x,#L56
 844  016d cd0000        	call	_assert_failed
 846  0170 5b04          	addw	sp,#4
 847  0172 7b01          	ld	a,(OFST+1,sp)
 848  0174               L621:
 849                     ; 219     TIM4->PSCR = (uint8_t)Prescaler;
 851  0174 c75345        	ld	21317,a
 852                     ; 222     TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
 854  0177 7b02          	ld	a,(OFST+2,sp)
 855  0179 c75343        	ld	21315,a
 856                     ; 223 }
 859  017c 85            	popw	x
 860  017d 81            	ret	
 897                     ; 231 void TIM4_ARRPreloadConfig(FunctionalState NewState)
 897                     ; 232 {
 898                     	switch	.text
 899  017e               _TIM4_ARRPreloadConfig:
 901  017e 88            	push	a
 902       00000000      OFST:	set	0
 905                     ; 234     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 907  017f 4d            	tnz	a
 908  0180 2711          	jreq	L041
 909  0182 4a            	dec	a
 910  0183 270e          	jreq	L041
 911  0185 ae00ea        	ldw	x,#234
 912  0188 89            	pushw	x
 913  0189 5f            	clrw	x
 914  018a 89            	pushw	x
 915  018b ae0000        	ldw	x,#L56
 916  018e cd0000        	call	_assert_failed
 918  0191 5b04          	addw	sp,#4
 919  0193               L041:
 920                     ; 237     if (NewState != DISABLE)
 922  0193 7b01          	ld	a,(OFST+1,sp)
 923  0195 2706          	jreq	L333
 924                     ; 239         TIM4->CR1 |= TIM4_CR1_ARPE;
 926  0197 721e5340      	bset	21312,#7
 928  019b 2004          	jra	L533
 929  019d               L333:
 930                     ; 243         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
 932  019d 721f5340      	bres	21312,#7
 933  01a1               L533:
 934                     ; 245 }
 937  01a1 84            	pop	a
 938  01a2 81            	ret	
 988                     ; 254 void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
 988                     ; 255 {
 989                     	switch	.text
 990  01a3               _TIM4_GenerateEvent:
 992  01a3 88            	push	a
 993       00000000      OFST:	set	0
 996                     ; 257     assert_param(IS_TIM4_EVENT_SOURCE_OK(TIM4_EventSource));
 998  01a4 4a            	dec	a
 999  01a5 270e          	jreq	L051
1000  01a7 ae0101        	ldw	x,#257
1001  01aa 89            	pushw	x
1002  01ab 5f            	clrw	x
1003  01ac 89            	pushw	x
1004  01ad ae0000        	ldw	x,#L56
1005  01b0 cd0000        	call	_assert_failed
1007  01b3 5b04          	addw	sp,#4
1008  01b5               L051:
1009                     ; 260     TIM4->EGR = (uint8_t)(TIM4_EventSource);
1011  01b5 7b01          	ld	a,(OFST+1,sp)
1012  01b7 c75343        	ld	21315,a
1013                     ; 261 }
1016  01ba 84            	pop	a
1017  01bb 81            	ret	
1049                     ; 270 void TIM4_SetCounter(uint8_t Counter)
1049                     ; 271 {
1050                     	switch	.text
1051  01bc               _TIM4_SetCounter:
1055                     ; 273     TIM4->CNTR = (uint8_t)(Counter);
1057  01bc c75344        	ld	21316,a
1058                     ; 274 }
1061  01bf 81            	ret	
1093                     ; 283 void TIM4_SetAutoreload(uint8_t Autoreload)
1093                     ; 284 {
1094                     	switch	.text
1095  01c0               _TIM4_SetAutoreload:
1099                     ; 286     TIM4->ARR = (uint8_t)(Autoreload);
1101  01c0 c75346        	ld	21318,a
1102                     ; 287 }
1105  01c3 81            	ret	
1128                     ; 294 uint8_t TIM4_GetCounter(void)
1128                     ; 295 {
1129                     	switch	.text
1130  01c4               _TIM4_GetCounter:
1134                     ; 297     return (uint8_t)(TIM4->CNTR);
1136  01c4 c65344        	ld	a,21316
1139  01c7 81            	ret	
1163                     ; 305 TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
1163                     ; 306 {
1164                     	switch	.text
1165  01c8               _TIM4_GetPrescaler:
1169                     ; 308     return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
1171  01c8 c65345        	ld	a,21317
1174  01cb 81            	ret	
1254                     ; 318 FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
1254                     ; 319 {
1255                     	switch	.text
1256  01cc               _TIM4_GetFlagStatus:
1258  01cc 88            	push	a
1259  01cd 88            	push	a
1260       00000001      OFST:	set	1
1263                     ; 320     FlagStatus bitstatus = RESET;
1265                     ; 323     assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1267  01ce 4a            	dec	a
1268  01cf 270e          	jreq	L071
1269  01d1 ae0143        	ldw	x,#323
1270  01d4 89            	pushw	x
1271  01d5 5f            	clrw	x
1272  01d6 89            	pushw	x
1273  01d7 ae0000        	ldw	x,#L56
1274  01da cd0000        	call	_assert_failed
1276  01dd 5b04          	addw	sp,#4
1277  01df               L071:
1278                     ; 325   if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
1280  01df c65342        	ld	a,21314
1281  01e2 1502          	bcp	a,(OFST+1,sp)
1282  01e4 2704          	jreq	L374
1283                     ; 327     bitstatus = SET;
1285  01e6 a601          	ld	a,#1
1287  01e8 2001          	jra	L574
1288  01ea               L374:
1289                     ; 331     bitstatus = RESET;
1291  01ea 4f            	clr	a
1292  01eb               L574:
1293                     ; 333   return ((FlagStatus)bitstatus);
1297  01eb 85            	popw	x
1298  01ec 81            	ret	
1334                     ; 343 void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
1334                     ; 344 {
1335                     	switch	.text
1336  01ed               _TIM4_ClearFlag:
1338  01ed 88            	push	a
1339       00000000      OFST:	set	0
1342                     ; 346     assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1344  01ee 4a            	dec	a
1345  01ef 270e          	jreq	L002
1346  01f1 ae015a        	ldw	x,#346
1347  01f4 89            	pushw	x
1348  01f5 5f            	clrw	x
1349  01f6 89            	pushw	x
1350  01f7 ae0000        	ldw	x,#L56
1351  01fa cd0000        	call	_assert_failed
1353  01fd 5b04          	addw	sp,#4
1354  01ff               L002:
1355                     ; 349     TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
1357  01ff 7b01          	ld	a,(OFST+1,sp)
1358  0201 43            	cpl	a
1359  0202 c75342        	ld	21314,a
1360                     ; 351 }
1363  0205 84            	pop	a
1364  0206 81            	ret	
1425                     ; 360 ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
1425                     ; 361 {
1426                     	switch	.text
1427  0207               _TIM4_GetITStatus:
1429  0207 88            	push	a
1430  0208 89            	pushw	x
1431       00000002      OFST:	set	2
1434                     ; 362     ITStatus bitstatus = RESET;
1436                     ; 364   uint8_t itstatus = 0x0, itenable = 0x0;
1440                     ; 367   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1442  0209 4a            	dec	a
1443  020a 270e          	jreq	L012
1444  020c ae016f        	ldw	x,#367
1445  020f 89            	pushw	x
1446  0210 5f            	clrw	x
1447  0211 89            	pushw	x
1448  0212 ae0000        	ldw	x,#L56
1449  0215 cd0000        	call	_assert_failed
1451  0218 5b04          	addw	sp,#4
1452  021a               L012:
1453                     ; 369   itstatus = (uint8_t)(TIM4->SR1 & (uint8_t)TIM4_IT);
1455  021a c65342        	ld	a,21314
1456  021d 1403          	and	a,(OFST+1,sp)
1457  021f 6b01          	ld	(OFST-1,sp),a
1458                     ; 371   itenable = (uint8_t)(TIM4->IER & (uint8_t)TIM4_IT);
1460  0221 c65341        	ld	a,21313
1461  0224 1403          	and	a,(OFST+1,sp)
1462  0226 6b02          	ld	(OFST+0,sp),a
1463                     ; 373   if ((itstatus != (uint8_t)RESET ) && (itenable != (uint8_t)RESET ))
1465  0228 7b01          	ld	a,(OFST-1,sp)
1466  022a 2708          	jreq	L345
1468  022c 7b02          	ld	a,(OFST+0,sp)
1469  022e 2704          	jreq	L345
1470                     ; 375     bitstatus = (ITStatus)SET;
1472  0230 a601          	ld	a,#1
1474  0232 2001          	jra	L545
1475  0234               L345:
1476                     ; 379     bitstatus = (ITStatus)RESET;
1478  0234 4f            	clr	a
1479  0235               L545:
1480                     ; 381   return ((ITStatus)bitstatus);
1484  0235 5b03          	addw	sp,#3
1485  0237 81            	ret	
1522                     ; 391 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
1522                     ; 392 {
1523                     	switch	.text
1524  0238               _TIM4_ClearITPendingBit:
1526  0238 88            	push	a
1527       00000000      OFST:	set	0
1530                     ; 394     assert_param(IS_TIM4_IT_OK(TIM4_IT));
1532  0239 4a            	dec	a
1533  023a 270e          	jreq	L022
1534  023c ae018a        	ldw	x,#394
1535  023f 89            	pushw	x
1536  0240 5f            	clrw	x
1537  0241 89            	pushw	x
1538  0242 ae0000        	ldw	x,#L56
1539  0245 cd0000        	call	_assert_failed
1541  0248 5b04          	addw	sp,#4
1542  024a               L022:
1543                     ; 397     TIM4->SR1 = (uint8_t)(~TIM4_IT);
1545  024a 7b01          	ld	a,(OFST+1,sp)
1546  024c 43            	cpl	a
1547  024d c75342        	ld	21314,a
1548                     ; 398 }
1551  0250 84            	pop	a
1552  0251 81            	ret	
1565                     	xdef	_TIM4_ClearITPendingBit
1566                     	xdef	_TIM4_GetITStatus
1567                     	xdef	_TIM4_ClearFlag
1568                     	xdef	_TIM4_GetFlagStatus
1569                     	xdef	_TIM4_GetPrescaler
1570                     	xdef	_TIM4_GetCounter
1571                     	xdef	_TIM4_SetAutoreload
1572                     	xdef	_TIM4_SetCounter
1573                     	xdef	_TIM4_GenerateEvent
1574                     	xdef	_TIM4_ARRPreloadConfig
1575                     	xdef	_TIM4_PrescalerConfig
1576                     	xdef	_TIM4_SelectOnePulseMode
1577                     	xdef	_TIM4_UpdateRequestConfig
1578                     	xdef	_TIM4_UpdateDisableConfig
1579                     	xdef	_TIM4_ITConfig
1580                     	xdef	_TIM4_Cmd
1581                     	xdef	_TIM4_TimeBaseInit
1582                     	xdef	_TIM4_DeInit
1583                     	xref	_assert_failed
1584                     .const:	section	.text
1585  0000               L56:
1586  0000 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
1587  0012 6965735c7374  	dc.b	"ies\stm8s_stdperip"
1588  0024 685f64726976  	dc.b	"h_driver\src\stm8s"
1589  0036 5f74696d342e  	dc.b	"_tim4.c",0
1609                     	end
