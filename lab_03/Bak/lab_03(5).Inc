include WINDOWS.inc

include user32.inc
include kernel32.inc

includelib user32.lib
includelib kernel32.lib

includelib comdlg32.lib
includelib shell32.lib
include comdlg32.inc

.data

handle OPENFILENAME <0>

file_name db 256 dup(0)
dir db "D:\", 0
filtr db "*.txt", 0, "*.txt", 0, 0

size_ db 1024 dup(0)

buf db 1024 dup(0)

file db "D:\name.txt", 0

fHandler dd 0

buf_ dd 0

dich db "tmp", 0

random_name db 256 dup(0)

