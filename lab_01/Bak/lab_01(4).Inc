include WINDOWS.inc

include user32.inc
include kernel32.inc

includelib user32.lib
includelib kernel32.lib

.data  ;Вміст сегменту даних (глобальні змінні)
buflen dd 256  ;Визначення змінної (розміром в 4 байти)
        ;і початково задаємо значення 256
hello_title db 'Лабораторна робота №1 ', 0;рядок символів(стрінг)(байтів)
hello_message db 'Computer Name: ', 0 ;рядок байтів
user_name db 256 dup(0); буфер байтів заповнений нулями

buf byte 1024 dup(0)
buf1 db 256 dup(0)
buf2 db 256 dup(0)
buf3 db 256 dup(0)
buf4 db 256 dup(0)
buf5 db 256 dup(0)
buf6 db 256 dup(0)
buf7 db 256 dup(0)

output db 16 dup(0)
format db '"%c" - %d', 0
