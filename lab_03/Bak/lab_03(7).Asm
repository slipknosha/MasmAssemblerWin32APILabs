.386
.model flat,STDCALL
option casemap :none  ;case sensitive

include lab_03.inc

.code
Begin:
	call main
	
invoke ExitProcess,NULL

Mem_Alloc PROC Buf_Size:DWORD
add Buf_Size,4    ; виділяємо буфер на 4 байти більший
invoke GlobalAlloc,GMEM_MOVEABLE or GMEM_ZEROINIT,Buf_Size   ; виділяємо область у динамічній пам’яті
push eax     ; зберігаємо хендл області виділеного буфера у стек
invoke GlobalLock,eax ;фіксуємо у реальній
pop [eax]    ;Витягнемо зі стеку значення  і запишемо у перші 4 байта виділеного масиву, 
;це значення є хенд області виділеної області
;наступні Buf_Size байт використовуємо як масив
add eax,4    ;зсуваємо вказівних початку масиву на 4 байти, оскільки перші 4 байти 
        ;заняті значенням хендлу буфера
    ret    ; виходимо з процедури
Mem_Alloc endp

; власна процедура знищення пам’яті.
Mem_Free PROC DATA:DWORD
mov eax,DATA    ;копіюємо значення параметра процедури у регістр eax, параметром є 
        ;початкова (робоча) адреса буфера ( початок + 4 байти)
sub eax,4    ;пам'ятаємо, що перших 4 байти масиву  - це хендл буфера
mov eax,[eax]     ;беремо чотирьох байтне значення по адресі, що лежить у регістрі eax
push eax        ;заносимо його у стек
push eax
call GlobalUnlock    ;розблоковуємо пам'ять (всю розміром Buf_Size+4)
call GlobalFree    ;оскільки параметр вже у стеці, викликаємо процедуру без параметрів, за дапомогою інструкції 
;call (знищуємо хендел буфера)
    ret    ;вихід з процедури
Mem_Free endp

Upper_Case proc
	mov esi, buf_
	dec esi
	
start:
	inc esi
	mov al, [esi]
	cmp al, 0
	jz exit
	cmp al, 'a'
	jnae start
	cmp al, 'z'
	jnbe start
	jnae upper
upper:
	sub al, 32
	mov [esi], al
	jmp start
exit:
	ret
Upper_Case endp


main proc
	LOCAL handler:DWORD
	LOCAL handle:DWORD
	
	invoke Mem_Alloc, sizeof(OPENFILENAME)
	mov handle, eax
	assume handle: ptr OPENFILENAME
	mov handle.lStructSize, sizeof(OPENFILENAME)
	mov handle.lpstrFile, offset file_name
	mov handle.nMaxFile, 256
	mov handle.lpstrInitialDir, offset dir
	mov handle.lpstrTitle, NULL
	
	invoke Mem_Alloc, 1024
	mov buf_, eax
	invoke GetOpenFileName, addr handle
	invoke CreateFile, addr file_name, GENERIC_READ, FILE_SHARE_WRITE or FILE_SHARE_READ, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	mov handler, eax
	invoke ReadFile, handler, buf_, 1024, addr size_, NULL
	invoke MessageBox, 0, buf_, addr title_, MB_OK
    invoke Upper_Case
	invoke MessageBox, 0, buf_, addr title_, MB_OK
	invoke CloseHandle, handler
	invoke GetTempFileName, addr dir, addr rand_prefix, 0, addr random_name
	invoke CreateFile, addr random_name, GENERIC_WRITE, FILE_SHARE_WRITE or FILE_SHARE_READ, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	mov handler, eax
	invoke WriteFile, handler, buf_, 1024, 0, 0
	invoke CloseHandle, handler
	invoke Mem_Free, buf_
	
	ret

main endp

end Begin
