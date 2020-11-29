include WINDOWS.inc

include user32.inc
include kernel32.inc

includelib user32.lib
includelib kernel32.lib

.data
  get_drives   db MAX_PATH dup(0)
  title_     db "titile", 0
  buf       db 1024 dup(0)
  amount     dd MAX_PATH
  buf_for_drives  db MAX_PATH dup(0)
  string1     db " - νε ³ρνσΊ", 0dh, 0
  string2     db " - ³ρνσΊ - ", 0
  string3  db " - ", 0
  NameBuffer db 256 dup(0)
SysNameBuffer db 256 dup(0)
VSNumber dd 0
MCLength dd 0