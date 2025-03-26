; Without this, the win+alt+k macro doesn't work
#Requires AutoHotkey v2.0

; Cheatsheet
; #     = Win
; ^     = ctrl
; !     = alt
; +     = shift
; Prepend < for left (ex "<#") and > for right (ex ">#")
; For hotkeys, can't use colon ":"

    ; Remap "Shift + PauseBreak" to "Shift + Insert" for pasting into terminal
    +Pause::    +Insert
    ; Remap capslock to esc
    Capslock::  Esc

; *********** Kinesis Freestyle2 "fn" Layer: left-ctrl + left-alt *********************
    <^<!m::   0
    <^<!0::   0
    <^<!j::   1
    <^<!k::   2
    <^<!l::   3
    <^<!u::   4
    <^<!i::   5
    <^<!o::   6
    <^<!7::   7
    <^<!8::   8
    <^<!9::   9
    <^<!-::   *
    <^<!p::   -
    <^<!;::   +
    <^<!.::   .
    <^<!/::   /
; **********************************************************

; *********** Media Layer: left-win + left-alt *********************
; Sound Control / Mic Control
    ; Mute Microphone: win + alt + k already mutes/unmutes microphone

    ; Mute Sound: left_win + alt + m
    <#!m::   SoundSetMute -1

    ; left_win+alt+ up/down  = volume up/down
    <#!up::      send "{Volume_Up}"
    <#!down::    send "{Volume_Down}"

; Spotify Control
    ; play/pause spotify: Left_win + alt + p
    <#!p::
    {
    if WinExist("Spotify")
        WinActivate
        Send "{Media_Play_Pause}"
    }

    ; prev song spotify = left_win+alt+left
    <#!left::
    {
    if WinExist("Spotify")
        WinActivate
        Send "{Media_Prev}"
    }

    ; next song spotify = left_win+alt+right
    <#!right::
    {
    if WinExist("Spotify")
        WinActivate
        Send "{Media_Next}"
    }

; **********************************************************
