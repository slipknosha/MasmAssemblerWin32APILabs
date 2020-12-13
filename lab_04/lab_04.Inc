include windows.inc
include user32.inc
include kernel32.inc
include comdlg32.inc
   
includelib user32.lib
includelib kernel32.lib
includelib comdlg32.lib
includelib shell32.lib


WinMain proto :DWORD,:DWORD,:DWORD,:DWORD


.data
   ClassName db "MainWinClass",0
   AppName  db "lab_04_Bobrykov",0
   
   ListClassName db 'listbox', 0

.data?
   hInstance dd ?
   CommandLine dd ?
   
   hList dd ?