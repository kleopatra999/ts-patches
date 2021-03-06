%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
;; @CLEAR 0x0062D4B2, 0x90, 0x0062D4BA

gbool AttackNeutralUnits, 0

hack 0x0062D4B2, 0x0062D4BA
        test    al, al
        jnz     .test_weapon

        jmp     hackend

.test_weapon:
        cmp     byte [AttackNeutralUnits], 1
        jne     0x0062D8C0

        mov     eax, [esi]
        push    0               ; Primary weapon
        mov     ecx, esi
        call    [eax+0x30C]

        test    eax, eax
        jz      0x0062D8C0      ; Don't attack

        mov     eax, [eax]
        test    eax, eax
        jz      0x0062D8C0      ; Don't attack

        mov     ecx, [eax+0x7C] ; Check for Range
        test    ecx, ecx        ; Ranges is zero?
        jz      0x0062D8C0      ; Don't attack

        jmp     hackend


@LJZ 0x0062D45C, _Dont_attack_any_buildings_with_no_weapon
section .text
_Dont_attack_any_buildings_with_no_weapon:
        mov     eax, [esi]
        push    0               ; Primary weapon
        mov     ecx, esi
        call    [eax+0x30C]

        test    eax, eax
        jz      0x0062D8C0      ; Don't attack

        mov     eax, [eax]
        test    eax, eax
        jz      0x0062D8C0      ; Don't attack

        mov     ecx, [eax+0x7C] ; Check for Range
        test    ecx, ecx        ; Ranges is zero?
        jnz     hackend

        jmp     0x0062D8C0      ; Don't attack
