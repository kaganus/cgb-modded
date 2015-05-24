; #FUNCTION# ====================================================================================================================
; Name ..........: checkDElixS
; Description ...: This file Includes the detection of Dark Elixir Storage and the attack funtion
; Syntax ........: checkDarkElix() , DropLSpell (), DEAttack ()
; Parameters ....: None
; Return values .: $DESLoc #$DESLocx,$DESLocy
; Author ........: ProMac (2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Global $atkDElix[36]
Global $Tolerance3 = 75
Local $DESpellProcede = 0

For $i = 0 To 35
	$atkDElix[$i] = @ScriptDir & "\images\DElixS\" & $i+1 & ".bmp"
Next

Func checkDarkElix()

$DESpellProcede = 0
If $bBtnAttackNowPressed = True Then
	$DESpellProcede = $ichkAtkNowLSpell
Else
	$DESpellProcede = $iChkLightSpell
EndIf
If $DESpellProcede = 1 Then
      _CaptureRegion(230,170,630,440)
     If _Sleep(500) Then Return
     For $i = 0 To 35
		; SetLog (" For $i =" & $i )  ; <-----  this must be deleted after all tests are
	    $DESLoc = _ImageSearch($atkDElix[$i], 1, $DESLocx, $DESLocy, $Tolerance3)
       ;$DESLoc = _ImageSearchArea($atkDElix[$i], 1, 120, 120 , 765, 550, $DESLocx, $DESLocy, $Tolerance1)
	   ;if $DESLocy > 585 or $DESLocx < 60 Then ; Botton-Slot of troops and Top-XP , Builders and shield
	   ;$DESLoc  = 0
       ;endif
       ;if $DESLocx < 217 and $DESLocy < 175 Then ; Left/Up corner
	   ;$DESLoc  = 0
       ;endif
	   ;if $DESLocx < 236 and $DESLocy > 465 Then ; Left/down corner
	   ;$DESLoc  = 0
       ;endif
       ;if $DESLocx > 661 and $DESLocy > 453 Then ; right/down corner
	   ;$DESLoc  = 0
       ;endif
       ;if $DESLocx > 623 and $DESLocy < 145 Then  ; right/UP corner
	   ;$DESLoc  = 0
       ;endif

	 If $DESLoc = 1 Then
	    $DESLocx += 230
		$DESLocy += 170
	    SetLog("== DarkElix pic:[" & $i+1 & "] " & " • [" & $DESLocx & ", " & $DESLocy & "] • Tolerance [" & $Tolerance3 &"] found ==")
		Return $DESLoc
     EndIf
   Next
	  If $DESLoc = 0 Then
	   SetLog(" == DarkElix() :("& $i+1 & ")" & "• Storage Empty or Not Found")
	   $DESLocx = 0
	   $DESLocy = 0
	   Return $DESLoc
     EndIf
  Else
   ;SetLog("== Attacking DE Storage • Unchecked ==")
Endif
EndFunc
	;######################################### INFO ####################################

	;Town Hall Level	 % Available to be Stolen	Cap	Storage Amount to Reach Cap
       ;7	                        6%	                1,200	     20,000
       ;8	                        6%	                2,000	     33,333
	   ;9                        	5%	                2,500	     50,000
	   ;10	                        4%	                3,000	     75,000

	;###################################################################################

Func DropLSpell ()
  $DESpellProcede = 0
  If $bBtnAttackNowPressed = True Then
  	$DESpellProcede = $ichkAtkNowLSpell
  Else
  	$DESpellProcede = $iChkLightSpell
  EndIf
  If $DESpellProcede = 1 Then
        $LSpell = -1
		$LSpellQ = 0
       For $i = 0 To 8
          ;############## LSpell Slot and Quantity ###########
			If $atkTroops[$i][0] = $eLSpell Then
				$LSpell = $i
				$LSpellQ = Number ($atkTroops[$i][1])
		  ;############## LSpell detection and Quantity ###########
			EndIf
	   Next

	    If (($DESLoc = 1) And $LSpell <> -1 ) Then
			If (Number(getDarkElixir(51, 66 + 57)) >= Number($SpellMinDarkStorage)) then
			     If $LSpellQ >= $iLSpellQ then
				   Click(68 + (72 * $LSpell), 595) ;Select Troop
				   If _Sleep(SetSleep(1)) Then Return
				   Click($DESLocx, $DESLocy, $LSpellQ , 250)   ; $LSpellQ = $atkTroops[$i][1] = quantity of spells
				   SetLog("== Attacking DE Storage with: " & $LSpellQ &" Spells ==")
				   If $zapandrunAvoidAttack = 1 Then
				     $zapandrunAvoidAttack = 2 ; 2 means zapandrun was successful
				   EndIf
			     Else
				   SetLog("== Not Enough Amount of Lightning Spells  ==", $COLOR_RED)
			     EndIf
			Else
			  SetLog("== Not Enough DE to waste Lightning Spells  ==", $COLOR_RED)
			Endif
	    Else

	    EndIf
 EndIf
		If _Sleep(SetSleep(1)) Then Return

EndFunc

Func DEAttack()

	$DESpellProcede = 0
	If $bBtnAttackNowPressed = True Then
		$DESpellProcede = $ichkAtkNowLSpell
	Else
		$DESpellProcede = $iChkLightSpell
	EndIf
	If $DESpellProcede = 1 Or ($DESideAtk = 1) Then
		;SetLog("Start Function ")
		_WinAPI_DeleteObject($hBitmapFirst)
		$hBitmapFirst = _CaptureRegion2(230, 170, 630, 440)
		;SetLog("BitmapFirst done")

		$DESTOLoc = GetLocationDarkElixirStorage()

		;SetLog("Dll Return location")
		If (UBound($DESTOLoc) > 1) Then
			Local $centerPixel[2] = [430, 313]
			Local $arrPixelCloser = _FindPixelCloser($DESTOLoc, $centerPixel, 1)
			$pixel = $arrPixelCloser[0]
		ElseIf (UBound($DESTOLoc) > 0) Then
			$pixel = $DESTOLoc[0]
		Else
			$pixel = -1
		EndIf
		If $pixel = -1 Then
			$DESLoc = 0
			SetLog(" == DE Storage Not Found ==")
		Else
			$pixel[0] += 230 ; compensate CaptureRegion reduction
			$pixel[1] += 170 ; compensate CaptureRegion reduction
			SetLog("== DE lixir Storage : [" & $pixel[0] & "," & $pixel[1] & "] ==", $COLOR_BLUE)
			If _Sleep(1000) Then Return
			$DESLocx = $pixel[0] ; compensation for $x center of Storage
			$DESLocy = $pixel[1] ; compensation for $y center of Storage
			$DESLoc = 1
		EndIf
	EndIf

EndFunc   ;==>DEAttack

Func GetDEEdge() ;Using $DESLoc x y we are finding which side de is located.
   If $DESLoc = 1 Then
	  If ($DESLocx = 430) And  ($DESLocy = 313) Then
		 SetLog ("DE Storage Located in Middle... Attacking Bottom Right", $COLOR_BLUE)
		 $DEEdge = 0
	  ElseIf ($DESLocx >= 430) And  ($DESLocy >= 313) Then
		 SetLog ("DE Storage Located Bottom Right... Attacking Bottom Right", $COLOR_BLUE)
		 $DEEdge = 0
	  ElseIf ($DESLocx > 430) And  ($DESLocy < 313) Then
		 SetLog ("DE Storage Located Top Right... Attacking Top Right", $COLOR_BLUE)
		 $DEEdge = 3
	  ElseIf ($DESLocx <= 430) And  ($DESLocy <= 313) Then
		 SetLog ("DE Storage Located Top Left... Attacking Top Left", $COLOR_BLUE)
		 $DEEdge = 1
	  ElseIf ($DESLocx < 430) And  ($DESLocy > 313) Then
		 SetLog ("DE Storage Located Bottom Left... Attacking Bottom Left", $COLOR_BLUE)
		 $DEEdge = 2
	  EndIf
   ElseIf $DESLoc = 0 Then
	  SetLog ("DE Storage Not Located... Attacking Bottom Right", $COLOR_BLUE)
	  $DEEdge = 0
   EndIf
EndFunc   ;==>GetDEEdge

