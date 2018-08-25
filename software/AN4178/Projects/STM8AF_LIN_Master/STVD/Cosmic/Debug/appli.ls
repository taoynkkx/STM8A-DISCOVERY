   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  19                     	switch	.data
  20  0000               L3_Data0:
  21  0000 00            	dc.b	0
  22  0001               L5_Data1:
  23  0001 00            	dc.b	0
  24  0002               L7_BarStatus:
  25  0002 00            	dc.b	0
  26  0003               L11_AppliTimebaseTick:
  27  0003 00            	dc.b	0
  28  0004               _StartupDisplay:
  29  0004 00            	dc.b	0
  30  0005               _StartupCompleted:
  31  0005 00            	dc.b	0
  76                     ; 125 void Appli(void)
  76                     ; 126 {
  78                     	switch	.text
  79  0000               _Appli:
  83                     ; 128   if (TestAppliTimebaseTick())
  85  0000 cd0199        	call	L72_TestAppliTimebaseTick
  87  0003 4d            	tnz	a
  88  0004 2603cc00e6    	jreq	L15
  89                     ; 130     ClearAppliTimebaseTick();
  91  0009 cd0194        	call	L52_ClearAppliTimebaseTick
  93                     ; 134     if (StartupDisplay < 23)
  96  000c c60004        	ld	a,_StartupDisplay
  97  000f a117          	cp	a,#23
  98  0011 240c          	jruge	L35
  99                     ; 136       StartupDisplay++;
 101  0013 725c0004      	inc	_StartupDisplay
 102                     ; 139       LED_Display(StartupDisplay >> 2);
 104  0017 c60004        	ld	a,_StartupDisplay
 105  001a 44            	srl	a
 106  001b 44            	srl	a
 110  001c cc01a1        	jp	L13_LED_Display
 111  001f               L35:
 112                     ; 143       StartupCompleted = TRUE;
 114  001f 35010005      	mov	_StartupCompleted,#1
 115                     ; 146 			WRITE_MASTER_RV1_TRIMMER_LSB(Data0);
 117  0023 ae0203        	ldw	x,#515
 118  0026 3b0000        	push	L3_Data0
 119  0029 cd0000        	call	_LIN_WriteData
 121  002c 84            	pop	a
 122                     ; 147 			WRITE_MASTER_RV1_TRIMMER_MSB(Data1);
 124  002d 3b0001        	push	L5_Data1
 125  0030 ae0202        	ldw	x,#514
 126  0033 cd0000        	call	_LIN_WriteData
 128  0036 84            	pop	a
 129                     ; 150 			if (UserButton1Status())
 131  0037 cd00e7        	call	L31_UserButton1Status
 133  003a 4d            	tnz	a
 134  003b 270e          	jreq	L75
 135                     ; 152 				WRITE_MASTER_USER1_BUTTON(TRUE);
 137  003d 4b01          	push	#1
 138  003f ae0200        	ldw	x,#512
 139  0042 cd0000        	call	_LIN_WriteData
 141  0045 84            	pop	a
 142                     ; 153 				IncrementStatus();
 144  0046 cd0101        	call	L71_IncrementStatus
 147  0049 2009          	jra	L16
 148  004b               L75:
 149                     ; 157 				WRITE_MASTER_USER1_BUTTON(FALSE);
 151  004b 4b00          	push	#0
 152  004d ae0200        	ldw	x,#512
 153  0050 cd0000        	call	_LIN_WriteData
 155  0053 84            	pop	a
 156  0054               L16:
 157                     ; 161 			if (UserButton2Status())
 159  0054 cd00f4        	call	L51_UserButton2Status
 161  0057 4d            	tnz	a
 162  0058 270e          	jreq	L36
 163                     ; 163 				WRITE_MASTER_USER2_BUTTON(TRUE);
 165  005a 4b01          	push	#1
 166  005c ae0201        	ldw	x,#513
 167  005f cd0000        	call	_LIN_WriteData
 169  0062 84            	pop	a
 170                     ; 164 				DecrementStatus();
 172  0063 cd010f        	call	L12_DecrementStatus
 175  0066 2009          	jra	L56
 176  0068               L36:
 177                     ; 168 				WRITE_MASTER_USER2_BUTTON(FALSE);
 179  0068 4b00          	push	#0
 180  006a ae0201        	ldw	x,#513
 181  006d cd0000        	call	_LIN_WriteData
 183  0070 84            	pop	a
 184  0071               L56:
 185                     ; 170 			if (!ErrorState)
 187  0071 c60000        	ld	a,_ErrorState
 188  0074 2670          	jrne	L15
 189                     ; 173 				if (READ_MASTER_LD4_GREEN_LED) LD4_GREEN_LED_ON;
 191  0076 ae0100        	ldw	x,#256
 192  0079 cd0000        	call	_LIN_ReadData
 194  007c 4d            	tnz	a
 195  007d 270a          	jreq	L17
 198  007f 4b08          	push	#8
 199  0081 ae500f        	ldw	x,#20495
 200  0084 cd0000        	call	_GPIO_WriteHigh
 203  0087 2008          	jra	L37
 204  0089               L17:
 205                     ; 174 				else LD4_GREEN_LED_OFF;
 207  0089 4b08          	push	#8
 208  008b ae500f        	ldw	x,#20495
 209  008e cd0000        	call	_GPIO_WriteLow
 211  0091               L37:
 212  0091 ae0101        	ldw	x,#257
 213  0094 84            	pop	a
 214                     ; 175 				if (READ_MASTER_LD5_GREEN_LED) LD5_GREEN_LED_ON;
 216  0095 cd0000        	call	_LIN_ReadData
 218  0098 4d            	tnz	a
 219  0099 270a          	jreq	L57
 222  009b 4b01          	push	#1
 223  009d ae500f        	ldw	x,#20495
 224  00a0 cd0000        	call	_GPIO_WriteHigh
 227  00a3 2008          	jra	L77
 228  00a5               L57:
 229                     ; 176 				else LD5_GREEN_LED_OFF;
 231  00a5 4b01          	push	#1
 232  00a7 ae500f        	ldw	x,#20495
 233  00aa cd0000        	call	_GPIO_WriteLow
 235  00ad               L77:
 236  00ad ae0102        	ldw	x,#258
 237  00b0 84            	pop	a
 238                     ; 177 				if (READ_MASTER_LD6_GREEN_LED) LD6_GREEN_LED_ON;
 240  00b1 cd0000        	call	_LIN_ReadData
 242  00b4 4d            	tnz	a
 243  00b5 270a          	jreq	L101
 246  00b7 4b08          	push	#8
 247  00b9 ae5014        	ldw	x,#20500
 248  00bc cd0000        	call	_GPIO_WriteHigh
 251  00bf 2008          	jra	L301
 252  00c1               L101:
 253                     ; 178 				else LD6_GREEN_LED_OFF;
 255  00c1 4b08          	push	#8
 256  00c3 ae5014        	ldw	x,#20500
 257  00c6 cd0000        	call	_GPIO_WriteLow
 259  00c9               L301:
 260  00c9 ae0103        	ldw	x,#259
 261  00cc 84            	pop	a
 262                     ; 179 				if (READ_MASTER_LD7_GREEN_LED) LD7_GREEN_LED_ON;
 264  00cd cd0000        	call	_LIN_ReadData
 266  00d0 4d            	tnz	a
 267  00d1 270a          	jreq	L501
 270  00d3 4b08          	push	#8
 271  00d5 ae500a        	ldw	x,#20490
 272  00d8 cd0000        	call	_GPIO_WriteHigh
 275  00db 2008          	jp	LC001
 276  00dd               L501:
 277                     ; 180 				else LD7_GREEN_LED_OFF;
 279  00dd 4b08          	push	#8
 280  00df ae500a        	ldw	x,#20490
 281  00e2 cd0000        	call	_GPIO_WriteLow
 283  00e5               LC001:
 284  00e5 84            	pop	a
 285  00e6               L15:
 286                     ; 187 }
 289  00e6 81            	ret	
 334                     ; 194 bool UserButton1Status(void)
 334                     ; 195 {
 335                     	switch	.text
 336  00e7               L31_UserButton1Status:
 340                     ; 197   if (UserButton1 == TRUE)
 342  00e7 c60001        	ld	a,_UserButton1
 343  00ea 4a            	dec	a
 344  00eb 2605          	jrne	L131
 345                     ; 199     UserButton1 = FALSE;
 347  00ed c70001        	ld	_UserButton1,a
 348                     ; 200     return(TRUE);
 350  00f0 4c            	inc	a
 353  00f1 81            	ret	
 354  00f2               L131:
 355                     ; 204     return(FALSE);
 357  00f2 4f            	clr	a
 360  00f3 81            	ret	
 385                     ; 213 bool UserButton2Status(void)
 385                     ; 214 {
 386                     	switch	.text
 387  00f4               L51_UserButton2Status:
 391                     ; 216   if (UserButton2 == TRUE)
 393  00f4 c60000        	ld	a,_UserButton2
 394  00f7 4a            	dec	a
 395  00f8 2605          	jrne	L541
 396                     ; 218     UserButton2 = FALSE;
 398  00fa c70000        	ld	_UserButton2,a
 399                     ; 219     return(TRUE);
 401  00fd 4c            	inc	a
 404  00fe 81            	ret	
 405  00ff               L541:
 406                     ; 223     return(FALSE);
 408  00ff 4f            	clr	a
 411  0100 81            	ret	
 436                     ; 233 void IncrementStatus(void)
 436                     ; 234 {
 437                     	switch	.text
 438  0101               L71_IncrementStatus:
 442                     ; 235   if (BarStatus < 4)
 444  0101 c60002        	ld	a,L7_BarStatus
 445  0104 a104          	cp	a,#4
 446  0106 2406          	jruge	L161
 447                     ; 237     BarStatus++;
 449  0108 725c0002      	inc	L7_BarStatus
 450                     ; 238 		UpdateBarStatus(); /* LIN Master demo  */
 452  010c ad0d          	call	L32_UpdateBarStatus
 454  010e               L161:
 455                     ; 240 }
 458  010e 81            	ret	
 483                     ; 247 void DecrementStatus(void)
 483                     ; 248 {
 484                     	switch	.text
 485  010f               L12_DecrementStatus:
 489                     ; 249   if (BarStatus > 0)
 491  010f c60002        	ld	a,L7_BarStatus
 492  0112 2706          	jreq	L371
 493                     ; 251     BarStatus--;
 495  0114 725a0002      	dec	L7_BarStatus
 496                     ; 252     UpdateBarStatus(); /* LIN Master demo */
 498  0118 ad01          	call	L32_UpdateBarStatus
 500  011a               L371:
 501                     ; 254 }
 504  011a 81            	ret	
 529                     ; 262 void UpdateBarStatus(void)
 529                     ; 263 {
 530                     	switch	.text
 531  011b               L32_UpdateBarStatus:
 535                     ; 267     switch (BarStatus)
 537  011b c60002        	ld	a,L7_BarStatus
 539                     ; 309         break;
 540  011e 270c          	jreq	L571
 541  0120 4a            	dec	a
 542  0121 270d          	jreq	L771
 543  0123 4a            	dec	a
 544  0124 271e          	jreq	L102
 545  0126 4a            	dec	a
 546  0127 2726          	jreq	L302
 547  0129 4a            	dec	a
 548  012a 2740          	jreq	L502
 549                     ; 304       default:
 549                     ; 305         WRITE_STM8AL_BAR0(0);
 551                     ; 306         WRITE_STM8AL_BAR1(0);
 553                     ; 307         WRITE_STM8AL_BAR2(0);
 555                     ; 308         WRITE_STM8AL_BAR3(0);
 557                     ; 309         break;
 559  012c               L571:
 560                     ; 269       case 0:
 560                     ; 270         WRITE_STM8AL_BAR0(0);
 563  012c 4b00          	push	#0
 565                     ; 271         WRITE_STM8AL_BAR1(0);
 567                     ; 272         WRITE_STM8AL_BAR2(0);
 569                     ; 273         WRITE_STM8AL_BAR3(0);
 571                     ; 274         break;
 573  012e 2002          	jp	LC004
 574  0130               L771:
 575                     ; 276       case 1:
 575                     ; 277         WRITE_STM8AL_BAR0(1);
 577  0130 4b01          	push	#1
 579                     ; 278         WRITE_STM8AL_BAR1(0);
 581  0132               LC004:
 582  0132 5f            	clrw	x
 583  0133 cd0000        	call	_LIN_WriteData
 584  0136 84            	pop	a
 587  0137 4b00          	push	#0
 589                     ; 279         WRITE_STM8AL_BAR2(0);
 591  0139               LC003:
 592  0139 ae0001        	ldw	x,#1
 593  013c cd0000        	call	_LIN_WriteData
 594  013f 84            	pop	a
 598  0140 4b00          	push	#0
 600                     ; 280         WRITE_STM8AL_BAR3(0);
 602                     ; 281         break;
 604  0142 201d          	jp	LC002
 605  0144               L102:
 606                     ; 283       case 2:
 606                     ; 284         WRITE_STM8AL_BAR0(1);
 608  0144 4b01          	push	#1
 609  0146 5f            	clrw	x
 610  0147 cd0000        	call	_LIN_WriteData
 612  014a 84            	pop	a
 613                     ; 285         WRITE_STM8AL_BAR1(1);
 615  014b 4b01          	push	#1
 617                     ; 286         WRITE_STM8AL_BAR2(0);
 619                     ; 287         WRITE_STM8AL_BAR3(0);
 621                     ; 288         break;
 623  014d 20ea          	jp	LC003
 624  014f               L302:
 625                     ; 290       case 3:
 625                     ; 291         WRITE_STM8AL_BAR0(1);
 627  014f 4b01          	push	#1
 628  0151 5f            	clrw	x
 629  0152 cd0000        	call	_LIN_WriteData
 631  0155 84            	pop	a
 632                     ; 292         WRITE_STM8AL_BAR1(1);
 634  0156 4b01          	push	#1
 635  0158 ae0001        	ldw	x,#1
 636  015b cd0000        	call	_LIN_WriteData
 638  015e 84            	pop	a
 639                     ; 293         WRITE_STM8AL_BAR2(1);
 641  015f 4b01          	push	#1
 643                     ; 294         WRITE_STM8AL_BAR3(0);
 645  0161               LC002:
 646  0161 ae0002        	ldw	x,#2
 647  0164 cd0000        	call	_LIN_WriteData
 648  0167 84            	pop	a
 653  0168 4b00          	push	#0
 655                     ; 295         break;
 657  016a 201b          	jra	L322
 658  016c               L502:
 659                     ; 297       case 4:
 659                     ; 298         WRITE_STM8AL_BAR0(1);
 661  016c 4b01          	push	#1
 662  016e 5f            	clrw	x
 663  016f cd0000        	call	_LIN_WriteData
 665  0172 84            	pop	a
 666                     ; 299         WRITE_STM8AL_BAR1(1);
 668  0173 4b01          	push	#1
 669  0175 ae0001        	ldw	x,#1
 670  0178 cd0000        	call	_LIN_WriteData
 672  017b 84            	pop	a
 673                     ; 300         WRITE_STM8AL_BAR2(1);
 675  017c 4b01          	push	#1
 676  017e ae0002        	ldw	x,#2
 677  0181 cd0000        	call	_LIN_WriteData
 679  0184 84            	pop	a
 680                     ; 301         WRITE_STM8AL_BAR3(1);
 682  0185 4b01          	push	#1
 684                     ; 302         break;
 686  0187               L322:
 687  0187 ae0003        	ldw	x,#3
 688  018a cd0000        	call	_LIN_WriteData
 689  018d 84            	pop	a
 690                     ; 312 }
 693  018e 81            	ret	
 718                     ; 319 void SetAppliTimebaseTick(void)
 718                     ; 320 {
 719                     	switch	.text
 720  018f               _SetAppliTimebaseTick:
 724                     ; 321   AppliTimebaseTick = TRUE;
 726  018f 35010003      	mov	L11_AppliTimebaseTick,#1
 727                     ; 322 }
 730  0193 81            	ret	
 755                     ; 329 void ClearAppliTimebaseTick(void)
 755                     ; 330 {
 756                     	switch	.text
 757  0194               L52_ClearAppliTimebaseTick:
 761                     ; 331   AppliTimebaseTick = FALSE;
 763  0194 725f0003      	clr	L11_AppliTimebaseTick
 764                     ; 332 }
 767  0198 81            	ret	
 793                     ; 339 bool TestAppliTimebaseTick(void)
 793                     ; 340 {
 794                     	switch	.text
 795  0199               L72_TestAppliTimebaseTick:
 799                     ; 341   if (AppliTimebaseTick) return TRUE;
 801  0199 c60003        	ld	a,L11_AppliTimebaseTick
 802  019c 2702          	jreq	L552
 805  019e a601          	ld	a,#1
 808  01a0               L552:
 809                     ; 342   else return FALSE;
 813  01a0 81            	ret	
 847                     ; 350 void LED_Display(uint8_t Ledstatus)
 847                     ; 351 {
 848                     	switch	.text
 849  01a1               L13_LED_Display:
 853                     ; 352   switch ((uint8_t)Ledstatus)
 856                     ; 432       break;
 857  01a1 4d            	tnz	a
 858  01a2 2727          	jreq	L162
 859  01a4 4a            	dec	a
 860  01a5 272e          	jreq	L362
 861  01a7 4a            	dec	a
 862  01a8 2750          	jreq	L562
 863  01aa 4a            	dec	a
 864  01ab 2760          	jreq	L762
 865  01ad 4a            	dec	a
 866  01ae 2779          	jreq	L172
 867  01b0 4a            	dec	a
 868  01b1 2603cc0258    	jreq	L372
 869  01b6 4a            	dec	a
 870  01b7 2603cc027d    	jreq	L572
 871  01bc 4a            	dec	a
 872  01bd 2603cc0290    	jreq	L772
 873  01c2 4a            	dec	a
 874  01c3 2603cc02ac    	jreq	L103
 875                     ; 426     default:
 875                     ; 427       LD3_RED_LED_OFF;
 877                     ; 428       LD4_GREEN_LED_OFF;
 879                     ; 429       LD5_GREEN_LED_OFF;
 881                     ; 430       LD6_GREEN_LED_OFF;
 883                     ; 431       LD7_GREEN_LED_ON;
 885                     ; 432       break;
 887  01c8 cc0258        	jp	L372
 888  01cb               L162:
 889                     ; 354     case 0:
 889                     ; 355       LD3_RED_LED_OFF;
 891  01cb 4b08          	push	#8
 892  01cd ae5000        	ldw	x,#20480
 893  01d0 cd0000        	call	_GPIO_WriteLow
 895                     ; 356       LD4_GREEN_LED_OFF;
 897                     ; 357       LD5_GREEN_LED_OFF;
 899                     ; 358       LD6_GREEN_LED_OFF;
 901                     ; 359       LD7_GREEN_LED_OFF;
 903                     ; 360       break;
 905  01d3 2008          	jp	LC012
 906  01d5               L362:
 907                     ; 362     case 1:
 907                     ; 363       LD3_RED_LED_ON;
 909  01d5 4b08          	push	#8
 910  01d7 ae5000        	ldw	x,#20480
 911  01da cd0000        	call	_GPIO_WriteHigh
 913                     ; 364       LD4_GREEN_LED_OFF;
 915  01dd               LC012:
 916  01dd 84            	pop	a
 918  01de 4b08          	push	#8
 919  01e0 ae500f        	ldw	x,#20495
 920  01e3 cd0000        	call	_GPIO_WriteLow
 922                     ; 365       LD5_GREEN_LED_OFF;
 924  01e6               LC011:
 925  01e6 84            	pop	a
 928  01e7 4b01          	push	#1
 929  01e9 ae500f        	ldw	x,#20495
 930  01ec cd0000        	call	_GPIO_WriteLow
 932                     ; 366       LD6_GREEN_LED_OFF;
 934  01ef               LC010:
 935  01ef 84            	pop	a
 940  01f0 4b08          	push	#8
 941  01f2 ae5014        	ldw	x,#20500
 942  01f5 cd0000        	call	_GPIO_WriteLow
 944                     ; 367       LD7_GREEN_LED_OFF;
 946                     ; 368       break;
 948  01f8 2052          	jp	LC009
 949  01fa               L562:
 950                     ; 370     case 2:
 950                     ; 371       LD3_RED_LED_OFF;
 952  01fa 4b08          	push	#8
 953  01fc ae5000        	ldw	x,#20480
 954  01ff cd0000        	call	_GPIO_WriteLow
 956  0202 84            	pop	a
 957                     ; 372       LD4_GREEN_LED_ON;
 959  0203 4b08          	push	#8
 960  0205 ae500f        	ldw	x,#20495
 961  0208 cd0000        	call	_GPIO_WriteHigh
 963                     ; 373       LD5_GREEN_LED_OFF;
 965                     ; 374       LD6_GREEN_LED_OFF;
 967                     ; 375       LD7_GREEN_LED_OFF;
 969                     ; 376       break;
 971  020b 20d9          	jp	LC011
 972  020d               L762:
 973                     ; 378     case 3:
 973                     ; 379       LD3_RED_LED_OFF;
 975  020d 4b08          	push	#8
 976  020f ae5000        	ldw	x,#20480
 977  0212 cd0000        	call	_GPIO_WriteLow
 979  0215 84            	pop	a
 980                     ; 380       LD4_GREEN_LED_OFF;
 982  0216 4b08          	push	#8
 983  0218 ae500f        	ldw	x,#20495
 984  021b cd0000        	call	_GPIO_WriteLow
 986                     ; 381       LD5_GREEN_LED_ON;
 988  021e               LC013:
 989  021e 84            	pop	a
 991  021f 4b01          	push	#1
 992  0221 ae500f        	ldw	x,#20495
 993  0224 cd0000        	call	_GPIO_WriteHigh
 995                     ; 382       LD6_GREEN_LED_OFF;
 997                     ; 383       LD7_GREEN_LED_OFF;
 999                     ; 384       break;
1001  0227 20c6          	jp	LC010
1002  0229               L172:
1003                     ; 386     case 4:
1003                     ; 387       LD3_RED_LED_OFF;
1005  0229 4b08          	push	#8
1006  022b ae5000        	ldw	x,#20480
1007  022e cd0000        	call	_GPIO_WriteLow
1009  0231 84            	pop	a
1010                     ; 388       LD4_GREEN_LED_OFF;
1012  0232 4b08          	push	#8
1013  0234 ae500f        	ldw	x,#20495
1014  0237 cd0000        	call	_GPIO_WriteLow
1016  023a 84            	pop	a
1017                     ; 389       LD5_GREEN_LED_OFF;
1019  023b 4b01          	push	#1
1020  023d ae500f        	ldw	x,#20495
1021  0240 cd0000        	call	_GPIO_WriteLow
1023  0243 84            	pop	a
1024                     ; 390       LD6_GREEN_LED_ON;
1026  0244 4b08          	push	#8
1027  0246 ae5014        	ldw	x,#20500
1028  0249 cd0000        	call	_GPIO_WriteHigh
1030                     ; 391       LD7_GREEN_LED_OFF;
1032  024c               LC009:
1033  024c 84            	pop	a
1039  024d 4b08          	push	#8
1040  024f ae500a        	ldw	x,#20490
1041  0252 cd0000        	call	_GPIO_WriteLow
1043                     ; 392       break;
1045  0255 cc02d8        	jra	L323
1046  0258               L372:
1047                     ; 394     case 5:
1047                     ; 395       LD3_RED_LED_OFF;
1050                     ; 396       LD4_GREEN_LED_OFF;
1053                     ; 397       LD5_GREEN_LED_OFF;
1056  0258 4b08          	push	#8
1057  025a ae5000        	ldw	x,#20480
1058  025d cd0000        	call	_GPIO_WriteLow
1059  0260 84            	pop	a
1061  0261 4b08          	push	#8
1062  0263 ae500f        	ldw	x,#20495
1063  0266 cd0000        	call	_GPIO_WriteLow
1064  0269 84            	pop	a
1066  026a 4b01          	push	#1
1067  026c ae500f        	ldw	x,#20495
1068  026f cd0000        	call	_GPIO_WriteLow
1070                     ; 398       LD6_GREEN_LED_OFF;
1072  0272               LC007:
1073  0272 84            	pop	a
1076  0273 4b08          	push	#8
1077  0275 ae5014        	ldw	x,#20500
1078  0278 cd0000        	call	_GPIO_WriteLow
1080                     ; 399       LD7_GREEN_LED_ON;
1082                     ; 400       break;
1084  027b 2052          	jp	LC006
1085  027d               L572:
1086                     ; 402     case 6:
1086                     ; 403       LD3_RED_LED_OFF;
1088  027d 4b08          	push	#8
1089  027f ae5000        	ldw	x,#20480
1090  0282 cd0000        	call	_GPIO_WriteLow
1092  0285 84            	pop	a
1093                     ; 404       LD4_GREEN_LED_ON;
1095  0286 4b08          	push	#8
1096  0288 ae500f        	ldw	x,#20495
1097  028b cd0000        	call	_GPIO_WriteHigh
1099                     ; 405       LD5_GREEN_LED_ON;
1101                     ; 406       LD6_GREEN_LED_OFF;
1103                     ; 407       LD7_GREEN_LED_OFF;
1105                     ; 408       break;
1107  028e 208e          	jp	LC013
1108  0290               L772:
1109                     ; 410     case 7:
1109                     ; 411       LD3_RED_LED_OFF;
1111  0290 4b08          	push	#8
1112  0292 ae5000        	ldw	x,#20480
1113  0295 cd0000        	call	_GPIO_WriteLow
1115  0298 84            	pop	a
1116                     ; 412       LD4_GREEN_LED_OFF;
1118  0299 4b08          	push	#8
1119  029b ae500f        	ldw	x,#20495
1120  029e cd0000        	call	_GPIO_WriteLow
1122  02a1 84            	pop	a
1123                     ; 413       LD5_GREEN_LED_ON;
1125  02a2 4b01          	push	#1
1126  02a4 ae500f        	ldw	x,#20495
1127  02a7 cd0000        	call	_GPIO_WriteHigh
1129                     ; 414       LD6_GREEN_LED_OFF;
1131                     ; 415       LD7_GREEN_LED_ON;
1133                     ; 416       break;
1135  02aa 20c6          	jp	LC007
1136  02ac               L103:
1137                     ; 418     case 8:
1137                     ; 419       LD3_RED_LED_OFF;
1139  02ac 4b08          	push	#8
1140  02ae ae5000        	ldw	x,#20480
1141  02b1 cd0000        	call	_GPIO_WriteLow
1143  02b4 84            	pop	a
1144                     ; 420       LD4_GREEN_LED_ON;
1146  02b5 4b08          	push	#8
1147  02b7 ae500f        	ldw	x,#20495
1148  02ba cd0000        	call	_GPIO_WriteHigh
1150  02bd 84            	pop	a
1151                     ; 421       LD5_GREEN_LED_ON;
1153  02be 4b01          	push	#1
1154  02c0 ae500f        	ldw	x,#20495
1155  02c3 cd0000        	call	_GPIO_WriteHigh
1157  02c6 84            	pop	a
1158                     ; 422       LD6_GREEN_LED_ON;
1160  02c7 4b08          	push	#8
1161  02c9 ae5014        	ldw	x,#20500
1162  02cc cd0000        	call	_GPIO_WriteHigh
1164                     ; 423       LD7_GREEN_LED_ON;
1166  02cf               LC006:
1167  02cf 84            	pop	a
1171  02d0 4b08          	push	#8
1172  02d2 ae500a        	ldw	x,#20490
1173  02d5 cd0000        	call	_GPIO_WriteHigh
1175                     ; 424       break;
1177  02d8               L323:
1178  02d8 84            	pop	a
1179                     ; 434 }
1182  02d9 81            	ret	
1265                     	xdef	_Appli
1266                     	xdef	_SetAppliTimebaseTick
1267                     	xdef	_StartupCompleted
1268                     	xdef	_StartupDisplay
1269                     	switch	.bss
1270  0000               _UserButton2:
1271  0000 00            	ds.b	1
1272                     	xdef	_UserButton2
1273  0001               _UserButton1:
1274  0001 00            	ds.b	1
1275                     	xdef	_UserButton1
1276                     	xref	_LIN_WriteData
1277                     	xref	_LIN_ReadData
1278                     	xref	_ErrorState
1279                     	xref	_GPIO_WriteLow
1280                     	xref	_GPIO_WriteHigh
1300                     	end
