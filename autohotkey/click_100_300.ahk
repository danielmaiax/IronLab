#SingleInstance force

 ; Alt + Shift + A
;!+a::ExitApp ;
!p::
ExitApp ;


; Ctrl + Alt d
; date
^!d::
    FormatTime, currentDateTime,, yyyyMMdd-HHmm
    SendInput, %currentDateTime%
    return

; Alt z
; mouse position
!z::
    #Persistent
    Coordmode, Mouse, Screen
    MouseGetPos, x, y
    SendInput %x%, %y%
    return

; Alt
!1::
    Coordmode, Mouse, Screen
    Click, 100, 20
    Click, 2000, 20
    Click, 4600, 20
    return


; Alt
!2::
    Coordmode, Mouse, Screen
    Click, 300, 20
    Click, 2200, 20
    Click, 4800, 20
    return

; Alt
!3::
    Coordmode, Mouse, Screen
    Click, 500, 20
    Click, 2500, 20
    Click, 5000, 20
    return

; Alt
!4::
    Coordmode, Mouse, Screen
    Click, 750, 20
    Click, 2750, 20
    Click, 5250, 20
    return

; Alt
!5::
    Coordmode, Mouse, Screen
    Click, 1000, 20
    Click, 3000, 20
    Click, 5500, 20
    return

; Alt
!6::
    Coordmode, Mouse, Screen
    Click, 1200, 20
    Click, 3200, 20
    Click, 5700, 20
    return

; Alt
!7::
    Coordmode, Mouse, Screen
    Click, 1400, 20
    Click, 3400, 20
    Click, 5900, 20
    return

; Alt
!0::
    Loop, 5000
    {
        Send, !1
        Sleep, 5555 ; Aguarda 1000 milissegundos (1 segundo)
        Send, !2
        Sleep, 5555 ; Aguarda 1000 milissegundos (1 segundo)
        Send, !3
        Sleep, 5555 ; Aguarda 1000 milissegundos (1 segundo)
        Send, !4ö
        Sleep, 5555 ; Aguarda 1000 milissegundos (1 segundo)
        Send, !5
        Sleep, 5555 ; Aguarda 1000 milissegundos (1 segundo)
        Send, !6
        Sleep, 5555 ; Aguarda 1000 milissegundos (1 segundo)
    }


; ALT + x
; tv - sync lines
!x::
    Coordmode, Mouse, Screen
    ;globally
    Click, 4470, 1045
    Sleep, 200
    Click, 4470, 1016
    Sleep, 200
    ;sync below
    Click, 4470, 1045
    Sleep, 200
    Click, 4470, 924
    Sleep, 200
    Click, 4338, 943
    Sleep, 200
    return

; ALT + c
; tv - select color
!c::
    Coordmode, Mouse, Screen
    ;globally
    Click, 4321, 1045
    MouseMove 4323, 910
    return

; ALT + a
; tv - resize auto all
!a::
    Coordmode, Mouse, Screen
    ;1/3 - 1/4
    MouseMove 452, 500
    Click, 2
    MouseMove 873, 257
    Click, 2

    ;1/3 - 2/4
    MouseMove 1353, 500
    Click, 2
    MouseMove 1739, 276
    Click, 2

    ;1/3 - 3/4
    MouseMove 427, 956
    Click, 2
    MouseMove 872, 707
    Click, 2

    ;1/3 - 4/4
    MouseMove 1338, 954
    Click, 2
    MouseMove 1739, 701
    Click, 2

    ;2/3 - 1/6
    MouseMove 2349, 519
    Click, 2
    MouseMove 2719, 268
    Click, 2

    ;2/3 - 2/6
    MouseMove 3120, 519
    Click, 2
    MouseMove 3509, 278
    Click, 2

    ;2/3 - 3/6
    MouseMove 3920, 519
    Click, 2
    MouseMove 4294, 243
    Click, 2

    ;2/3 - 4/6
    MouseMove 2326, 987
    Click, 2
    MouseMove 2716, 730
    Click, 2

    ;2/3 - 5/6
    MouseMove 3123, 989
    Click, 2
    MouseMove 3510, 710
    Click, 2

    ;2/3 - 6/6
    MouseMove 3932, 986
    Click, 2
    MouseMove 4301, 691
    Click, 2

    ;3/3 - 1/4
    MouseMove 4939, 518
    Click, 2
    MouseMove 5342, 251
    Click, 2

    ;3/3 - 2/4
    MouseMove 5786, 520
    Click, 2
    MouseMove 6200, 259
    Click, 2

    ;3/3 - 3/4
    MouseMove 4945, 988
    Click, 2
    MouseMove 5344, 717
    Click, 2

    ;3/3 - 4/4
    MouseMove 5788, 984
    Click, 2
    MouseMove 6205, 714
    Click, 2

    return


;
; tv - proximo tick
!d::
    Coordmode, Mouse, Screen
    Click, 1824, 733
    Send, {Space}
    Click, 4396, 734
    Send, {Space}
    Click, 6299, 686
    Send, {Space}
    return




Send, {Down}
