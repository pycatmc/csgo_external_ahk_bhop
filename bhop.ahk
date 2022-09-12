#Include classMemory.ahk
#Include csgo offsets.ahk

#NoEnv
#Persistent
#InstallKeybdHook
#SingleInstance, Force
DetectHiddenWindows, On
SetKeyDelay,-1, -1
SetControlDelay, -1
SetMouseDelay, -1
SendMode Input
SetBatchLines,-1
ListLines, Off

/* 
	External AHK Bhop by pycat#6987
	Script based on github.com/worse-666/csgo_external_ahk_hack 
*/


if !Read_csgo_offsets_from_hazedumper() {
	MsgBox, 48, Error, Failed to get csgo offsets!
    ExitApp
}
if (_ClassMemory.__Class != "_ClassMemory") {
    msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten
    ExitApp
}


Process, Wait, csgo.exe
Global csgo := new _ClassMemory("ahk_exe csgo.exe", "", hProcessCopy)
Global client := csgo.getModuleBaseAddress("client.dll")
MsgBox, You can bhop now!

IsMouseEnable() {
	Return !((csgo.read(client + dwMouseEnablePtr + 0x30, "Uint") ^ dwMouseEnablePtr) & 0xF)
}

*Space::
	Send, {Blind}{Space}
	Loop {
		GetKeyState, SpaceState, Space, P 
		If SpaceState = U
		break

		Global LocalPlayer := csgo.read(client + dwLocalPlayer, "Uint")
		Global PlayerStatus := csgo.read(LocalPlayer + m_fFlags, "Uint")

		if (WinActive("ahk_exe csgo.exe") && !IsMouseEnable() && (PlayerStatus = 257 or PlayerStatus = 263)) {
			Send, {Blind}{Space}
		}
	}
