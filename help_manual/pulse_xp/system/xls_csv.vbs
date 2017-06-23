Option Explicit

'VBScript doesn't support importing constants, so these 
'are for fso.opentextfile
Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8
Const xlsCSV = 6

Dim objExcel, fso, paramFile, errorFileName
Dim outFileName, inFileName, errorFile
Set fso = CreateObject("Scripting.FileSystemObject")
set paramFile = fso.OpenTextFile(WScript.Arguments(0), ForReading)

errorFileName = paramFile.readLine()
inFileName = paramFile.readLine()
outFileName = paramFile.readLine()

paramFile.close()

On Error Resume Next
Set objExcel = CreateObject("Excel.Application")
if objExcel is Nothing then
	Set errorFile = fso.OpenTextFile(errorFileName, ForWriting, true)
	errorFile.writeLine("Error: Excel not present")
	errorFile.close()
	wscript.quit()
end if
On Error Goto 0
objExcel.WorkBooks.Open fso.GetAbsolutePathName(inFileName)
Dim objSheet
Set objSheet = objExcel.ActiveWorkbook.Worksheets(1)

objExcel.Application.DisplayAlerts = False
objSheet.SaveAs fso.GetAbsolutePathName(outFileName) , xlsCSV
objExcel.ActiveWorkbook.Close
objExcel.Application.Quit

Set objExcel = Nothing
Set objSheet = Nothing

Set errorFile = fso.OpenTextFile(errorFileName, ForWriting, true)
errorFile.writeLine("OK")
errorFile.close()
Set fso = Nothing
