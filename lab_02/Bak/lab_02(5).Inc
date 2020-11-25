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
  string1     db "do not exist", 0dh, 0
  string2    db "exists", 0dh, 0