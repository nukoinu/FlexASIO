#if GetStringFileInfo("@BUILD_CMAKE_INSTALL_PREFIX@/bin/FlexASIO.dll", "ProductVersion") != "@FLEXASIO_RELEASE_VERSION@"
  #error The staged FlexASIO.dll version does not match the installer version. Rebuild and stage the x64 release.
#endif

[Setup]
AppId=FlexASIO
AppName=FlexASIO
AppVerName=FlexASIO @FLEXASIO_RELEASE_VERSION@ (x64)
AppVersion=@FLEXASIO_RELEASE_VERSION@
AppSupportURL=https://github.com/dechamps/FlexASIO
VersionInfoDescription=FlexASIO x64 Installer
VersionInfoVersion=@FLEXASIO_NUMERIC_VERSION@
VersionInfoProductName=FlexASIO
VersionInfoProductTextVersion=@FLEXASIO_RELEASE_VERSION@
DefaultDirName={autopf}\FlexASIO
AppendDefaultDirName=no
PrivilegesRequired=admin
ArchitecturesAllowed=x64os
ArchitecturesInstallIn64BitMode=x64os
WizardStyle=modern
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=FlexAsio_@FLEXASIO_RELEASE_VERSION@_x64

[Files]
Source: "@BUILD_CMAKE_INSTALL_PREFIX@/bin/*"; Excludes: "FlexASIO.dll,*.pdb"; DestDir: "{app}\x64"; Flags: ignoreversion 64bit
Source: "@BUILD_CMAKE_INSTALL_PREFIX@/bin/FlexASIO.dll"; DestDir: "{app}\x64"; Flags: ignoreversion regserver 64bit
Source: "README-x64.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/../CONFIGURATION.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/../BACKENDS.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/../LICENSE.txt"; DestDir: "{app}\licenses"; DestName: "FlexASIO.txt"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/ASIOTest/LICENSE.txt"; DestDir: "{app}\licenses"; DestName: "ASIOTest.txt"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/dechamps_ASIOUtil/LICENSE.txt"; DestDir: "{app}\licenses"; DestName: "ASIOUtil.txt"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/dechamps_cpplog/LICENSE.txt"; DestDir: "{app}\licenses"; DestName: "cpplog.txt"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/dechamps_cpputil/LICENSE.txt"; DestDir: "{app}\licenses"; DestName: "cpputil.txt"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/cxxopts/LICENSE"; DestDir: "{app}\licenses"; DestName: "cxxopts.txt"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/libsndfile/COPYING"; DestDir: "{app}\licenses"; DestName: "libsndfile.txt"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/portaudio/LICENSE.txt"; DestDir: "{app}\licenses"; DestName: "PortAudio.txt"; Flags: ignoreversion
Source: "@CMAKE_CURRENT_LIST_DIR@/tinytoml/LICENSE"; DestDir: "{app}\licenses"; DestName: "tinytoml.txt"; Flags: ignoreversion
Source: "@ASIO_SDK_DIR@/Steinberg ASIO*Licensing Agreement*.pdf"; DestDir: "{app}\licenses"; Flags: ignoreversion
