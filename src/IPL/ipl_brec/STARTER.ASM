;
; Extended Operating System Loader (XOSL)
; Copyright (c) 1999 by Geurt Vos
;
; This code is distributed under GNU General Public License (GPL)
;
; The full text of the license can be found in the GPL.TXT file,
; or at http://www.gnu.org
;

;/*
; * File  : MAIN.ASM
; * Author: Geurt Vos
; * Date  : March 1999
; *
; * Main routine for either FAT IPL
; */

                .model  tiny
                .386p
                .data
LOADERADDR      equ     80000100h
LOADERSEG       equ     8000h

		.code
                extrn   _main: near

                .startup
                jmp     LoaderStart
                nop
FatBootRec      db      59 dup (?)

LoaderStart:    nop                     ;need to move code two bytes, so
                nop                     ;it can be alligned on xxxx:0100h
;0000:7c40:
                db      0eah            ;jmp 07b4:0145
                dd      07b00145h
;07b4:0105:
                mov     ax,cs
                mov     ds,ax
                mov     ss,ax
                mov     sp,0fffeh


                call    _main


RunLoader:
                mov     ax,LOADERSEG
                mov     ds,ax
                mov     ss,ax
                mov     sp,0fffeh

                db      0eah            ;execute com file
                dd      LOADERADDR

                end
