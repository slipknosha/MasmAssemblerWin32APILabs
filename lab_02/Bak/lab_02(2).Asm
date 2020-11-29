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
LOCAL drive[4] : byte
LOCAL iter :dword
LOCAL comparator : dword
LOCAL char : byte
  
  mov drive[1], ':'
  mov drive[2], '\'
  mov drive[3], 0
  mov iter, 27
   
  invoke GetLogicalDrives
  mov drive_word, eax
  
  mov comparator, 1
  mov char, 40h
  
drive_info:
  inc char
  dec iter
  cmp iter, 0
  jz return
  mov cl, char
  mov drive[0], cl
  invoke lstrcat, addr buf, addr drive
  mov ecx, comparator
  shl comparator, 1
  test drive_word,  ecx
  jnz add_drive

  invoke lstrcat, addr buf, addr string
  jmp drive_info

add_drive:
  invoke GetVolumeInformation, addr drive, addr NameBuffer, 256, addr VSNumber, addr MCLength, 0, addr SysNameBuffer, 256
  invoke wsprintf, addr buf_, addr format, addr SysNameBuffer, addr NameBuffer
  invoke lstrcat, addr buf, addr buf_
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