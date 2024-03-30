#define BIBREF_VERSION "2024Mar30"

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
Name: "{group}\bibref-qt"; Filename: "{app}\start.bat"; IconFilename: "{app}\bibref.ico"
Name: "{group}\Uninstall bibref"; Filename: "{uninstallexe}"; IconFilename: "{app}\bibref.ico"
Name: "{autoprograms}\bibref-qt"; Filename: "{app}\start.bat"; IconFilename: "{app}\bibref.ico"
Name: "{autodesktop}\bibref-qt"; Filename: "{app}\start.bat"; IconFilename: "{app}\bibref.ico"

[Run]
Filename: {app}\start.bat; Description: Start bibref now; Flags: postinstall nowait skipifsilent
