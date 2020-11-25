include WINDOWS.inc

include user32.inc
include kernel32.inc
include RADbg.inc

includelib user32.lib
includelib kernel32.lib

.data
  get_drives   db MAX_PATH dup(0)
  title_     db "titile", 0
  buf       db 1024 dup(0)
  amount     dd 0
  string1     db ":\ - νε ³ρνσΊ", 0dh, 0
  string2    db ":\ - ³ρνσΊ", 0dh, 0
  string3 db " - "
  
  name_logic db 64 dup(0)
  file_system db 64 dup(0)