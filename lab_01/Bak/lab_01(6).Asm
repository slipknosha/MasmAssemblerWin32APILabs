comment @
ќбТЇднати результати функц≥й GetComputerName, GetCurrentDirectory, GetDriveType,
GetSystemDirectory, GetTempPath, GetUserName та GetWindowsDirectory в одну
стр≥чку, формату :
Computer Name : ЕЕ
Current Directory : ЕЕ..
≥тд.
ѕ≥сл€ обСЇднанн€ р€дк≥в, визначити та вивести на екран статистику використанн€ вс≥х
букв англ≥йського алфав≥ту у формат≥:
УaФ Ц 5; УbФ - 6; УcФ Ц ggh
УdФ -1; ≥тд.
@


.386
.model flat, STDCALL
option casemap :none

include lab_01.inc

.code 
Begin:
  call main 
  
invoke ExitProcess,NULL


print proc
LOCAL amount:DWORD
LOCAL alphabet:WORD
LOCAL lol[2]:byte

	mov edi, 26
	xor ebx, ebx
	mov bl, 'a'

letter:	
	lea esi, buf
	mov ecx, 0 ;conter of letter amount
counter:
	mov al, [esi]
	inc esi
	cmp al, 0
	jz next
	cmp al, bl
	jz small
	xor edx, edx
	mov dl, bl
	sub dl, 32 
	cmp al, dl
	jnz counter
small:
	inc ecx
	jmp counter
	
next:
	invoke wsprintf, addr output, addr format, ebx, ecx
	invoke lstrcat, addr buf, addr output
	
	inc ebx
    dec edi  
    cmp edi, 0
    jnz letter
	
	ret

print endp

double_letters proc buf_k:DWORD, buf_l : DWORD
xor eax, eax
mov esi, buf_k
mov edi, buf_l


start:
mov al, [esi]
cmp al, 0
jz return

mov [edi], al
inc edi
mov [edi], al
inc edi
inc esi
jmp start

return:
  ret
  
double_letters endp

get_string proc
LOCAL _2bytes:WORD
LOCAL enter_[2]:BYTE
  mov enter_[0], 0dh
  mov enter_[1], 0
  
  mov _2bytes, enter_
  
  invoke GetComputerName, addr buf1, addr buflen
  mov buflen, 256
  invoke GetCurrentDirectory, 256, addr buf2
  invoke GetDriveType, addr buf3
  invoke GetSystemDirectory, addr buf4, 256
  invoke GetTempPath, 256, addr buf5
  ;invoke GetUserName, addr buf6, addr buflen
  invoke GetWindowsDirectory, addr buf7, 255
  

  invoke lstrcat, addr buf1, addr _2bytes
  invoke lstrcat, addr buf2, addr _2bytes
  invoke lstrcat, addr buf3, addr _2bytes
  invoke lstrcat, addr buf4, addr _2bytes
  invoke lstrcat, addr buf5, addr _2bytes
  ;invoke lstrcat, addr buf6, addr enter_
  invoke lstrcat, addr buf7, addr _2bytes

  invoke lstrcat, addr buf, addr buf1
  invoke lstrcat, addr buf, addr buf2
  invoke lstrcat, addr buf, addr buf3
  invoke lstrcat, addr buf, addr buf4
  invoke lstrcat, addr buf, addr buf5
  ;nvoke lstrcat, addr buf, addr buf6
  invoke lstrcat, addr buf, addr buf7
	
	ret

get_string endp

main proc

  call get_string
  call print
  invoke double_letters, addr buf, addr buf__
  invoke MessageBox, NULL, addr buf__, addr hello_title, MB_YESNO
  
  ret

main endp

end Begin