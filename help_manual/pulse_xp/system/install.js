var shell,fso,sname,programs,shortcut,ts,package;

fso = new ActiveXObject("scripting.FileSystemObject");

shell = WScript.CreateObject("WScript.Shell");

sname = WScript.ScriptFullName;

package = fso.GetFileName(fso.GetParentFolderName(fso.GetParentFolderName(sname)));

// replace template with the package name
programs = shell.SpecialFolders("Programs") + "\\" + package;

// create temp directory if itn is missing
if (!fso.FolderExists (fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\temp"))
		fso.CreateFolder (fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\temp");

// create start menu folder
if (!fso.FolderExists (programs))
		fso.CreateFolder (programs);

// ApEn link
shortcut = shell.CreateShortcut(programs + "\\ApEn.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\ApEn.ico";
shortcut.Arguments = " -ApEn ";
shortcut.Save () ;

// autodecon link
shortcut = shell.CreateShortcut(programs + "\\AutoDecon.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\autodecon.ico";
shortcut.Arguments = " -autodecon ";
shortcut.Save () ;

// Cluster8 link
shortcut = shell.CreateShortcut(programs + "\\Cluster8.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\cluster8.ico";
shortcut.Arguments = " -cluster8 ";
shortcut.Save () ;

// Cosine link
shortcut = shell.CreateShortcut(programs + "\\Cosine.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Cosine.ico";
shortcut.Arguments = " -cosine ";
shortcut.Save () ;

// Concordance link
shortcut = shell.CreateShortcut(programs + "\\Concordance.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Concord.ico";
shortcut.Arguments = " -concordance ";
shortcut.Save () ;

// deconv link
shortcut = shell.CreateShortcut(programs + "\\Deconv.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\deconv.ico";
shortcut.Arguments = " -deconv ";
shortcut.Save () ;

// DOS link
shortcut = shell.CreateShortcut(programs + "\\DOS.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\dos.ico";
shortcut.Arguments = " -SHELL ";
shortcut.Save () ;

// EDITFILE link
shortcut = shell.CreateShortcut(programs + "\\EditFile.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\editfile.ico";
shortcut.Arguments = " -EDIT ";
shortcut.Save () ;

// FOLDER link
shortcut = shell.CreateShortcut(programs + "\\Folder.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\FOLDER.ico";
shortcut.Arguments = " -CD ";
shortcut.Save () ;

// Graf_FIX link
shortcut = shell.CreateShortcut(programs + "\\Graf_FIX.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Graf_FIX.ico";
shortcut.Arguments = " -CLUSTER8 ";
shortcut.Save () ;

// grf_view link
shortcut = shell.CreateShortcut(programs + "\\Grf_View.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\grf_view.ico";
shortcut.Arguments = " -grf_view ";
shortcut.Save () ;

// help link
shortcut = shell.CreateShortcut(programs + "\\Help.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\help.ico";
shortcut.Arguments = " -HELP ";
shortcut.Save () ;

// general program link
shortcut = shell.CreateShortcut(programs + "\\hormone.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.Arguments = " ";
shortcut.Save () ;

// Outlier link
shortcut = shell.CreateShortcut(programs + "\\Outlier.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Outlier.ico";
shortcut.Arguments = " -autodecon ";
shortcut.Save () ;

// Periodic link
shortcut = shell.CreateShortcut(programs + "\\Periodic.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Periodic.ico";
shortcut.Arguments = " -Periodic ";
shortcut.Save () ;

// Print link
shortcut = shell.CreateShortcut(programs + "\\Print.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\printer.ico";
shortcut.Arguments = " -PRINT ";
shortcut.Save () ;

// Pulse link
shortcut = shell.CreateShortcut(programs + "\\Pulse.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Pulse.ico";
shortcut.Arguments = " -Pulse ";
shortcut.Save () ;

// Pulse2 link
shortcut = shell.CreateShortcut(programs + "\\Pulse2.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Pulse2.ico";
shortcut.Arguments = " -Pulse2 ";
shortcut.Save () ;

// SRQuant link
shortcut = shell.CreateShortcut(programs + "\\SRQuant.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\SRQuant.ico";
shortcut.Arguments = " -SRQuant ";
shortcut.Save () ;

// Pulse4 link
shortcut = shell.CreateShortcut(programs + "\\Pulse4.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Pulse4.ico";
shortcut.Arguments = " -Pulse4 ";
shortcut.Save () ;

// Correlation link
shortcut = shell.CreateShortcut(programs + "\\Correlation.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Corr.ico";
shortcut.Arguments = " -Correlation ";
shortcut.Save () ;

// Gold_Method link
shortcut = shell.CreateShortcut(programs + "\\Gold_Method.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\Gold.ico";
shortcut.Arguments = " -Gold_Method ";
shortcut.Save () ;

// X_Apen link
shortcut = shell.CreateShortcut(programs + "\\X_ApEn.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\hormone.exe";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\XApEn.ico";
shortcut.Arguments = " -X_Apen ";
shortcut.Save () ;

// UnInstall link
shortcut = shell.CreateShortcut(programs + "\\UnInstall.lnk");
shortcut.TargetPath = fso.GetParentFolderName(fso.GetParentFolderName(sname)) + "\\system\\UnInstall.vbs";
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\UnInstall.ico";
shortcut.Save () ;

if (fso.FileExists(programs + "\\remove.lnk")) fso.DeleteFile(programs + "\\remove.lnk");

// desktop link
shortcut = shell.CreateShortcut(shell.SpecialFolders("Desktop") + "\\" + package + ".lnk");
shortcut.TargetPath = programs;
shortcut.IconLocation = fso.GetParentFolderName(sname) + "\\" + package + ".ico";
shortcut.Save () ;

// open output file for deletions
ts = fso.CreateTextFile(fso.GetParentFolderName(sname) + "\\UnInstall.vbs");
ts.WriteLine("On Error Resume Next");
ts.WriteLine("Dim fso");
ts.WriteLine("Set fso = CreateObject(\"Scripting.FileSystemObject\")");
ts.WriteLine("fso.DeleteFolder (\""+programs+"\")");
ts.WriteLine("fso.DeleteFile (\""+shell.SpecialFolders("Desktop") + "\\" + package + ".lnk"+"\")");
ts.WriteLine("fso.DeleteFolder (\""+fso.GetParentFolderName(fso.GetParentFolderName(sname))+"\")");
ts.close();

