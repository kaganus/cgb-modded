; #FUNCTION# ====================================================================================================================
; Name ..........: PushBulle
; Description ...: This function will report to your mobile phone your values and last attack
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Antidote (2015-03)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================


#include <Array.au3>
#include <String.au3>

Func _RemoteControl()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Get", "https://api.pushbullet.com/v2/pushes?active=true", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
	$Result = $oHTTP.ResponseText

	If StringRegExp($Result, '(?i)"title":"bot') = 1 Then
		Local $title = _StringBetween($Result, '"title":"', '"', "", False)
		Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)

		For $x = 0 To UBound($title) - 1
			If $title <> "" Or $iden <> "" Then
				$title[$x] = StringUpper(StringStripWS($title[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES))
				$iden[$x] = StringStripWS($iden[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

				If $title[$x] = "BOT HELP" Then
					_Push($iPBVillageName & ": Request for Help", "You can remotely control your bot using the following command format\nEnter Bot <command> in the Title message\n\n<command> is:\nPause - pause the bot\nResume - resume the bot\nStats - village report\nLogs - send the current log file\nDelete - Delete all previous Push messages\nLastRaid - send last raid screenshot\nHelp - send this help message")
					SetLog("Your request has been received. Help has been sent")
					_DeleteMessage($iden[$x])
			 	ElseIf $title[$x] = "BOT PAUSE" Then
					SetLog("Your request has been received.")
					_DeleteMessage($iden[$x])
					TogglePauseImpl("Push")
				ElseIf $title[$x] = "BOT RESUME" Then
					SetLog("Your request has been received.")
					_DeleteMessage($iden[$x])
					TogglePauseImpl("Push")
				ElseIf $title[$x] = "BOT DELETE" Then
					_DeletePush()
					SetLog("Your request has been received.")
					_Push($iPBVillageName & ": Request to Delete Push messages...", "All your previous Push messages are deleted...")
				ElseIf $title[$x] = "BOT STATS" Then
					SetLog("Your request has been received. Statistics sent")
					_Push($iPBVillageName & ": Village Report, My Lord...", "Here are your Resources at Start\n-[G]: " & _NumberFormat($GoldStart) & "\n-[E]: " & _NumberFormat($ElixirStart) & "\n-[D]: " & _NumberFormat($DarkStart) & " \n-[T]: " & $TrophyStart & "\n\nNow (Current Resources)\n-[G]: " & _NumberFormat($GoldVillage) & "\n-[E]: " & _NumberFormat($ElixirVillage) & "\n-[D]: " & _NumberFormat($DarkVillage) & "\n-[T]: " & $TrophyVillage & "\n\n-[GEM]: " & $GemCount & "\n [No. of Free Builders]: " & $FreeBuilder & "\n [No. of Wall Up]: G: " & $wallgoldmake & "/ E: " & $wallelixirmake & "\n\nAttacked: " & GUICtrlRead($lblresultvillagesattacked) & "\nSkipped: " & GUICtrlRead($lblresultvillagesskipped))
					_DeleteMessage($iden[$x])
				ElseIf $title[$x] = "BOT LOGS" Then
					SetLog("Your request has been received. Log is now sent")
					_PushFile($sLogFName, "logs", "text/plain; charset=utf-8", $iPBVillageName & ": Current Logs", $sLogFName)
					_DeleteMessage($iden[$x])
				ElseIf $title[$x] = "BOT LASTRAID" Then
					SetLog("Your request has been received.")
					If $iImageLoot <> "" Then
					   _PushFile($iImageLoot, "Loots", "image/jpeg", $iPBVillageName & ": Last Raid", $iImageLoot)
				    	Else
						_Push($iPBVillageName & ": There is no last raid screenshot", "")
					EndIf
					 _DeleteMessage($iden[$x])
				ElseIf $title[$x] = "BOT RESTART" Then
					SetLog("Your request has been received. Bot is now restarting")
					_Push($iPBVillageName & ": Request to Restart", "Your bot is being restarted")
					_DeleteMessage($iden[$x])
					_Restart()
				EndIf
				$title[$x] = ""
				$iden[$x] = ""
			EndIf
		Next
	EndIf
EndFunc   ;==>RemoteControl

Func _PushBullet($pTitle = "", $pMessage = "")
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Get", "https://api.pushbullet.com/v2/devices", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.Send()
	$Result = $oHTTP.ResponseText
	Local $device_iden = _StringBetween($Result, 'iden":"', '"')
	Local $device_name = _StringBetween($Result, 'nickname":"', '"')
	Local $device = ""
	Local $pDevice = 1
	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '"}'
	$oHTTP.Send($pPush)
EndFunc   ;==>PushBullet

Func _Push($pTitle, $pMessage)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '"}'
	$oHTTP.Send($pPush)
 EndFunc   ;==>Push

Func _PushFile($File, $Folder, $FileType, $title, $body)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/upload-request", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")

	Local $pPush = '{"file_name": "' & $File & '", "file_type": "' & $FileType & '"}'
	$oHTTP.Send($pPush)
	$Result = $oHTTP.ResponseText

	Local $upload_url = _StringBetween($Result, 'upload_url":"', '"')
	Local $awsaccesskeyid = _StringBetween($Result, 'awsaccesskeyid":"', '"')
	Local $acl = _StringBetween($Result, 'acl":"', '"')
	Local $key = _StringBetween($Result, 'key":"', '"')
	Local $signature = _StringBetween($Result, 'signature":"', '"')
	Local $policy = _StringBetween($Result, 'policy":"', '"')
	Local $file_url = _StringBetween($Result, 'file_url":"', '"')

	$Result = RunWait(@ScriptDir & "\bin\curl.exe -i -X POST " & $upload_url[0] & ' -F awsaccesskeyid="' & $awsaccesskeyid[0] & '" -F acl="' & $acl[0] & '" -F key="' & $key[0] & '" -F signature="' & $signature[0] & '" -F policy="' & $policy[0] & '" -F content-type="' & $FileType & '" -F file=@"' & @ScriptDir & '\' & $Folder & '\' & $File & '"', "", @SW_HIDE)

	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	Local $pPush = '{"type": "file", "file_name": "' & $File & '", "file_type": "' & $FileType & '", "file_url": "' & $file_url[0] & '", "title": "' & $title & '", "body": "' & $body & '"}'
	$oHTTP.Send($pPush)
	$Result = $oHTTP.ResponseText
EndFunc   ;==>PushFile

Func ReportPushBullet()

	If $iLastAttack = 1 Then
		If $GoldLast <> "" Or $ElixirLast <> "" Then
			_Push($iPBVillageName & ": Last Gain", " [G]: " &  _NumberFormat($GoldLast) & " [E]: " &  _NumberFormat($ElixirLast) & " [D]: " &  _NumberFormat($DarkLast) & "  [T]: " & _NumberFormat($TrophyLast))
		EndIf
	EndIf

	If $iAlertPBVillage = 1 Then
		_Push($iPBVillageName & ": My Village", " [G]: " &  _NumberFormat($GoldCount) & " [E]: " &  _NumberFormat($ElixirCount) & " [D]: " &  _NumberFormat($DarkCount) & "  [T]: " &  _NumberFormat($TrophyCount) & " [FB]: " &  _NumberFormat($FreeBuilder))
	EndIf

EndFunc   ;==>ReportPushBullet


Func _DeletePush()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>DeletePush

Func ReportMatchFound()
	If $pEnabled = 1 AND $pMatchFound = 1 Then
		_Push($iPBVillageName & ": Match Found After " & StringFormat("%3s", $SearchCount) & " skip(s)", " [G]: " & _NumberFormat($searchGold) & " [E]: " & _NumberFormat($searchElixir) & " [D]: " & _NumberFormat($searchDark) & " [T]: " & _NumberFormat($searchTrophy) & " [M]: " & $iradAttackModeString)
	Endif
EndFunc   ;==>ReportMatchFound

Func ReportWallUpgrade()
	If $pEnabled = 1 AND $pWallUpgrade = 1 Then 
		_Push($iPBVillageName & ": Found Wall level " & $icmbWalls+4 , "Wall segment has been located...\nUpgrading ...")
	EndIf
EndFunc   ;==>ReportWallUpgrade

Func ReportWallUpgradeFailed()
	If $pEnabled = 1 AND $pWallUpgrade = 1 Then 
		_Push($iPBVillageName & ": Cannot find Wall level " & $icmbWalls+4 , "Skip upgrade ...")
	EndIf
EndFunc   ;==>ReportWallUpgradeFailed

Func ReportBreak()
	If $pEnabled = 1 AND $pTakeAbreak = 1 Then 
		_Push($iPBVillageName & ": Village must take a break", "")
	EndIf
EndFunc   ;==>ReportBreak

Func ReportCoCStopped()
	If $pEnabled = 1 AND $pOOS = 1 Then 
		_Push($iPBVillageName & ": CoC Has Stopped Error", "")
	EndIf
EndFunc   ;==>ReportCoCStopped

Func _DeleteMessage($iden)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes/" & $iden, False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>_DeleteMessage
