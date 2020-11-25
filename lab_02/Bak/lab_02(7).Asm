;comment #
.386
.model flat,STDCALL
option casemap :none  ;case sensitive

include lab_02.inc

.code
Begin:
  call main
  
invoke ExitProcess,NULL


AssembleString proc

LOCAL drive_word : dword
LOCAL drive[3] : byte
LOCAL iter :dword
  
  mov drive[1], ' '
  mov drive[2], 0
  mov iter, 26
   
  invoke GetLogicalDrives
  mov drive_word, eax
  mov edx, 40h
  push edx
  mov ecx, 1
  
drive_info:
  pop edx
  inc edx
  mov drive[0], dl
  test drive_word,  ecx
  jnz add_drive
  shl ecx, 1
  push edx
  push ecx
  invoke lstrcat, addr buf, addr drive
  invoke lstrcat, addr buf, addr string1
  pop ecx
  dec iter
  cmp iter, 0
  jz return
  jmp drive_info
  
add_drive:

  shl ecx, 1
  push edx
  push ecx
  invoke lstrcat, addr buf, addr drive
  invoke lstrcat, addr buf, addr string2
  pop ecx
  dec iter
  cmp iter, 0
  jz return
  jmp drive_info  
  
return:
  
  ret
  
AssembleString endp

main proc
  
  call AssembleString
  invoke MessageBox, 0, addr buf, addr title_, MB_OKCANCEL
  ret

main endp

end Begin
;#