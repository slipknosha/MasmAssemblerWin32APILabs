include WINDOWS.inc

include user32.inc
include kernel32.inc

includelib user32.lib
includelib kernel32.lib

.data  ;���� �������� ����� (��������� �����)
buflen dd 256  ;���������� ����� (������� � 4 �����)
        ;� ��������� ������ �������� 256
hello_title db '����������� ������ �1 ', 0;����� �������(�����)(�����)
hello_message db 'Computer Name: ', 0 ;����� �����
user_name db 256 dup(0); ����� ����� ���������� ������

buf byte 1024 dup(0)
buf1 db 256 dup(0)
buf2 db 256 dup(0)
buf3 db 256 dup(0)
buf4 db 256 dup(0)
buf5 db 256 dup(0)
buf6 db 256 dup(0)
buf7 db 256 dup(0)

output db 16 dup(0)
format db '"%c" - %d' 0
