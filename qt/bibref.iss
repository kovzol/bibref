#define BIBREF_VERSION "2025-03-27"

[Setup]
AppName=bibref
AppVersion={#BIBREF_VERSION}
WizardStyle=modern
DefaultDirName={commonpf32}\bibref-qt
DefaultGroupName=bibref
UninstallDisplayIcon={app}\bibref.ico
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=bibref-setup

[Files]
Source: "bibref-qt-{#BIBREF_VERSION}\*.*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\bibref-qt"; Filename: "{app}\bibref-qt.exe"; IconFilename: "{app}\bibref.ico"
Name: "{group}\Uninstall bibref"; Filename: "{uninstallexe}"; IconFilename: "{app}\bibref.ico"
Name: "{autoprograms}\bibref-qt"; Filename: "{app}\bibref-qt.exe"; IconFilename: "{app}\bibref.ico"
Name: "{autodesktop}\bibref-qt"; Filename: "{app}\bibref-qt.exe"; IconFilename: "{app}\bibref.ico"

[Run]
Filename: {app}\bibref-qt.exe; Description: Start bibref now; Flags: postinstall nowait skipifsilent
