;goblin.asm
.model     tiny              ; for COM
.code                        ; code segment start
org        100h              ; offset in memory = 100h (for COM)
start:
	main         proc
		begin:
			mov     ah,09h
			mov     dx,offset prompt
			int     21h
		inpt:
			mov     ah,01h
			int     21h
			cmp     al,'m'
			je      mode_man
			cmp     al,'w'
			je      mode_woman		
			call    goblin			
			jmp     begin
		mode_man:
			mov     addrs,offset man
			jmp     cont
		mode_woman:
			mov     addrs,offset woman		
		cont:
			call   word ptr addrs
			mov     ax,4c00h
			int     21h
	main    endp

	man     proc
		mov     ah,09h
		mov     dx,offset mes_man
		int     21h
		ret
	man     endp

	woman    proc
		mov     ah,09h
		mov     dx,offset mes_womn
		int     21h
		ret
	woman    endp
	
	goblin    proc
		mov     ah,09h
		mov     dx,offset mes_gobl
		int     21h
		ret
	goblin    endp
	
;DATA
	addrs     	dw      0;for procedure adress
	prompt 		db 		'Are you Man or Woman [m/w]? : $'	
	mes_man  	db     0Dh,0Ah,"Hello, Strong Man!",0Dh,0Ah,'$' ;Строка для вывода. Вместо ASCII смвола '$' можно написать машинный код 24h
	mes_womn 	db     0Dh,0Ah,"Hello, Beautyful Woman!",0Dh,0Ah,'$' ;Строка для вывода.
	mes_gobl 	db     0Dh,0Ah,"Hello, Strong and Beautyful GOBLIN!",0Dh,0Ah,24h ;Строка для вывода. 24h = '$' .
	len = $ - mes_gobl
end start