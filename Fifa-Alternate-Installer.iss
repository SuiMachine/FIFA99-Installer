;  Hype - The Time Quest Alternate Installer V0.0.5
;  Created 2014 Suicide Machine.
;  Based on a code of Triangle717's Lego Racer Alternative Installer.
;  <http://triangle717.wordpress.com/>
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  <http://quick.mixnmojo.com/>

; If any version below the specified version is used for compiling, 
; this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif

#define MyAppInstallerName "FIFA 99 - Alternate Installer"
#define MyAppInstallerVersion "1.0.0"
#define MyAppName "FIFA 99"
#define MyAppNameNoR "FIFA 99"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "Electronic Arts"
#define MyAppExeName "FIFA99.EXE"

[Setup]
AppID={#MyAppInstallerName}{#MyAppInstallerVersion}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyAppInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 1998 {#MyAppPublisher}
LicenseFile=license.txt
; Start menu/screen and Desktop shortcuts
DefaultDirName={sd}\Games\{#MyAppNameNoR}
DefaultGroupName=EA SPORTS\{#MyAppNameNoR}
AllowNoIcons=yes
; Installer Graphics
SetupIconFile=FIFA99.ico
WizardImageFile=Sidebar.bmp
WizardSmallImageFile=Small-Image.bmp
WizardImageStretch=true
WizardImageBackColor=clBlack
; Location of the compiled Exe
OutputDir=bin
OutputBaseFilename={#MyAppNameNoR} Alternate Installer {#MyAppInstallerVersion}
; Uninstallation stuff
UninstallFilesDir={app}
UninstallDisplayIcon={app}\Hype.ico
CreateUninstallRegKey=yes
UninstallDisplayName={#MyAppName}
; This is required so Inno can correctly report the installation size.
UninstallDisplaySize=390000000
; Compression
Compression=lzma2/ultra64
SolidCompression=True
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes
; From top to bottom:
; Explicitly set Admin rights, no other languages, do not restart upon finish.
PrivilegesRequired=admin
ShowLanguageDialog=no
ShowUndisplayableLanguages=yes
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppInstallerName} {#MyAppInstallerVersion}
; WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications before continuing.
; DiskSpaceMBLabel is overridden because it reports an incorrect installation size.
English.DiskSpaceMBLabel=At least 370 MB of free disk space is required.

[Files]
; Root folder
Source: "{code:GetSourceDrive}EACSND.DLL"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}FIFA99.EXE"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}FIFA99.ICO"; DestDir: "{app}"; Flags: external ignoreversion

; Game folders
Source: "{code:GetSourceDrive}DATA\*"; DestDir: "{app}\DATA\"; Flags: external ignoreversion recursesubdirs
Source: "{code:GetSourceDrive}THRASH\*"; DestDir: "{app}\THRASH\"; Flags: external ignoreversion recursesubdirs

; Not needed?
; Source: "{code:GetSourceDrive}SETUP\*"; DestDir: "{app}\SETUP\"; Flags: external ignoreversion recursesubdirs

; Install stuff
Source: "Stuff\Comp\*"; DestDir: "{app}\Comp\";
Source: "Stuff\voodoo2a.dll"; DestDir: "{app}\thrash\"; Flags: ignoreversion
Source: "Stuff\nGlide103_setup.exe"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall

[Icons]
; First and last icons are created only if user choose not to use the videos, 
; else the normal ones are created.
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\FIFA99.ico"; Comment: "FIFA 99";
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\FIFA99.ico";
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\FIFA99.ico"; Comment: "FIFA 99"; Tasks: desktopicon

[Tasks]
; Create a desktop icon, run with administrator rights
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}";
Name: "nGlide"; Description: "{cm:InstallnGlide}";

[Run]
Filename: "{app}\Comp\PatchInstall.bat"; StatusMsg: "{cm:StatusInstallingCompatibilityFixes}"; Flags: runascurrentuser
Filename: "{app}\nGlide103_setup.exe"; StatusMsg: "{cm:StatusInstallingnGlide}"; Flags: runascurrentuser; Tasks: nGlide

[UninstallDelete]
Type: files; Name: "{app}\{#MyAppExeName}"

[Dirs]
; Created to ensure the save games are not removed (which should never ever happen).
Name: "{app}\USER"; Flags: uninsneveruninstall

[Registry]
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "3D Card"; ValueData: "3Dfx Voodoo 2"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "3D Device Description"; ValueData: "3Dfx Voodoo 2"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "CD Drive"; ValueData: "{code:GetSourceDrive}"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: dword; ValueName: "D3D Device"; ValueData: "0"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "DisplayName"; ValueData: "FIFA 99"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "Group"; ValueData: "3Dfx"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: dword; ValueName: "Hardware Acceleration"; ValueData: "1"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "Install Dir"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "Language"; ValueData: "english"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "Thrash Driver"; ValueData: "voodoo2"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: string; ValueName: "Thrash Resolution"; ValueData: "640x480"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99"; ValueType: dword; ValueName: "Triple Buffer"; ValueData: "0"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99\1.0"; ValueType: string; ValueName: "DisplayName"; ValueData: "FIFA 99"; Flags: uninsdeletevalue
Root: "HKLM32"; Subkey: "SOFTWARE\EA SPORTS\FIFA 99\1.0"; ValueType: dword; ValueName: "Language"; ValueData: "1"; Flags: uninsdeletevalue

[Code]
// Pascal script from Bgbennyboy to pull files off a CD, greatly trimmed up 
// and modified to support ANSI and Unicode Inno Setup by Triangle717.
var
	SourceDrive: string;

#include "FindDisc.iss"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;