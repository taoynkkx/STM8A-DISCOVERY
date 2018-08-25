   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.9.2 - 29 Jun 2010
   3                     ; Generator V4.3.5 - 02 Jul 2010
   4                     ; Optimizer V4.3.4.1 - 20 Jul 2010
  19                     	switch	.data
  20  0000               L3_TimingDelay:
  21  0000 00000000      	dc.l	0
  22  0004               L5_WdgTrigger:
  23  0004 00000000      	dc.l	0
  24  0008               L7_WdgTriggerReload:
  25  0008 00000000      	dc.l	0
  26  000c               _ReceptionEnable:
  27  000c 00            	dc.b	0
  72                     ; 75 void main(void)
  72                     ; 76 {
  74                     	switch	.text
  75  0000               _main:
  79                     ; 80   GPIO_Config();
  81  0000 ad66          	call	L12_GPIO_Config
  83                     ; 83   CLK_Config();
  85  0002 ad52          	call	L71_CLK_Config
  87                     ; 86   SPI_DeInit();
  89  0004 cd0000        	call	_SPI_DeInit
  91                     ; 87   SPI_Init(SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_64, SPI_MODE_MASTER,
  91                     ; 88            SPI_CLOCKPOLARITY_LOW, SPI_CLOCKPHASE_1EDGE,
  91                     ; 89            SPI_DATADIRECTION_2LINES_FULLDUPLEX, SPI_NSS_SOFT, (uint8_t)0x07);
  93  0007 4b07          	push	#7
  94  0009 4b02          	push	#2
  95  000b 4b00          	push	#0
  96  000d 4b00          	push	#0
  97  000f 4b00          	push	#0
  98  0011 4b04          	push	#4
  99  0013 ae0028        	ldw	x,#40
 100  0016 cd0000        	call	_SPI_Init
 102  0019 5b06          	addw	sp,#6
 103                     ; 92   TIM4_Config();
 105  001b cd00dc        	call	L11_TIM4_Config
 107                     ; 95   SPI_Cmd(ENABLE);
 109  001e a601          	ld	a,#1
 110  0020 cd0000        	call	_SPI_Cmd
 112                     ; 98   TIM4_Cmd(ENABLE);
 114  0023 a601          	ld	a,#1
 115  0025 cd0000        	call	_TIM4_Cmd
 117                     ; 101 	LIN_MasterConfig();
 119  0028 cd0000        	call	_LIN_MasterConfig
 121                     ; 102   InitScheduleTable();
 123  002b cd0000        	call	_InitScheduleTable
 125                     ; 105   enableInterrupts();
 128  002e 9a            	rim	
 130                     ; 109   Delay(40);
 133  002f ae0028        	ldw	x,#40
 134  0032 89            	pushw	x
 135  0033 5f            	clrw	x
 136  0034 89            	pushw	x
 137  0035 cd0138        	call	L31_Delay
 139  0038 5b04          	addw	sp,#4
 140                     ; 112   L99PM62drv_Init();
 142  003a cd0000        	call	_L99PM62drv_Init
 144                     ; 115   L99PM62drv_WdgAutoTrigger(L99PM62WdgTriggerRefreshValue10);
 146  003d ae000a        	ldw	x,#10
 147  0040 89            	pushw	x
 148  0041 5f            	clrw	x
 149  0042 89            	pushw	x
 150  0043 cd00ed        	call	L51_L99PM62drv_WdgAutoTrigger
 152  0046 5b04          	addw	sp,#4
 153  0048               L14:
 154                     ; 121     Appli();
 156  0048 cd0000        	call	_Appli
 158                     ; 123     if (StartupCompleted == TRUE) /* To allow leds display at startup */
 160  004b c60000        	ld	a,_StartupCompleted
 161  004e 4a            	dec	a
 162  004f 26f7          	jrne	L14
 163                     ; 125        LIN_Task();
 165  0051 cd0000        	call	_LIN_Task
 167  0054 20f2          	jra	L14
 224                     ; 136 void CLK_Config(void)
 224                     ; 137 {
 225                     	switch	.text
 226  0056               L71_CLK_Config:
 228  0056 88            	push	a
 229       00000001      OFST:	set	1
 232                     ; 138   ErrorStatus status = ERROR;
 234                     ; 141   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 236  0057 4f            	clr	a
 237  0058 cd0000        	call	_CLK_HSIPrescalerConfig
 239                     ; 144 	status = CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE,
 239                     ; 145                                    DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
 241  005b 4b00          	push	#0
 242  005d 4b00          	push	#0
 243  005f ae01b4        	ldw	x,#436
 244  0062 cd0000        	call	_CLK_ClockSwitchConfig
 246  0065 85            	popw	x
 247                     ; 147 }
 250  0066 84            	pop	a
 251  0067 81            	ret	
 276                     ; 154 void GPIO_Config(void)
 276                     ; 155 {
 277                     	switch	.text
 278  0068               L12_GPIO_Config:
 282                     ; 162   GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)(GPIO_PIN_5 | GPIO_PIN_6),
 282                     ; 163             GPIO_MODE_OUT_PP_LOW_FAST); /* MOSI + CLK */
 284  0068 4be0          	push	#224
 285  006a 4b60          	push	#96
 286  006c ae500a        	ldw	x,#20490
 287  006f cd0000        	call	_GPIO_Init
 289  0072 85            	popw	x
 290                     ; 164   GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_7,
 290                     ; 165             GPIO_MODE_IN_PU_NO_IT); /* MISO */
 292  0073 4b40          	push	#64
 293  0075 4b80          	push	#128
 294  0077 ae500a        	ldw	x,#20490
 295  007a cd0000        	call	_GPIO_Init
 297  007d 85            	popw	x
 298                     ; 166   GPIO_Init(GPIOE, (GPIO_Pin_TypeDef)(GPIO_PIN_5),
 298                     ; 167             GPIO_MODE_OUT_PP_HIGH_FAST); /* CSN */
 300  007e 4bf0          	push	#240
 301  0080 4b20          	push	#32
 302  0082 ae5014        	ldw	x,#20500
 303  0085 cd0000        	call	_GPIO_Init
 305  0088 85            	popw	x
 306                     ; 170   GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 308  0089 4be0          	push	#224
 309  008b 4b08          	push	#8
 310  008d ae5000        	ldw	x,#20480
 311  0090 cd0000        	call	_GPIO_Init
 313  0093 85            	popw	x
 314                     ; 171   GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 316  0094 4be0          	push	#224
 317  0096 4b08          	push	#8
 318  0098 ae500f        	ldw	x,#20495
 319  009b cd0000        	call	_GPIO_Init
 321  009e 85            	popw	x
 322                     ; 172   GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
 324  009f 4be0          	push	#224
 325  00a1 4b01          	push	#1
 326  00a3 ae500f        	ldw	x,#20495
 327  00a6 cd0000        	call	_GPIO_Init
 329  00a9 85            	popw	x
 330                     ; 173   GPIO_Init(GPIOE, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 332  00aa 4be0          	push	#224
 333  00ac 4b08          	push	#8
 334  00ae ae5014        	ldw	x,#20500
 335  00b1 cd0000        	call	_GPIO_Init
 337  00b4 85            	popw	x
 338                     ; 174   GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 340  00b5 4be0          	push	#224
 341  00b7 4b08          	push	#8
 342  00b9 ae500a        	ldw	x,#20490
 343  00bc cd0000        	call	_GPIO_Init
 345  00bf 85            	popw	x
 346                     ; 177   GPIO_Init( GPIOE, GPIO_PIN_2, GPIO_MODE_IN_FL_IT);
 348  00c0 4b20          	push	#32
 349  00c2 4b04          	push	#4
 350  00c4 ae5014        	ldw	x,#20500
 351  00c7 cd0000        	call	_GPIO_Init
 353  00ca 85            	popw	x
 354                     ; 180   GPIO_Init( GPIOE, GPIO_PIN_1, GPIO_MODE_IN_FL_IT);
 356  00cb 4b20          	push	#32
 357  00cd 4b02          	push	#2
 358  00cf ae5014        	ldw	x,#20500
 359  00d2 cd0000        	call	_GPIO_Init
 361  00d5 85            	popw	x
 362                     ; 183   EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOE, EXTI_SENSITIVITY_FALL_ONLY);
 364  00d6 ae0402        	ldw	x,#1026
 366                     ; 184 }
 369  00d9 cc0000        	jp	_EXTI_SetExtIntSensitivity
 395                     ; 191 static void TIM4_Config(void)
 395                     ; 192 {
 396                     	switch	.text
 397  00dc               L11_TIM4_Config:
 401                     ; 205   TIM4_TimeBaseInit(TIM4_PRESCALER_128, TIM4_PERIOD);
 403  00dc ae077c        	ldw	x,#1916
 404  00df cd0000        	call	_TIM4_TimeBaseInit
 406                     ; 208   TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 408  00e2 a601          	ld	a,#1
 409  00e4 cd0000        	call	_TIM4_ClearFlag
 411                     ; 211   TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 413  00e7 ae0101        	ldw	x,#257
 415                     ; 213 }
 418  00ea cc0000        	jp	_TIM4_ITConfig
 454                     ; 220 void L99PM62drv_WdgAutoTrigger( u32 WdgAutoTriggerValue)
 454                     ; 221 {
 455                     	switch	.text
 456  00ed               L51_L99PM62drv_WdgAutoTrigger:
 458       00000000      OFST:	set	0
 461                     ; 223   WdgTrigger = WdgAutoTriggerValue;
 463  00ed 1e05          	ldw	x,(OFST+5,sp)
 464  00ef cf0006        	ldw	L5_WdgTrigger+2,x
 465  00f2 1e03          	ldw	x,(OFST+3,sp)
 466  00f4 cf0004        	ldw	L5_WdgTrigger,x
 467                     ; 224   WdgTriggerReload = WdgAutoTriggerValue;
 469  00f7 1e05          	ldw	x,(OFST+5,sp)
 470  00f9 cf000a        	ldw	L7_WdgTriggerReload+2,x
 471  00fc 1e03          	ldw	x,(OFST+3,sp)
 472  00fe cf0008        	ldw	L7_WdgTriggerReload,x
 473                     ; 225 }
 476  0101 81            	ret	
 503                     ; 232 void WdgAutoDecrement(void)
 503                     ; 233 {
 504                     	switch	.text
 505  0102               _WdgAutoDecrement:
 509                     ; 234   if (WdgTriggerReload != 0x00)
 511  0102 ae0008        	ldw	x,#L7_WdgTriggerReload
 512  0105 cd0000        	call	c_lzmp
 514  0108 271f          	jreq	L141
 515                     ; 236     WdgTrigger--;
 517  010a ae0004        	ldw	x,#L5_WdgTrigger
 518  010d a601          	ld	a,#1
 519  010f cd0000        	call	c_lgsbc
 521                     ; 237     if (WdgTrigger == 0x00)
 523  0112 cd0000        	call	c_lzmp
 525  0115 2612          	jrne	L141
 526                     ; 239       L99PM62drv_WdgTrigger();
 528  0117 cd0000        	call	_L99PM62drv_WdgTrigger
 530                     ; 240       WdgTrigger = WdgTriggerReload;
 532  011a ce000a        	ldw	x,L7_WdgTriggerReload+2
 533  011d cf0006        	ldw	L5_WdgTrigger+2,x
 534  0120 ce0008        	ldw	x,L7_WdgTriggerReload
 535  0123 cf0004        	ldw	L5_WdgTrigger,x
 536                     ; 242       L99PM62drv_ClearStatusRegisters();
 538  0126 cd0000        	call	_L99PM62drv_ClearStatusRegisters
 540  0129               L141:
 541                     ; 245 }
 544  0129 81            	ret	
 569                     ; 252 void TimingDelay_Decrement(void)
 569                     ; 253 {
 570                     	switch	.text
 571  012a               _TimingDelay_Decrement:
 575                     ; 254   if (TimingDelay != 0x00)
 577  012a ae0000        	ldw	x,#L3_TimingDelay
 578  012d cd0000        	call	c_lzmp
 580  0130 2705          	jreq	L551
 581                     ; 256     TimingDelay--;
 583  0132 a601          	ld	a,#1
 584  0134 cd0000        	call	c_lgsbc
 586  0137               L551:
 587                     ; 258 }
 590  0137 81            	ret	
 623                     ; 265 void Delay(u32 nTime)
 623                     ; 266 {
 624                     	switch	.text
 625  0138               L31_Delay:
 627       00000000      OFST:	set	0
 630                     ; 267   TimingDelay = nTime;
 632  0138 1e05          	ldw	x,(OFST+5,sp)
 633  013a cf0002        	ldw	L3_TimingDelay+2,x
 634  013d 1e03          	ldw	x,(OFST+3,sp)
 635  013f cf0000        	ldw	L3_TimingDelay,x
 637  0142 ae0000        	ldw	x,#L3_TimingDelay
 638  0145               L771:
 639                     ; 269   while (TimingDelay != 0);
 641  0145 cd0000        	call	c_lzmp
 643  0148 26fb          	jrne	L771
 644                     ; 270 }
 647  014a 81            	ret	
 682                     ; 280 void assert_failed(uint8_t* file, uint32_t line)
 682                     ; 281 {
 683                     	switch	.text
 684  014b               _assert_failed:
 688  014b               L122:
 689  014b 20fe          	jra	L122
 757                     	xdef	_WdgAutoDecrement
 758                     	xdef	_main
 759                     	xdef	_TimingDelay_Decrement
 760                     	xdef	_ReceptionEnable
 761                     	xref	_Appli
 762                     	xref	_InitScheduleTable
 763                     	xref	_LIN_MasterConfig
 764                     	xref	_LIN_Task
 765                     	xref	_StartupCompleted
 766                     	xref	_L99PM62drv_ClearStatusRegisters
 767                     	xref	_L99PM62drv_WdgTrigger
 768                     	xref	_L99PM62drv_Init
 769                     	xdef	_assert_failed
 770                     	xref	_TIM4_ClearFlag
 771                     	xref	_TIM4_ITConfig
 772                     	xref	_TIM4_Cmd
 773                     	xref	_TIM4_TimeBaseInit
 774                     	xref	_SPI_Cmd
 775                     	xref	_SPI_Init
 776                     	xref	_SPI_DeInit
 777                     	xref	_GPIO_Init
 778                     	xref	_EXTI_SetExtIntSensitivity
 779                     	xref	_CLK_HSIPrescalerConfig
 780                     	xref	_CLK_ClockSwitchConfig
 799                     	xref	c_lgsbc
 800                     	xref	c_lzmp
 801                     	end
