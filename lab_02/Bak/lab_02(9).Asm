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
LOCAL char_amount : dword
LOCAL len_name_logic : dword
LOCAL len_file_system : dword

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

  invoke GetVolumeInformation, addr drive, addr name_logic, 256, 0, 0, 0, addr file_system, 256
  ;invoke GetVolumeInformation, addr drive, addr name_logic, len_name_logic, NULL, NULL, NULL, file_system, len_file_system
   invoke MessageBox, NULL, addr file_system, NULL, MB_YESNO
  
  invoke lstrcat, addr buf, addr drive
  invoke lstrcat, addr buf, addr string1
 ; invoke lstrcat, addr buf, addr string3
  ;invoke lstrcat, addr buf, addr name_logic
  ;invoke lstrcat, addr buf, addr string3
 ; invoke lstrcat, addr buf, addr file_system
  
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
  
  invoke lstrcat, addr buf, eax
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
  invoke GetVolumeInformation, addr kek, addr name_logic, 256, 0, 0, 0, addr file_system, 256
  invoke MessageBox, NULL, addr file_system, NULL, MB_YESNO
  ret

main endp

end Begin