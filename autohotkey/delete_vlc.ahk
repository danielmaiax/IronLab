; Delete/Move a playing VLC video (via hotkeys) then jumps to the next video in the playlist.
; ------------------------------------------
; DEL       = Delete video to the recycle bin
; SHIFT+DEL = Permanently delete video of disk
; CTRL+Z    = Move video to arbitrary location
; ------------------------------------------

MOVE_ACTION_DIR := "C:\"
MEDIA_INFO_DIALOG_TITLE := "Current Media Information"
WAIT_FOR_MEDIA_INFO_DIALOG_SECS := 0.25
WAIT_FOR_MEDIA_INFO_DIALOG_RETRIES := 10
CLIPBOARD_WAIT_SECS := 1
WAIT_FOR_NEXT_VID_SECS := 0.10
WAIT_FOR_NEXT_VID_RETRIES := 10
GIVE_BACK_MOUSE_CONTROL_AFTER_SECS := 5

#Requires AutoHotkey >=2.0
#SingleInstance Force
#HotIf WinActive("ahk_class Qt5QWindowIcon")  ; only trigger the use of hotkeys if a VLC window is active

~Shift & Delete:: {  ; SHIFT+DEL = Permanently delete video off disk
    KeyWait "Delete", "Up"
    KeyWait "Shift", "Up"
    DoPermDelete()
    Return
}

~Delete:: {  ; DEL = Delete video to the recycle bin
    KeyWait "Delete", "Up"
    DoRecycleDelete()
    Return
}

~Ctrl & z:: {  ; CTRL+Z = Move video to arbitrary location
    KeyWait "Ctrl", "Up"
    KeyWait "z", "Up"
    DoMove(MOVE_ACTION_DIR)
    Return
}

DoAction(action) {
    BlockInput "MouseMove"  ; block user from using the mouse
    SetTimer AllowMouse, GIVE_BACK_MOUSE_CONTROL_AFTER_SECS * 1000  ; restore the mouse for the user at some point if something goes wrong
    vlcTitle := WinGetTitle("A") ; vlc should be the active window because it's the only way this line got called
    isFullScreen := false

    ; open the media information dialog

    Send "^i" ; CTRL+I is harcoded in vlc to open the media info dialog
    if !WinWait(MEDIA_INFO_DIALOG_TITLE, , WAIT_FOR_MEDIA_INFO_DIALOG_SECS) {
        ; cant find information window - vlc in fullscreen?
        ; attempt to leave fullscreen and retry opening information dialog
        Send "{ESC}" ; leave fullscreen
        Sleep 10
        Send "^i"
        isFullScreen := true ; user was indeed in fullscreen - remember so we can restore it later
        retry := 1
        while !WinWait(MEDIA_INFO_DIALOG_TITLE, , WAIT_FOR_MEDIA_INFO_DIALOG_SECS) {
            retry++
            if retry == WAIT_FOR_MEDIA_INFO_DIALOG_RETRIES { ; something went wrong.
                Msgbox "Can't find Media Information dialog. Aborting!"
                Return
            }
            Send "^i"
        }
    }

    ; save the full path (as seen in the information dialog) of the video that is playing to the clipboard

    MouseGetPos &orgMouseX, &orgMouseY
    orgClipboardContent := ClipboardAll()
    WinActivate MEDIA_INFO_DIALOG_TITLE
    WinWaitActive MEDIA_INFO_DIALOG_TITLE
    WinGetPos , , &width, &height, MEDIA_INFO_DIALOG_TITLE
    fileLocationX := width/2
    fileLocationY := height-52
    CoordMode "Mouse", "Window"
    MouseMove fileLocationX, fileLocationY, 1
    Click 3 ; selects the entire path
    Send "^c" ; copies the path to the clipboard
    CoordMode "Mouse", "Screen"
    MouseMove orgMouseX, orgMouseY, 1
    if !ClipWait(CLIPBOARD_WAIT_SECS) {
        WinClose MEDIA_INFO_DIALOG_TITLE
        WinWaitClose MEDIA_INFO_DIALOG_TITLE
        MsgBox "Can't delete/move file!  Problem finding file location nside Media Information dialog."
        Return
    }
    WinClose MEDIA_INFO_DIALOG_TITLE
    WinWaitClose MEDIA_INFO_DIALOG_TITLE

    ; if the user was originally in fullscreen this restore it now

    if isFullScreen {
        ; restore fullscreen if it was orginally set
        WinGetPos , , &width, &height, vlcTitle
        videoX := width/2
        videoY := height/2
        CoordMode "Mouse", "Window"
        MouseMove videoX, videoY, 1
        Click 2
        CoordMode "Mouse", "Screen"
        MouseMove orgMouseX, orgMouseY, 1
    }

    ; move to the next video -- so it can delete/move this video (because vlc locks the running video)

    Send "{PgDn Down}"
    retry := 1
    while WinGetTitle("A") == vlcTitle { ; wait for the next video to start playing
        Sleep WAIT_FOR_NEXT_VID_SECS * 1000 ; give it some more time to move to next video
        retry++
        if retry == WAIT_FOR_NEXT_VID_RETRIES { ; something went wrong.  no more videos? (we cant delete/move if its only 1 video)
            MsgBox "Didn't detect next video change. Only 1 video left?`nCan't delete/move this video."
            Return
        }
    }
    vlcTitle := WinGetTitle("A")

    ; perform action (delete/move the video now)

    BlockInput "MouseMoveOff"  ; allow the user to have control over the mouse now (in case the delete/move takes too long)
    try
        if action == "del_perm"
            FileDelete A_Clipboard
        else if action == "del_recycle" {
            ;WinActivate "ahk_class Shell_TrayWnd"
            ;WinWaitActive "ahk_class Shell_TrayWnd"
            FileRecycle A_Clipboard
        } else
            FileMove A_Clipboard, action
    catch as err
        MsgBox "Problem deleting/moving file:`n`n" A_Clipboard "`n`n(" err.What " - " err.Message ")"
    A_Clipboard := orgClipboardContent
    try
        WinActivate vlcTitle
    catch
        WinActivate "ahk_class Qt5QWindowIcon" ; strange, we can't find the player! ok just activate any vlc window blindly
}

DoPermDelete() {
    DoAction("del_perm")
}

DoRecycleDelete() {
    DoAction("del_recycle")
}

DoMove(path) {
    DoAction(path)
}

AllowMouse() {
    BlockInput "MouseMoveOff"
}