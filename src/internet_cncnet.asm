%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

@LJMP 0x004E23A7, _Select_Game_WOL_Disable_For_CnCNet

section .rdata
    str_InternetDisabled db"This version of Tiberian Sun only supports online play on CnCNet 5  (www.cncnet.org)",0

section .text

_Select_Game_WOL_Disable_For_CnCNet:
    mov dword [SessionType], 0
    
    push 0
    push 0
    xor edx, edx
    mov ecx, str_InternetDisabled
    call 0x0057C590
    
    jmp 0x004E2A15
