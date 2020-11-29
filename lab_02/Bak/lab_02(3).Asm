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
  mov iter, 26
   
  invoke GetLogicalDrives
  mov drive_word, eax
  invoke GetLogicalDriveStrings, addr amount, addr get_drives
  
  mov comparator, 1
  mov char, 40h
  
drive_info:
  inc char
  mov cl, char
  mov drive[0], cl
  mov ecx, comparator
  shl comparator, 1
  test drive_word,  ecx
  jnz add_drive

  
  invoke lstrcat, addr buf, addr drive
  invoke lstrcat, addr buf, addr string1
  dec iter
  cmp iter, 0
  jz return
  jmp drive_info
  
add_drive:

  lea eax, get_drives
  mov cl, char
  calculate:
  cmp [eax], cl
  jz next
  inc eax
  jmp calculate
    
  next:
  push eax
  invoke lstrcat, addr buf, eax
  pop eax
  invoke GetVolumeInformation, eax, addr NameBuffer, 256, addr VSNumber, addr MCLength, 0, addr SysNameBuffer, 256
  invoke lstrcat, addr buf, addr string2
  invoke lstrcat, addr buf, addr SysNameBuffer
  invoke lstrcat, addr buf, addr string3
  invoke lstrcat, addr buf, addr NameBuffer
  invoke lstrlen, addr buf
  mov buf[eax], 0dh
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