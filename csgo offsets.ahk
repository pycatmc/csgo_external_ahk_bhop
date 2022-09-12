#NoEnv
#SingleInstance, Force
ListLines, Off

Global dwLocalPlayer
Global dwMouseEnablePtr
Global m_fFlags

Read_csgo_offsets_from_hazedumper() {
	UrlDownloadToFile, https://raw.githubusercontent.com/frk1/hazedumper/master/csgo.toml, %a_scriptdir%/csgo.toml

	Loop, Read, %a_scriptdir%/csgo.toml
	{
		if InStr(A_LoopReadLine, "dwLocalPlayer") {
			dwLocalPlayer := RegExReplace(A_LoopReadLine, "dwLocalPlayer = ", "")
		} 
		Else if InStr(A_LoopReadLine, "dwMouseEnablePtr") {
			dwMouseEnablePtr := RegExReplace(A_LoopReadLine, "dwMouseEnablePtr = ", "")
		} 
		Else if InStr(A_LoopReadLine, "m_fFlags") {
			m_fFlags := RegExReplace(A_LoopReadLine, "m_fFlags = ", "")
		}
	}
	Return True
}
