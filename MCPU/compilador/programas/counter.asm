; Simple Counter from 246 to 256
;
; 23.09.2000 Tim Boscke

USE "cpu3.inc"

label0:
	LDA	count
cloop:	
	ADD	one	
	JCC	cloop
loop:
	JMP loop

count:	
	DCB	(256-10)