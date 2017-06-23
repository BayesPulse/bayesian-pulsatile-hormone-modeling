Option Explicit

'VBScript doesn't support importing constants, so these 
'are for fso.opentextfile
Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8
Const xlsCSV = 6

Dim objExcel, fso, output
Set fso = CreateObject("Scripting.FileSystemObject")
set output = fso.OpenTextFile(WScript.Arguments(0), ForWriting)

On Error Resume Next
Set objExcel = CreateObject("Excel.Application")
if objExcel is Nothing then
	output.writeLine("NO")
else
	output.writeLine("YES")
end if

output.close()
Set fso = Nothing
Set objExcel = Nothing
