
^,::

Var=ABCDEFGHIJKLMNOPQRSTUVWXYZ
Var2=0123456789

Loop 26 {
	send % SubStr(Var, A_Index , 1)
	sleep 1
	send {BS}
}

Return

