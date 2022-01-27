#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icon.ico
#AutoIt3Wrapper_Outfile=DWM Color.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Description=Afficher les propriétés relatives à la couleur du gestionnaire de fenêtres Windows
#AutoIt3Wrapper_Res_Fileversion=2.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2013 Au'Soft Corporation
#AutoIt3Wrapper_Res_Language=1074
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

	#include <Color.au3>
	#include <Misc.au3>
	#include <GUIConstantsEx.au3>

	Global Const $version = "v. 2.0"
	Global $TIME = 1
	Global $WP_DONE = 0
	Global $AUTO_REFRESH = 1
	Global $REG_DWM_COLOR = ""


	_Get_DWM_COLOR()

	$Gui=GUICreate("DWM Color", 300, 169)
	GUISetFont(9, 400, -1, "Segoe UI", $GUI, 2)
	GUISetBkColor($DWM_COLOR_8)
	$FILE = GUICtrlCreateMenu("Actions")
		$REFRESH = GUICtrlCreateMenuItem("Rafraîchir	F5", $FILE)
			GUICtrlCreateMenuItem("", $FILE)
		$AUTORE = GUICtrlCreateMenuItem("Rafraîchir automatiquement", $FILE)
			GUICtrlSetState($AUTORE, $GUI_CHECKED)
		$TOP = GUICtrlCreateMenuItem("Maintenir la fenêtre au premier plan	Ctrl+T", $FILE)
		GUICtrlCreateMenuItem("", $FILE)
		$EXPORT = GUICtrlCreateMenuItem("Exporter l'historique des couleurs utilisées", $FILE)
		$DELETE = GUICtrlCreateMenuItem("Supprimer les fichiers temporaires", $FILE)
			GUICtrlCreateMenuItem("", $FILE)
		$EXIT = GUICtrlCreateMenuItem("Quitter", $FILE)
	$EDIT = GUICtrlCreateMenu("Edition")
		GUICtrlCreateMenuItem("Copier dans le presse papier :", $EDIT)
			GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlCreateMenuItem("", $EDIT)
		$CLIP_HEX_1 = GUICtrlCreateMenuItem("Copier Hex 1", $EDIT)
		$CLIP_RGB_1 = GUICtrlCreateMenuItem("Copier RGB 1", $EDIT)
		$CLIP_HEX_2 = GUICtrlCreateMenuItem("Copier Hex 2", $EDIT)
		$CLIP_RGB_2 = GUICtrlCreateMenuItem("Copier RGB 2", $EDIT)
	For $i = 1 To 12 Step 1
		GUICtrlCreateMenu("")
		GUICtrlSetState(-1, $GUI_DISABLE)
	Next
	$HELP = GUICtrlCreateMenu("?")
		$ABOUT = GUICtrlCreateMenuItem("A propos...", $HELP)
		GUICtrlCreateMenuItem("", $HELP)
		GUICtrlCreateMenuItem($version, $HELP)
			GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlCreateMenuItem("© 2013 Au'soft Corp.", $HELP)
			GUICtrlSetState(-1, $GUI_DISABLE)
	$COLOR1 = GUICtrlCreateLabel("Hex 1: "&$DWM_COLOR_8&@CRLF&"RGB 1: "&$RGB[0]&"."&$RGB[1]&"."&$RGB[2], 5, 115, 140, 30, 0x01)
		GUICtrlSetColor(-1, $DWM_COLOR_DRK)
		GUICtrlSetBkColor(-1, $DWM_COLOR_8)
	$Label=GUICtrlCreateLabel("", 150, 0, 150, 150)
		GUICtrlSetBkColor(-1, $DWM_COLOR_DRK)
	$COLOR2 = GUICtrlCreateLabel("Hex 2: 0x"&StringRight($DWM_COLOR_DRK, 6)&@CRLF&"RGB 2: "&Round($RGB2[0])&"."&Round($RGB2[1])&"."&Round($RGB2[2]), 155, 115, 140, 30, 0x01)
		GUICtrlSetColor(-1, $DWM_COLOR_8)
		GUICtrlSetBkColor(-1, $DWM_COLOR_DRK)
	GUISetState(@SW_SHOW)
	$TIMER = TimerInit()

	While 1
		If WinActive($Gui) <> 0 Then
			If _ispressed(74) Then
				_Get_DWM_COLOR()
				GUISetState(@SW_LOCK)
				GUISetBkColor($DWM_COLOR_8)
				GUICtrlSetData($COLOR1, "Hex 1: "&$DWM_COLOR_8&@CRLF&"RGB 1: "&$RGB[0]&"."&$RGB[1]&"."&$RGB[2])
				GUICtrlSetBkColor($COLOR1, $DWM_COLOR_8)
				GUICtrlSetColor($COLOR1, $DWM_COLOR_DRK)
				GUICtrlSetBkColor($Label, $DWM_COLOR_DRK)
				GUICtrlSetData($DWM_COLOR_DRK, "Hex 2: 0x"&StringRight($DWM_COLOR_DRK, 6)&@CRLF&"RGB 2: "&Round($RGB2[0])&"."&Round($RGB2[1])&"."&Round($RGB2[2]))
				GUICtrlSetBkColor($COLOR2, $DWM_COLOR_DRK)
				GUICtrlSetColor($COLOR2, $DWM_COLOR_8)
				GUISetState(@SW_UNLOCK)
			ElseIf _IsPressed("11") And _IsPressed("54") Then
				If BitAND(GUICtrlRead($TOP), $GUI_CHECKED) = $GUI_CHECKED Then
					WinSetOnTop($gui, "", 0)
					GUICtrlSetState($TOP, $GUI_UNCHECKED)
				Else
					WinSetOnTop($gui, "", 1)
					GUICtrlSetState($TOP, $GUI_CHECKED)
				EndIf
			EndIf
		EndIf

		$TIMERDIFF = TimerDiff($TIMER)
		If $AUTO_REFRESH = 1 And (Round($TIMERDIFF) = 5000*$TIME Or Round($TIMERDIFF) > 5000*$TIME) Then
			$TIME = $TIME+1
			_Get_DWM_COLOR()
			GUISetState(@SW_LOCK)
			GUISetBkColor($DWM_COLOR_8)
			GUICtrlSetData($COLOR1, "Hex 1: "&$DWM_COLOR_8&@CRLF&"RGB 1: "&$RGB[0]&"."&$RGB[1]&"."&$RGB[2])
			GUICtrlSetBkColor($COLOR1, $DWM_COLOR_8)
			GUICtrlSetColor($COLOR1, $DWM_COLOR_DRK)
			GUICtrlSetBkColor($Label, $DWM_COLOR_DRK)
			GUICtrlSetData($DWM_COLOR_DRK, "Hex 2: 0x"&StringRight($DWM_COLOR_DRK, 6)&@CRLF&"RGB 2: "&Round($RGB2[0])&"."&Round($RGB2[1])&"."&Round($RGB2[2]))
			GUICtrlSetBkColor($COLOR2, $DWM_COLOR_DRK)
			GUICtrlSetColor($COLOR2, $DWM_COLOR_8)
			GUISetState(@SW_UNLOCK)
		EndIf
		Switch GUIGetMsg()
			Case $AUTORE
				If BitAND(GUICtrlRead($AUTORE), $GUI_CHECKED) = $GUI_CHECKED Then
					$AUTO_REFRESH =  0
					GUICtrlSetState($AUTORE, $GUI_UNCHECKED)
				Else
					$AUTO_REFRESH =  1
					GUICtrlSetState($AUTORE, $GUI_CHECKED)
				EndIf
			Case $TOP
				If BitAND(GUICtrlRead($TOP), $GUI_CHECKED) = $GUI_CHECKED Then
					WinSetOnTop($gui, "", 0)
					GUICtrlSetState($TOP, $GUI_UNCHECKED)
				Else
					WinSetOnTop($gui, "", 1)
					GUICtrlSetState($TOP, $GUI_CHECKED)
				EndIf
			Case $DELETE
				FileDelete(@TempDir&"\DWMColor_History.txt")
				WinSetTitle($gui, "", "Fichiers temp. supprimés")
				For $T = 0 to 5000 Step 100
					$mouse = GUIGetCursorInfo($gui)
					If $mouse[2] = 1 Or $mouse[3] = 1 Then
						$T = 5000
					EndIf
					Sleep(100)
				Next
				WinSetTitle($gui, "", "DWM Color")
			Case $EXPORT
				$EXPFILE = FileSaveDialog("Exporter l'historique des couleurs utilisées:", "", ".txt (fichier format texte)")
				If Not @error  Then FileCopy(@TempDir&"\DWMColor_History.txt", $EXPFILE&".txt")
				WinSetTitle($gui, "", "Fichier exporté")
				For $T = 0 to 5000 Step 100
					$mouse = GUIGetCursorInfo($gui)
					If $mouse[2] = 1 Or $mouse[3] = 1 Then
						$T = 5000
					EndIf
					Sleep(100)
				Next
				WinSetTitle($gui, "", "DWM Color")
			Case $REFRESH
				$TIME = $TIME+1
				_Get_DWM_COLOR()
				GUISetState(@SW_LOCK)
				GUISetBkColor($DWM_COLOR_8)
				GUICtrlSetData($COLOR1, "Hex 1: "&$DWM_COLOR_8&@CRLF&"RGB 1: "&$RGB[0]&"."&$RGB[1]&"."&$RGB[2])
				GUICtrlSetBkColor($COLOR1, $DWM_COLOR_8)
				GUICtrlSetColor($COLOR1, $DWM_COLOR_DRK)
				GUICtrlSetBkColor($Label, $DWM_COLOR_DRK)
				GUICtrlSetData($DWM_COLOR_DRK, "Hex 2: 0x"&StringRight($DWM_COLOR_DRK, 6)&@CRLF&"RGB 2: "&Round($RGB2[0])&"."&Round($RGB2[1])&"."&Round($RGB2[2]))
				GUICtrlSetBkColor($COLOR2, $DWM_COLOR_DRK)
				GUICtrlSetColor($COLOR2, $DWM_COLOR_8)
				GUISetState(@SW_UNLOCK)
			Case $CLIP_HEX_1
				ClipPut($DWM_COLOR_8)
				_TIP()
			Case $CLIP_HEX_2
				ClipPut($DWM_COLOR_DRK)
				_TIP()
			Case $CLIP_RGB_1
				ClipPut($RGB[0]&"."&$RGB[1]&"."&$RGB[2])
				_TIP()
			Case $CLIP_RGB_2
				ClipPut(Round($RGB2[0])&"."&Round($RGB2[1])&"."&Round($RGB2[2]))
				_TIP()
			Case $ABOUT
				GUISetState(@SW_MINIMIZE, $Gui)
				Sleep(200)
				GUISetState(@SW_HIDE, $Gui)
				$ABOUT_GUI = GUICreate("DWM Color "&$version, 300, 200, -1, -1, 0x00080000, "",$Gui)
				GUISetIcon(@SystemDir&"\imageres.dll", -77)
				GUISetFont(9, 400, -1, "Segoe UI", $ABOUT_GUI, 2)
				WinSetOnTop($ABOUT_GUI, "", 1)
					GUISetBkColor(0x000000)
				;$OK = GUICtrlCreateButton("Ok", 123, 135, 60, 25)
				;	GUICtrlSetBkColor(-1, $DWM_COLOR_8)
				;	GUICtrlSetColor(-1, $DWM_COLOR_DRK)
				If ($RGB[0]+$RGB[1]+$RGB[2])/3 > 170 Then
					$BT_COLOR = 1
				Else
					$BT_COLOR = 0
				EndIf
				$OK = _WPCreateButton(1, $ABOUT_GUI, "", "", "Ok", 123, 135, 60, 25, $BT_COLOR, $DWM_COLOR_8, $DWM_COLOR_DRK)
				GUICtrlCreateLabel("Ce logiciel et son contenu sont la propriété exclusive d'Augustin Walter"&@CRLF&@CRLF&"Copyright © 2013 Au'Soft Corporation. Tous droits réservés"&@CRLF&@CRLF&"Développé par Augustin Walter", 10,10, 280, 120)
					GUICtrlSetBkColor(-1, 0x000000)
					GUICtrlSetColor(-1, $DWM_COLOR_8)
				GUISetState(@SW_SHOW)
				While 1
					$OK_BT = _WPCreateButton(0, $ABOUT_GUI, $OK, "_OK", "", "", "", "", "", $BT_COLOR, $DWM_COLOR_8, $DWM_COLOR_DRK)
					If $OK_BT = 1 Then ExitLoop
					Switch GUIGetMsg()
						;Case $OK
						;	GUISetState(@SW_SHOW, $Gui)
						;	GUISetState(@SW_RESTORE, $Gui)
						;	GUIDelete($ABOUT_GUI)
						;	ExitLoop
						Case -3
							GUISetState(@SW_SHOW, $Gui)
							GUISetState(@SW_RESTORE, $Gui)
							GUIDelete($ABOUT_GUI)
							ExitLoop
					EndSwitch
				WEnd
				$OK_BT = ""
			Case $EXIT
				Exit
			Case -3
				Exit
		EndSwitch
	WEnd
Func _TIP()
	$guipos = WinGetPos($gui)
	ToolTip(" ", $guipos[0]+90, $guipos[1]+40, "Contenu copié dans le presse papier", 1, 1)
	For $T = 0 to 4000 Step 100
		$mouse = GUIGetCursorInfo($gui)
		If $mouse[2] = 1 Or $mouse[3] = 1 Then
			$T = 4000
		EndIf
		Sleep(100)
	Next
	ToolTip("")
EndFunc

Func _Get_DWM_COLOR()
	If RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM\", "ColorizationColor") <> $REG_DWM_COLOR Then
		Global $REG_DWM_COLOR = RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM\", "ColorizationColor")
		Global $DWM_COLOR_8 = "0x"&StringRight(_DecimalToHex(int(StringStripWS($REG_DWM_COLOR, 8))), 6)
		Global $RGB = _ColorGetCOLORREF($DWM_COLOR_8)
		If @error Then
			MsgBox(16, "ERROR", "_ColorGetCOLORREF()")
			Exit
		EndIf
		Global $RGB2 = ""
		Dim $RGB2[3] = [$RGB[0]/2, $RGB[1]/2, $RGB[2]/2]
		Global $DWM_COLOR_DRK = _ColorSetCOLORREF($RGB2)
		If @error Then
			MsgBox(16, "ERROR", "_ColorSetCOLORREF")
			Exit
		EndIf
		If FileExists(@TempDir&"\DWMColor_History.txt") = 0 Then FileWrite(@TempDir&"\DWMColor_History.txt", "DWM Color History v.2.0 - Copyright © 2013 Au'Soft Corp. All rights reserved.")
		IniReadSection(@TempDir&"\DWMColor_History.txt", $DWM_COLOR_8)
		If @error Then
			IniWrite(@TempDir&"\DWMColor_History.txt", $DWM_COLOR_8, "RGB_Light", $RGB[0]&"."&$RGB[1]&"."&$RGB[2])
			IniWrite(@TempDir&"\DWMColor_History.txt", $DWM_COLOR_8, "Hex_Dark", $DWM_COLOR_DRK)
			IniWrite(@TempDir&"\DWMColor_History.txt", $DWM_COLOR_8, "RGB_Dark", Round($RGB2[0])&"."&Round($RGB[1])&"."&Round($RGB[2]))
			IniWrite(@TempDir&"\DWMColor_History.txt", $DWM_COLOR_8, "Used on", @MDAY&"/"&@MON&"/"&@YEAR&" @ "&@HOUR&"h"&@MIN&"m"&@SEC&"s"&@MSEC&"ms")
		Else
			IniWrite(@TempDir&"\DWMColor_History.txt", $DWM_COLOR_8, "Used on", IniRead(@TempDir&"\DWMColor_History.txt", $DWM_COLOR_8, "Used on", "")&"|"&@MDAY&"/"&@MON&"/"&@YEAR&" @ "&@HOUR&"h"&@MIN&"m"&@SEC&"s"&@MSEC&"ms")
		EndIf
	EndIf
EndFunc

Func _DecimalToHex($hx_dec, $hx_length = 21)
	Local $HX_REF
	If IsInt($hx_dec) = 0 Then
		SetError(1)
        MsgBox(0,"Error","Wrong input, try again ...")
		Return ""
	EndIf
	Local $ret = "", $Ii, $hx_tmp, $hx_max
	If $hx_dec < 4294967296 Then
		If $hx_length < 9 Then Return Hex($hx_dec, $hx_length)
		If $hx_length = 21 Then
			$ret = Hex($hx_dec)
			While StringLeft($ret, 1) = "0"
				$ret = StringMid($ret, 2)
			WEnd
			Return $ret
		EndIf
	EndIf
	For $Ii = $hx_length - 1 To 0 Step -1
		$hx_max = 16 ^ $Ii - 1
		If $ret = "" And $hx_length = 21 And $hx_max > $hx_dec Then ContinueLoop
		$hx_tmp = Int($hx_dec/($hx_max+1))
		If $ret = "" And $hx_length = 21 And $Ii > 0 And $hx_tmp = 0 Then ContinueLoop
		$ret &= StringMid($HX_REF, $hx_tmp+1, 1)
		$hx_dec -= $hx_tmp * ($hx_max + 1)
	Next
	$ret=String($ret)
	If $hx_length < 21 And StringLen($ret) < $hx_length Then SetError(1)
	Return $ret
EndFunc ;==>_DecToHex()

Func _WPCreateButton($CREATE, $WP_GUI, $WP_CTRLUPD="", $WP_FUNCCALL="", $WP_TEXT="", $WP_X=0, $WP_Y=0, $WP_WIDTH=80, $WP_HEIGHT=25, $WP_COLOR=0, $WP_HICOLOR=0xFFFFFF, $WP_CLICKCOLOR=0x000000)
	;$WP_COLOR = 1
	If $WP_COLOR = 0 Then
		$WP_BTSTYLE = 0x09
		$WP_TXTCOLOR = 0xFFFFFF
		$WP__TXTCOLOR = 0x000000
	Else
		$WP_BTSTYLE = 0x07
		$WP_TXTCOLOR = 0x000000
		$WP__TXTCOLOR = 0xFFFFFF
	EndIf
	If $CREATE = 1 Or $CREATE = 2 Then
		$WP_BT_TXT = GUICtrlCreateLabel($WP_TEXT, $WP_X, $WP_Y, $WP_WIDTH, $WP_HEIGHT, BitOR(0x01, 0x0200))
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
			GUICtrlSetFont(-1, 10, 400, 0, "", 2)
			GUICtrlSetColor(-1, $WP_TXTCOLOR)
			$WP_BT = GUICtrlCreateLabel("", $WP_X, $WP_Y, $WP_WIDTH, $WP_HEIGHT, $WP_BTSTYLE)
				GUICtrlSetColor(-1, $WP_TXTCOLOR)
			$WP_BT_2 = 	GUICtrlCreateLabel("", $WP_X+1, $WP_Y+1, $WP_WIDTH-2, $WP_HEIGHT-2, $WP_BTSTYLE)
		If $CREATE = 2 Then
			GUICtrlSetStyle($WP_BT, 0x08)
			GUICtrlSetStyle($WP_BT_2, 0x08)
			GUICtrlSetColor($WP_BT_TXT, 0x808080)
			$WP_DSBL = 1
		Else
			$WP_DSBL = 0
		EndIf
		Dim $RBT[4] = [$WP_BT, $WP_BT_TXT, $WP_BT_2, $WP_DSBL]
		Return $RBT
	Else
		GUISwitch($WP_GUI)
		$WP_MOUSE = GUIGetCursorInfo($WP_GUI)
		$CTRL_POS = ControlGetPos($WP_GUI, "", $WP_CTRLUPD[0])
		If $WP_CTRLUPD[3] <> 1 And $WP_MOUSE[0] > $CTRL_POS[0] And $WP_MOUSE[1] > $CTRL_POS[1] And $WP_MOUSE[0] < $CTRL_POS[0]+$CTRL_POS[2] And $WP_MOUSE[1] < $CTRL_POS[1]+$CTRL_POS[3] Then
			If $WP_DONE = 0 Then
				GUICtrlSetBkColor($WP_CTRLUPD[1], $WP_HICOLOR)
				$WP_DONE = 1
			EndIf
			If $WP_MOUSE[2] = 1 Then
				GUICtrlSetColor($WP_CTRLUPD[1], $WP__TXTCOLOR)
				GUICtrlSetBkColor($WP_CTRLUPD[1], $WP_CLICKCOLOR)
				While 1
					$WP_MOUSE = GUIGetCursorInfo($WP_GUI)
					If $WP_MOUSE[2] = 0 Then ExitLoop
				WEnd
				Call($WP_FUNCCALL)
				Return 1
				GUICtrlSetColor($WP_CTRLUPD[1], $WP_TXTCOLOR)
				GUICtrlSetBkColor($WP_CTRLUPD[1], $GUI_BKCOLOR_TRANSPARENT)
			EndIf
		Else
			If $WP_DONE = 1  Then
				GUICtrlSetColor($WP_CTRLUPD[1], $WP_TXTCOLOR)
				GUICtrlSetBkColor($WP_CTRLUPD[1], $GUI_BKCOLOR_TRANSPARENT)
				$WP_DONE = 0
			EndIf
		EndIf
	EndIf
EndFunc

Func _OK()
	GUISetState(@SW_SHOW, $Gui)
	GUISetState(@SW_RESTORE, $Gui)
	GUIDelete($ABOUT_GUI)
EndFunc
