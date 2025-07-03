#space::Run X:\downloads\explorer++_1.3.5_x64\Explorer++.exe

#IfWinActive ahk_class SunAwtFrame
.::
Send ->
return


#IfWinActive ahk_class SunAwtFrame
^.::
Send .
return


