comment @
�ᒺ����� ���������� ������� GetComputerName, GetCurrentDirectory, GetDriveType,
GetSystemDirectory, GetTempPath, GetUserName �� GetWindowsDirectory � ����
������, ������� :
Computer Name : ��
Current Directory : ��..
���.
ϳ��� �ᑺ������ �����, ��������� �� ������� �� ����� ���������� ������������ ���
���� ����������� ������� � ������:
�a� � 5; �b� - 6; �c� � ggh
�d� -1; ���.
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
    ;shl ecx, 1 
	invoke wsprintf, addr output, addr format, ebx, ecx
	;invoke MessageBox,0, addr output, 0, MB_OK
	invoke lstrcat, addr buf, addr output
	
	inc ebx
    dec edi  
    cmp edi, 0
    jnz letter
	
	ret

print endp

double_letters proc
xor ebx, ebx
lea esi, buf
lea edi, buf__
start:
cmp buf, 0
jz return

mov [edi], esi
inc edi
mov [edi], esi
inc esi

jmp start

return:
	ret

double_letters endp

get_string proc
LOCAL enter_[2]:BYTE
  mov enter_[0], 0dh
  mov enter_[1], 0
  
  invoke GetComputerName, addr buf1, addr buflen
  mov buflen, 256
  invoke GetCurrentDirectory, 256, addr buf2
  invoke GetDriveType, addr buf3
  invoke GetSystemDirectory, addr buf4, 256
  invoke GetTempPath, 256, addr buf5
  ;invoke GetUserName, addr buf6, addr buflen
  invoke GetWindowsDirectory, addr buf7, 255
  

  invoke lstrcat, addr buf1, addr enter_
  invoke lstrcat, addr buf2, addr enter_
  invoke lstrcat, addr buf3, addr enter_
  invoke lstrcat, addr buf4, addr enter_
  invoke lstrcat, addr buf5, addr enter_
  ;invoke lstrcat, addr buf6, addr enter_
  invoke lstrcat, addr buf7, addr enter_

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
  call double_letters
  invoke MessageBox, NULL, addr buf__, addr hello_title, MB_YESNO
  
  ret

main endp

end Begin