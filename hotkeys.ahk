; Without this, the win+alt+k macro doesn't work
#Requires AutoHotkey v2.0

; ctrl + alt + m = mute sound
^!m::   SoundSetMute -1
; win + alt + k already mutes/unmutes microphone
^!k::   #!k
; also win + alt + left click = mute mic
^!LButton::#!k

; play/pause spotify
;   ctrl+alt+p
;   ctrl+alt+right-click
^!p::
^!RButton::
{
if WinExist("Spotify")
    WinActivate
    Send "{Media_Play_Pause}"
}
^!LButton::#!k

; ctrl+alt+left = prev song spotify
^!left::
{
if WinExist("Spotify")
    WinActivate
    Send "{Media_Prev}"
}

; ctrl+alt+right = next song spotify
^!right::
{
if WinExist("Spotify")
    WinActivate
    Send "{Media_Next}"
}

; ctrl+alt+ up/down  = volume up/down
^!up::      send "{Volume_Up}"
^!down::    send "{Volume_Down}"
