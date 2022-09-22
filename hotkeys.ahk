SC027::SC027
3 & h::Left
3 & j::Down
3 & k::Up
3 & l::Right
SC027 & e::Send ^{Right}
SC027 & b::Send ^{Left}
SC027 & i::Home
SC027 & a::End
SC027 & j::PgDn
SC027 & k::PgUp

; https://gist.github.com/volks73/1e889e01ad0a736159a5d56268a300a8
*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return

*CapsLock up::
    If ((A_TickCount-cDown)<200)  ; Modify press time as needed (milliseconds)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return