; #FUNCTION# ====================================================================================================================
; Name ..........: checkTownhall
; Description ...: This file Includes the Variables and functions to detection the level of a TH
; Syntax ........: checkTownhall()
; Parameters ....: None
; Return values .: $THx, $THy
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Global $atkTHADV[5][16]

$atkTHADV[0][0] = @ScriptDir & "\images\TH\6.bmp"

$atkTHADV[1][0] = @ScriptDir & "\images\TH\th7btm.png"
$atkTHADV[1][1] = @ScriptDir & "\images\TH\th7top.png"
$atkTHADV[1][2] = @ScriptDir & "\images\TH\7.bmp"
$atkTHADV[1][3] = @ScriptDir & "\images\TH\th7b.bmp"
$atkTHADV[1][4] = @ScriptDir & "\images\TH\th7c.bmp"
$atkTHADV[1][5] = @ScriptDir & "\images\TH\th7d.bmp"
$atkTHADV[1][6] = @ScriptDir & "\images\TH\th7e.bmp"
$atkTHADV[1][7] = @ScriptDir & "\images\TH\th7f.bmp"
$atkTHADV[1][8] = @ScriptDir & "\images\TH\th7g.bmp"
$atkTHADV[1][9] = @ScriptDir & "\images\TH\th7h.bmp"
$atkTHADV[1][10] = @ScriptDir & "\images\TH\th7i.bmp"
$atkTHADV[1][11] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th7j.bmp"
$atkTHADV[1][12] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th7k.bmp"

$atkTHADV[2][0] = @ScriptDir & "\images\TH\th8top.png"
$atkTHADV[2][1] = @ScriptDir & "\images\TH\th8btm.png"
$atkTHADV[2][2] = @ScriptDir & "\images\TH\th8btm2.png"
$atkTHADV[2][3] = @ScriptDir & "\images\TH\th8btm3.png"
$atkTHADV[2][4] = @ScriptDir & "\images\TH\8.bmp"
$atkTHADV[2][5] = @ScriptDir & "\images\TH\th8b.bmp"
$atkTHADV[2][6] = @ScriptDir & "\images\TH\th8c.bmp"
$atkTHADV[2][7] = @ScriptDir & "\images\TH\th8d.bmp"
$atkTHADV[2][8] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8e.bmp"
$atkTHADV[2][9] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8f.bmp"
$atkTHADV[2][10] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8g.bmp"


$atkTHADV[3][0] = @ScriptDir & "\images\TH\9.bmp"
$atkTHADV[3][1] = @ScriptDir & "\images\TH\th9b.bmp"
$atkTHADV[3][2] = @ScriptDir & "\images\TH\th9c.bmp"
$atkTHADV[3][3] = @ScriptDir & "\images\TH\th9d.bmp"
$atkTHADV[3][4] = @ScriptDir & "\images\TH\th9e.bmp"
$atkTHADV[3][5] = @ScriptDir & "\images\TH\th9f.bmp"
$atkTHADV[3][6] = @ScriptDir & "\images\TH\th9g.bmp"
$atkTHADV[3][7] = @ScriptDir & "\images\TH\th9h.bmp"
$atkTHADV[3][8] = "*Trans0xED1C24 "& @ScriptDir & "\images\TH\th9i.bmp"
$atkTHADV[3][9] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th9j.bmp"
$atkTHADV[3][10] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th9k.bmp"
$atkTHADV[3][11] = @ScriptDir & "\images\TH\th9btm_lt.png"
$atkTHADV[3][12] = @ScriptDir & "\images\TH\th9btm_lt2.png"
$atkTHADV[3][13] = @ScriptDir & "\images\TH\th9btm_mt.png"
$atkTHADV[3][14] = @ScriptDir & "\images\TH\th9top_mt.png"
$atkTHADV[3][15] = @ScriptDir & "\images\TH\th9top_0t.png"


$atkTHADV[4][0] = @ScriptDir & "\images\TH\10.bmp"
$atkTHADV[4][1] = @ScriptDir & "\images\TH\th10b.bmp"
$atkTHADV[4][2] = @ScriptDir & "\images\TH\th10c.bmp"
$atkTHADV[4][3] = @ScriptDir & "\images\TH\th10d.bmp"
$atkTHADV[4][4] = @ScriptDir & "\images\TH\th10e.bmpx" ;false positives
$atkTHADV[4][5] = @ScriptDir & "\images\TH\th10f.bmp"
$atkTHADV[4][6] = @ScriptDir & "\images\TH\th10g.bmp"
$atkTHADV[4][7] = @ScriptDir & "\images\TH\th10h.bmp"
$atkTHADV[4][8] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10i.bmp"
$atkTHADV[4][9] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10j.bmp"
$atkTHADV[4][10] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10k.bmp"
$atkTHADV[4][11] = @ScriptDir & "\images\TH\th10btm.png"
$atkTHADV[4][12] = @ScriptDir & "\images\TH\th10btm_ht.png"

Global $thinfo
Global $atkTH[5]
For $i = 0 To 4
   $atkTH[$i] = @ScriptDir & "\images\TH\" & $i+6 & ".bmp"
Next

Local $Tolerance1[5] = [80, 80, 80, 80, 80]

;Global $ToleranceTH[5][11]=[ [70,0,0,0,0,0,0,0,0,0,0],[70,70,70,70,70,70,70,70,70,120,120],[70,70,70,70,120,120,120,0,0,0,0],[70,70,70,70,70,70,70,70,120,120,120],[70,70,70,70,70,70,70,70,120,120,120] ]
Global $ToleranceTH[5][16]=[ [70,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[12,12,70,70,70,70,70,70,70,70,70,120,120,0,0,0],[8,8,8,8,70,70,70,70,120,120,120,0,0,0,0,0],[70,70,70,70,70,70,70,70,120,120,120,10,10,15,15,5],[70,70,70,70,70,70,70,70,120,120,120,10,15,0,0,0] ]


Func checkTownhall()
	   _CaptureRegion()
	  For $i = 0 To 4
	   $THLocation = _ImageSearch($atkTH[$i], 1, $THx, $THy, $Tolerance1[$i]) ; Getting TH Location
	   If $THLocation = 1 Then
		   If FilterTH()=True Then Return $THText[$i]
	   EndIf
	  Next
   If $THLocation = 0 Then Return "-"
   EndFunc

   Func   checkTownhallADV()
	_CaptureRegion()
	For $t=0 to 4
		 For $i = 0 To 13
			   If FileExists($atkTHADV[$t][$i]) Then
					 $THLocation = _ImageSearch($atkTHADV[$t][$i], 1, $THx, $THy, $ToleranceTH[$t][$i]) ; Getting TH Location
					 If $THLocation = 1 Then
					 $thinfo = $ToleranceTH[$t][$i]&"-"&$THx&","&$THy
						   If FilterTH()=True Then Return $THText[$t]
					 EndIf
			   EndIf
		 Next
	Next
   If $THLocation = 0 Then Return "-"
EndFunc
