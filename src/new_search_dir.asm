%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"


STRUC SearchDirList
  .next: RESD 1
  .path: RESD 1
ENDSTRUC

sstring str_SearchDir, "MIX\\"
sstring str_SearchDir2, "INI\\"

gint ptr_str_SearchDir, str_SearchDir
[section .data]
NewSearch: ISTRUC SearchDirList
        AT SearchDirList.next, dd NewSearch1
        AT SearchDirList.path, dd str_SearchDir
IEND
NewSearch1: ISTRUC SearchDirList
        AT SearchDirList.next, dd 0
        AT SearchDirList.path, dd str_SearchDir2
IEND

;;; 
hack 0x005ED005, 0x005ED00B
        mov     [ebp+0x12C8], eax
        mov     dword [0x00760920], NewSearch
        jmp     hackend

;; Addon_Available() hack
@SET 0x004070CF, {mov bl, 1}

;;; Expand%02.mix
@CALL 0x004E3EAE, CCFileClass__CCFileClass
@CALL 0x004E3EC1, CCFileClass__Destroy

;;; patch.mix
@CALL 0x004E3D43, CCFileClass__CCFileClass
@CALL 0x004E3D58, CCFileClass__Destroy
