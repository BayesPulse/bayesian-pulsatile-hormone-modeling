On Error Resume Next
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
fso.DeleteFolder ("C:\Users\liuhuay\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\pulse_xp")
fso.DeleteFile ("C:\Users\liuhuay\Desktop\pulse_xp.lnk")
fso.DeleteFolder ("C:\Users\liuhuay\AppData\Roaming\pulse_xp")
