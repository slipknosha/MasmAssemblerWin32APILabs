.586
.model flat,stdcall
option casemap:none

include lab_04.inc

.code


; ---------------------------------------------------------------------------


start:
	invoke GetModuleHandle, NULL
	mov    hInstance,eax
	
	invoke GetCommandLine
	mov    CommandLine,eax
	
	invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
	invoke ExitProcess,eax
	
EnumCallBack proc hadnle, lParam:dword
	LOCAL buf[1024]:byte
	invoke GetWindowText, hadnle, addr buf, 1024
	invoke SendMessage, hList, LB_ADDSTRING, 0, addr buf
	mov eax, 1
	ret

EnumCallBack endp

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
	LOCAL wc:WNDCLASSEX
	LOCAL msg:MSG
	LOCAL hwnd:HWND
	
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInstance
	pop   wc.hInstance
	mov   wc.hbrBackground,COLOR_BTNFACE+1
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,OFFSET ClassName
	
	invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
	mov   wc.hIconSm,eax
	
	invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
	
	invoke RegisterClassEx, addr wc
	INVOKE CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
           WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,\
           CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,NULL,NULL,\
           hInst,NULL
	mov   hwnd,eax
	push eax
	
	invoke CreateWindowEx, 0, addr ListClassName, 0, LBS_NOTIFY + WS_CHILD + WS_BORDER + WS_VISIBLE, 15, 15, 1100, 530, hwnd, 0, hInstance, 0
	mov   hList, eax
	
	invoke EnumWindows, OFFSET EnumCallBack, 0
	
	pop eax
	invoke AnimateWindow, eax, 1000, AW_BLEND
	
	invoke ShowWindow, hwnd,SW_SHOWNORMAL
	invoke UpdateWindow, hwnd
	
	.WHILE TRUE
		invoke GetMessage, ADDR msg,NULL,0,0
		.BREAK .IF (!eax)
		invoke TranslateMessage, ADDR msg
		invoke DispatchMessage, ADDR msg
	.ENDW
	
	mov     eax,msg.wParam
	ret
WinMain endp



WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	LOCAL buf_[1024]:byte
	mov eax, uMsg
	.IF eax==WM_DESTROY
		invoke PostQuitMessage,NULL
	.ELSEIF eax==WM_CREATE
		;
	.elseif eax==WM_COMMAND
		mov ecx, wParam
		shr ecx, 16
		.if ecx==LBN_DBLCLK
			invoke SendMessage, hList, LB_GETCURSEL, 0, 0
			mov ecx, eax
			invoke SendMessage, hList, LB_GETTEXT, ecx, addr buf_
			invoke MessageBox, 0, addr buf_, addr AppName, MB_OK
		.endif
	.ELSE
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
		ret
	.ENDIF
	
	xor eax,eax
	ret
WndProc endp


end start
