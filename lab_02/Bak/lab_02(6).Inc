include WINDOWS.inc

include user32.inc
include kernel32.inc
include RADbg.inc

includelib user32.lib
includelib kernel32.lib

.data
get_drives db MAX_PATH dup(0)
	
title_ db "titile", 0


string db '" :\" - ³ρνσΊ', 0dh
string1 db '" :\" - νε ³ρνσΊ', 0dh

buf db 1024 dup(0)

amount dd 0