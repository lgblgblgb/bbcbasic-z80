; z80dasm 1.1.5
; command line: z80dasm -a -l -z -t patch_old.bin


	GLOBAL  CLRSCN
	GLOBAL  PUTCSR
	GLOBAL  GETCSR
	GLOBAL  PUTIME
	GLOBAL  GETIME
	GLOBAL  GETKEY
	GLOBAL  BYE
;
        ASEG
        ORG     100H

	jp INIT		;0100	c3 34 01 	. 4 . 
CLRSCN:	jp CLS		;0103	c3 7b 01 	. { . 
PUTCSR:	jp PCSR		;0106	c3 a5 01 	. . . 
GETCSR:	jp GCSR		;0109	c3 ca 01 	. . . 
PUTIME:	jp PTIME	;010c	c3 7a 01 	. z . 
GETIME:	jp GTIME	;010f	c3 73 01 	. s . 
GETKEY:	jp INKEY	;0112	c3 85 01 	. . . 
BYE:	jp REBOOT	;0115	c3 72 01 	. r . 


CALL_BDOS:
	push ix			;0118	dd e5 	. . 
	push iy			;011a	fd e5 	. . 
	exx			;011c	d9 	. 
	push bc			;011d	c5 	. 
	push de			;011e	d5 	. 
	push hl			;011f	e5 	. 
	exx			;0120	d9 	. 
	ex af,af'		;0121	08 	. 
	push af			;0122	f5 	. 
	ex af,af'		;0123	08 	. 
	call 00005h		;0124	cd 05 00 	. . . 
	ex af,af'		;0127	08 	. 
	pop af			;0128	f1 	. 
	ex af,af'		;0129	08 	. 
	exx			;012a	d9 	. 
	pop hl			;012b	e1 	. 
	pop de			;012c	d1 	. 
	pop bc			;012d	c1 	. 
	exx			;012e	d9 	. 
	pop iy			;012f	fd e1 	. . 
	pop ix			;0131	dd e1 	. . 
	ret			;0133	c9 	. 
INIT:
	ld a,002h		;0134	3e 02 	> . 
	inc a			;0136	3c 	< 
	ld de,TXT_WRONG_CPU		;0137	11 4f 01 	. O . 
	jp pe,l0149h		;013a	ea 49 01 	. I . 
	ld c,00ch		;013d	0e 0c 	. . 
	call CALL_BDOS		;013f	cd 18 01 	. . . 
	or a			;0142	b7 	. 
	ld de,TXT_WRONG_CPM_VER		;0143	11 5f 01 	. _ . 
	jp nz,00200h		;0146	c2 00 02 	. . . 
l0149h:
	ld c,009h		;0149	0e 09 	. . 
	call CALL_BDOS		;014b	cd 18 01 	. . . 
	rst 0			;014e	c7 	. 
TXT_WRONG_CPU:
	DEFM		'Wrong processor$'
	;ld d,a			;014f	57 	W 
	;ld (hl),d			;0150	72 	r 
	;ld l,a			;0151	6f 	o 
	;ld l,(hl)			;0152	6e 	n 
	;ld h,a			;0153	67 	g 
	;jr nz,l01c6h		;0154	20 70 	  p 
	;ld (hl),d			;0156	72 	r 
	;ld l,a			;0157	6f 	o 
	;ld h,e			;0158	63 	c 
	;ld h,l			;0159	65 	e 
	;ld (hl),e			;015a	73 	s 
	;ld (hl),e			;015b	73 	s 
	;ld l,a			;015c	6f 	o 
	;ld (hl),d			;015d	72 	r 
	;inc h			;015e	24 	$ 
TXT_WRONG_CPM_VER:
	DEFM		'Wrong CP/M version$'
	;ld d,a			;015f	57 	W 
	;ld (hl),d			;0160	72 	r 
	;ld l,a			;0161	6f 	o 
	;ld l,(hl)			;0162	6e 	n 
	;ld h,a			;0163	67 	g 
	;jr nz,l01a9h		;0164	20 43 	  C 
	;ld d,b			;0166	50 	P 
	;cpl			;0167	2f 	/ 
	;ld c,l			;0168	4d 	M 
	;jr nz,l01e1h		;0169	20 76 	  v 
	;ld h,l			;016b	65 	e 
	;ld (hl),d			;016c	72 	r 
	;ld (hl),e			;016d	73 	s 
	;ld l,c			;016e	69 	i 
	;ld l,a			;016f	6f 	o 
	;ld l,(hl)			;0170	6e 	n 
	;inc h			;0171	24 	$ 
REBOOT:
	rst 0			;0172	c7 	. 
GTIME:
	ld de,00000h		;0173	11 00 00 	. . . 
	ld hl,00000h		;0176	21 00 00 	! . . 
	ret			;0179	c9 	. 
PTIME:
	ret			;017a	c9 	. 
CLS:
	push bc			;017b	c5 	. 
	ld c,002h		;017c	0e 02 	. . 
	ld e,01ah		;017e	1e 1a 	. . 
	call CALL_BDOS		;0180	cd 18 01 	. . . 
	pop bc			;0183	c1 	. 
	ret			;0184	c9 	. 
INKEY:
	push bc			;0185	c5 	. 
	push hl			;0186	e5 	. 
	ld c,006h		;0187	0e 06 	. . 
	ld e,0ffh		;0189	1e ff 	. . 
	call CALL_BDOS		;018b	cd 18 01 	. . . 
	pop hl			;018e	e1 	. 
	pop bc			;018f	c1 	. 
	or a			;0190	b7 	. 
	scf			;0191	37 	7 
	ret nz			;0192	c0 	. 
	or h			;0193	b4 	. 
	or l			;0194	b5 	. 
	ret z			;0195	c8 	. 
	push bc			;0196	c5 	. 
	ld a,0ffh		;0197	3e ff 	> . 
	ld bc,004e2h		;0199	01 e2 04 	. . . 
l019ch:
	dec bc			;019c	0b 	. 
	cp b			;019d	b8 	. 
	jp nz,l019ch		;019e	c2 9c 01 	. . . 
	pop bc			;01a1	c1 	. 
	dec hl			;01a2	2b 	+ 
	jr INKEY		;01a3	18 e0 	. . 
PCSR:
	push de			;01a5	d5 	. 
	push hl			;01a6	e5 	. 
	ld c,002h		;01a7	0e 02 	. . 
l01a9h:
	ld e,01bh		;01a9	1e 1b 	. . 
	call CALL_BDOS		;01ab	cd 18 01 	. . . 
	ld c,002h		;01ae	0e 02 	. . 
	ld e,03dh		;01b0	1e 3d 	. = 
	call CALL_BDOS		;01b2	cd 18 01 	. . . 
	pop hl			;01b5	e1 	. 
	ld a,l			;01b6	7d 	} 
	add a,020h		;01b7	c6 20 	.   
	ld c,002h		;01b9	0e 02 	. . 
	ld e,a			;01bb	5f 	_ 
	call CALL_BDOS		;01bc	cd 18 01 	. . . 
	pop de			;01bf	d1 	. 
	ld a,e			;01c0	7b 	{ 
	add a,020h		;01c1	c6 20 	.   
	ld c,002h		;01c3	0e 02 	. . 
	ld e,a			;01c5	5f 	_ 
l01c6h:
	call CALL_BDOS		;01c6	cd 18 01 	. . . 
	ret			;01c9	c9 	. 
GCSR:
	ld de,00000h		;01ca	11 00 00 	. . . 
	ld hl,00000h		;01cd	21 00 00 	! . . 
	ret			;01d0	c9 	. 
	;nop			;01d1	00 	. 
	;nop			;01d2	00 	. 
	;nop			;01d3	00 	. 
	;nop			;01d4	00 	. 
	;nop			;01d5	00 	. 
	;nop			;01d6	00 	. 
	;nop			;01d7	00 	. 
	;nop			;01d8	00 	. 
	;nop			;01d9	00 	. 
	;nop			;01da	00 	. 
	;nop			;01db	00 	. 
	;nop			;01dc	00 	. 
	;nop			;01dd	00 	. 
	;nop			;01de	00 	. 
	;nop			;01df	00 	. 
	;nop			;01e0	00 	. 
	;l01e1h:
	;nop			;01e1	00 	. 
	;nop			;01e2	00 	. 
	;nop			;01e3	00 	. 
	;nop			;01e4	00 	. 
	;nop			;01e5	00 	. 
	;nop			;01e6	00 	. 
	;nop			;01e7	00 	. 
	;nop			;01e8	00 	. 
	;nop			;01e9	00 	. 
	;nop			;01ea	00 	. 
	;nop			;01eb	00 	. 
	;nop			;01ec	00 	. 
	;nop			;01ed	00 	. 
	;nop			;01ee	00 	. 
	;nop			;01ef	00 	. 
	;nop			;01f0	00 	. 
	;nop			;01f1	00 	. 
	;nop			;01f2	00 	. 
	;nop			;01f3	00 	. 
	;	ld d,b			;01f4	50 	P 
	;	dec b			;01f5	05 	. 
	;	jr 3		;01f6	18 01 	. . 
	;	ld b,014h		;01f8	06 14 	. . 
	;	ld a,a			;01fa	7f 	 
	;	dec d			;01fb	15 	. 
	;	inc de			;01fc	13 	. 
	;	inc b			;01fd	04 	. 
	;	rlca			;01fe	07 	. 
	;	defb 016h		;01ff	16 	. 

	; **** OLD ****

	IF      $ GT 1F4H
	ERROR	'INSUFFICIENT SPACE'
	ENDIF
;
	ORG     1F4H
;
        DEFB    80              ;WIDTH
        DEFB    'K' AND 1FH     ;CURSOR UP
        DEFB    'J' AND 1FH     ;CURSOR DOWN
        DEFB    'L' AND 1FH     ;START OF LINE
        DEFB    'B' AND 1FH     ;END OF LINE
        DEFB    'C' AND 1FH     ;DELETE TO END OF LINE
        DEFB    7FH             ;BACKSPACE & DELETE
        DEFB    'X' AND 1FH     ;CANCEL LINE
        DEFB    'H' AND 1FH     ;CURSOR LEFT
        DEFB    'I' AND 1FH     ;CURSOR RIGHT
        DEFB    'E' AND 1FH     ;DELETE CHARACTER
        DEFB    'A' AND 1FH     ;INSERT CHARACTER


FIN:	END
