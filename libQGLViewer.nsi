Name libQGLViewer

# TODO
# makeDist sur ubuntu
# Dans windows, gestion des zip...
# Tout compiler avec Visual, valider et nettoyer
# Recompiler avec MinGW et valider.
# Copier le zip et l'installer.exe sur dzsrv-linux
# Y lancer 'makeDist web'

# Defines
!define REGKEY "SOFTWARE\$(^Name)"
!define VERSION 2.3.0
!define COMPANY "Gilles Debunne"
!define URL http://www.libQGLViewer.com/

# MUI defines
!define MUI_ICON doc\images\qglviewer128.ico
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_LICENSEPAGE_CHECKBOX
!define MUI_STARTMENUPAGE_REGISTRY_ROOT HKLM
!define MUI_STARTMENUPAGE_REGISTRY_KEY ${REGKEY}
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME StartMenuGroup
!define MUI_STARTMENUPAGE_DEFAULTFOLDER libQGLViewer
!define MUI_FINISHPAGE_SHOWREADME $INSTDIR\doc\index.html
!define MUI_UNICON doc\images\qglviewer128-uninstall.ico
!define MUI_UNFINISHPAGE_NOAUTOCLOSE
!define MUI_LANGDLL_REGISTRY_ROOT HKLM
!define MUI_LANGDLL_REGISTRY_KEY ${REGKEY}
!define MUI_LANGDLL_REGISTRY_VALUENAME InstallerLanguage

# Included files
!include Sections.nsh
!include MUI.nsh
!include Library.nsh

# Reserved Files
!insertmacro MUI_RESERVEFILE_LANGDLL
ReserveFile "${NSISDIR}\Plugins\AdvSplash.dll"

# Variables
Var StartMenuGroup
Var LibInstall

# Installer pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE LICENCE
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuGroup
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Installer languages
!insertmacro MUI_LANGUAGE English
!insertmacro MUI_LANGUAGE French

# Installer attributes
OutFile libQGLViewer-installer.exe
InstallDir $PROGRAMFILES\libQGLViewer
CRCCheck on
XPStyle on
ShowInstDetails show
VIProductVersion "${VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} ProductName "${NAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} ProductVersion "${VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} CompanyName "${COMPANY}"
VIAddVersionKey /LANG=${LANG_ENGLISH} CompanyWebsite "${URL}"
VIAddVersionKey /LANG=${LANG_ENGLISH} FileVersion "${VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} FileDescription "${NAME} installer for version ${VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} LegalCopyright "GPL"
InstallDirRegKey HKLM "${REGKEY}" Path
ShowUninstDetails show

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

########################################################################

# Installer sections
Section libQGLViewer SEC0000
    SetOutPath $INSTDIR
    SetOverwrite on
    File /r installer\*.txt

    WriteRegStr HKLM "${REGKEY}\Components" libQGLViewer 1
SectionEnd

Section /o -un.libQGLViewer UNSEC0000
    Delete /REBOOTOK $INSTDIR\*.txt 
    
    DeleteRegValue HKLM "${REGKEY}\Components" libQGLViewer
SectionEnd

########################################################################

Section $(ExamplesSection) SEC0001
    SetOutPath $INSTDIR\$(examples)
    SetOverwrite on
    
    File examples\animation\release\animation.exe
    File examples\callback\release\FIXcallback.exe
    File examples\cameraLight\release\cameraLight.exe
    File examples\clippingPlane\release\clippingPlane.exe
    File examples\constrainedCamera\release\constrainedCamera.exe
    File examples\constrainedFrame\release\constrainedFrame.exe
    File examples\drawLight\release\drawLight.exe
    File examples\fastDraw\release\fastDraw.exe
    File examples\frameTransform\release\frameTransform.exe
    File examples\frustumCulling\release\frustumCulling.exe
    File examples\interface\release\interface.exe
    File examples\keyboardAndMouse\release\keyboardAndMouse.exe
    File examples\keyFrames\release\keyFrames.exe
    File examples\luxo\release\luxo.exe
    File examples\manipulatedFrame\release\manipulatedFrame.exe
    File examples\mouseGrabber\release\mouseGrabber.exe
    File examples\multiSelect\release\multiSelect.exe
    File examples\multiView\release\multiView.exe
    File examples\overpainting\release\overpainting.exe
    File examples\screenCoordSystem\release\screenCoordSystem.exe
    File examples\select\release\select.exe
    File examples\simpleViewer\release\simpleViewer.exe
    File examples\standardCamera\release\standardCamera.exe
    File examples\stereoViewer\release\stereoViewer.exe
    
    #File examples\contribs\3dsViewer\release\3dsViewer.exe
    File examples\contribs\agora\Viewer\release\agora.exe
    File examples\contribs\agora\AI\release\agoraAI.exe
    File /r /x .svn examples\contribs\agora\AgoraBoards
    File examples\contribs\anaglyph\release\anaglyph.exe
    File examples\contribs\backgroundImage\release\backgroundImage.exe
    File examples\contribs\blobWar\Viewer\release\blobWar.exe
    File examples\contribs\blobWar\AI\release\blobWarAI.exe
    File /r /x .svn examples\contribs\blobWar\BlobWarBoards
    File examples\contribs\cornerAxis\release\cornerAxis.exe
    File examples\contribs\dvonn\release\dvonn.exe
    File /r /x .svn examples\contribs\dvonn\images
    File /r /x .svn examples\contribs\dvonn\rules
    #File examples\contribs\eventRecorder\release\eventRecorder.exe
    #File examples\contribs\quarto\release\quarto.exe
    File examples\contribs\terrain\release\terrain.exe
    File examples\contribs\textureViewer\release\textureViewer.exe
    File examples\contribs\thumbnail\release\thumbnail.exe
    #File examples\contribs\x3dViewer\release\x3dViewer.exe
    
    File C:\Qt\4.4.0\bin\QtGui4.dll
    File C:\Qt\4.4.0\bin\QtCore4.dll
    File C:\Qt\4.4.0\bin\QtOpenGL4.dll
    File C:\Qt\4.4.0\bin\QtXml4.dll
    File "C:\Program Files\MinGW\bin\mingwm10.dll"
    
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateDirectory "$SMPROGRAMS\$StartMenuGroup\$(examples)"
    CreateDirectory "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(basic)"
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(basic)\simpleViewer.lnk" $INSTDIR\$(examples)\simpleViewer.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(basic)\manipulatedFrame.lnk" $INSTDIR\$(examples)\manipulatedFrame.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(basic)\select.lnk" $INSTDIR\$(examples)\select.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(basic)\animation.lnk" $INSTDIR\$(examples)\animation.exe

    CreateDirectory "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)"
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\callback.lnk" $INSTDIR\$(examples)\callback.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\clippingPlane.lnk" $INSTDIR\$(examples)\clippingPlane.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\constrainedCamera.lnk" $INSTDIR\$(examples)\constrainedCamera.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\constrainedFrame.lnk" $INSTDIR\$(examples)\constrainedFrame.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\drawLight.lnk" $INSTDIR\$(examples)\drawLight.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\fastDraw.lnk" $INSTDIR\$(examples)\fastDraw.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\frameTransform.lnk" $INSTDIR\$(examples)\frameTransform.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\frustumCulling.lnk" $INSTDIR\$(examples)\frustumCulling.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\interface.lnk" $INSTDIR\$(examples)\interface.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\keyboardAndMouse.lnk" $INSTDIR\$(examples)\keyboardAndMouse.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\keyFrames.lnk" $INSTDIR\$(examples)\keyFrames.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\luxo.lnk" $INSTDIR\$(examples)\luxo.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\mouseGrabber.lnk" $INSTDIR\$(examples)\mouseGrabber.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\multiSelect.lnk" $INSTDIR\$(examples)\multiSelect.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\multiView.lnk" $INSTDIR\$(examples)\multiView.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\overpainting.lnk" $INSTDIR\$(examples)\overpainting.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\screenCoordSystem.lnk" $INSTDIR\$(examples)\screenCoordSystem.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\standardCamera.lnk" $INSTDIR\$(examples)\standardCamera.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(pedagogical)\stereoViewer.lnk" $INSTDIR\$(examples)\stereoViewer.exe
        
    CreateDirectory "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)"
    #CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\3dsViewer.lnk" $INSTDIR\$(examples)\3dsViewer.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\agora.lnk" $INSTDIR\$(examples)\agora.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\anaglyph.lnk" $INSTDIR\$(examples)\anaglyph.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\backgroundImage.lnk" $INSTDIR\$(examples)\backgroundImage.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\blobWar.lnk" $INSTDIR\$(examples)\blobWar.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\cornerAxis.lnk" $INSTDIR\$(examples)\cornerAxis.exe
    #CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\dvonn.lnk" $INSTDIR\$(examples)\dvonn.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\eventRecorder.lnk" $INSTDIR\$(examples)\eventRecorder.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\quarto.lnk" $INSTDIR\$(examples)\quarto.exe
    #CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\terrain.lnk" $INSTDIR\$(examples)\terrain.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\textureViewer.lnk" $INSTDIR\$(examples)\textureViewer.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\thumbnail.lnk" $INSTDIR\$(examples)\thumbnail.exe
    #CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(examples)\$(advanced)\x3dViewer.lnk" $INSTDIR\$(examples)\x3dViewer.exe
    !insertmacro MUI_STARTMENU_WRITE_END
    
    WriteRegStr HKLM "${REGKEY}\Components" Examples 1
SectionEnd

Section /o -un.Examples UNSEC0001
    RmDir /r /REBOOTOK $INSTDIR\$(examples)    
    RmDir /r /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(examples)"

    DeleteRegValue HKLM "${REGKEY}\Components" Examples
SectionEnd

########################################################################

Section $(Documentation) SEC0002
    SetOutPath $INSTDIR\doc
    SetOverwrite on
    File /r www\*
    
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateDirectory "$SMPROGRAMS\$StartMenuGroup\$(doc)"
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(doc)\index.lnk" $INSTDIR\doc\index.html
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(doc)\$(examples).lnk" $INSTDIR\doc\examples\index.html
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(doc)\$(reference).lnk" $INSTDIR\doc\refManual\hierarchy.html
    !insertmacro MUI_STARTMENU_WRITE_END
    
    WriteRegStr HKLM "${REGKEY}\Components" Documentation 1
SectionEnd

Section /o -un.Documentation UNSEC0002
    RmDir /r /REBOOTOK $INSTDIR\doc    
    RmDir /r /REBOOTOK $SMPROGRAMS\$StartMenuGroup\$(doc)
    
    DeleteRegValue HKLM "${REGKEY}\Components" Documentation
SectionEnd

########################################################################

Section $(Development) SEC0003
    SetOutPath $INSTDIR\QGLViewer
    SetOverwrite on
    #File QGLViewer\release\QGLViewer2.lib
    File /r QGLViewer\*.h
    File /r QGLViewer\*.qm
    File libQGLViewer2.a

    # Installing library QGLViewer\release\QGLViewer2.dll
    !insertmacro InstallLib DLL $LibInstall REBOOT_PROTECTED QGLViewer\release\QGLViewer2.dll $SYSDIR\QGLViewer2.dll $SYSDIR
    
    WriteRegStr HKLM "${REGKEY}\Components" Development 1
SectionEnd

Section /o -un.Development UNSEC0003
    RmDir /r /REBOOTOK $INSTDIR\QGLViewer
   
    # Uninstalling library QGLViewer2.dll
    !insertmacro UnInstallLib DLL SHARED REBOOT_PROTECTED $SYSDIR\QGLViewer2.dll
    
    DeleteRegValue HKLM "${REGKEY}\Components" Development
SectionEnd

########################################################################

Section -post SEC0004
    WriteRegStr HKLM "${REGKEY}" Path $INSTDIR
    SetOutPath $INSTDIR
    WriteUninstaller $INSTDIR\uninstall.exe
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(^UninstallLink).lnk" $INSTDIR\uninstall.exe
    !insertmacro MUI_STARTMENU_WRITE_END
    
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayVersion "${VERSION}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" Publisher "${COMPANY}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" URLInfoAbout "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon $INSTDIR\uninstall.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString $INSTDIR\uninstall.exe
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1
SectionEnd

Section -un.post UNSEC0004
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"

    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^UninstallLink).lnk"    
    Delete /REBOOTOK $INSTDIR\uninstall.exe
    
    DeleteRegValue HKLM "${REGKEY}" StartMenuGroup
    DeleteRegValue HKLM "${REGKEY}" Path
    DeleteRegKey /IfEmpty HKLM "${REGKEY}\Components"
    DeleteRegKey /IfEmpty HKLM "${REGKEY}"
    RmDir /r /REBOOTOK $SMPROGRAMS\$StartMenuGroup
    RmDir /r /REBOOTOK $INSTDIR

#    Push $R0
#    StrCpy $R0 $StartMenuGroup 1
#    StrCmp $R0 ">" no_smgroup
#no_smgroup:
#    Pop $R0
SectionEnd

########################################################################

# Installer functions
Function .onInit
    InitPluginsDir
    Push $R1
    File /oname=$PLUGINSDIR\spltmp.bmp doc\images\qglviewer.bmp
    advsplash::show 1000 800 400 -1 $PLUGINSDIR\spltmp
    Pop $R1
    Pop $R1
    !insertmacro MUI_LANGDLL_DISPLAY
    # Force libraries to be installed and registered
    !insertmacro SetSectionFlag ${SEC0000} ${SF_RO}
    Push $0
    ReadRegStr $0 HKLM "${REGKEY}" Path
    ClearErrors
    StrCmp $0 "" +2
    StrCpy $LibInstall 1
    Pop $0
FunctionEnd

# Uninstaller functions
Function un.onInit
    ReadRegStr $INSTDIR HKLM "${REGKEY}" Path
    !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuGroup
    !insertmacro MUI_UNGETLANGUAGE
    !insertmacro SELECT_UNSECTION libQGLViewer ${UNSEC0000}
    !insertmacro SELECT_UNSECTION Examples ${UNSEC0001}
    !insertmacro SELECT_UNSECTION Documentation ${UNSEC0002}
    !insertmacro SELECT_UNSECTION Development ${UNSEC0003}
FunctionEnd

# Section Descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SEC0000} $(SEC0000_DESC)
!insertmacro MUI_DESCRIPTION_TEXT ${SEC0001} $(SEC0001_DESC)
!insertmacro MUI_DESCRIPTION_TEXT ${SEC0002} $(SEC0002_DESC)
!insertmacro MUI_DESCRIPTION_TEXT ${SEC0003} $(SEC0003_DESC)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

# Installer Language Strings
LangString ^UninstallLink ${LANG_ENGLISH} "Uninstall $(^Name)"
LangString ^UninstallLink ${LANG_FRENCH} "D�sinstaller $(^Name)"

LangString SEC0000_DESC ${LANG_ENGLISH} "libQGLViewer library."
LangString SEC0001_DESC ${LANG_ENGLISH} "Demonstration examples of the different features of the library."
LangString SEC0002_DESC ${LANG_ENGLISH} "libQGLViewer web pages, including API documentation."
LangString SEC0003_DESC ${LANG_ENGLISH} "Header files needed to develop using libQGLViewer."

LangString SEC0000_DESC ${LANG_FRENCH} "Librairie libQGLViewer."
LangString SEC0001_DESC ${LANG_FRENCH} "Exemples de d�monstration des diff�rentes fonctionnalit�s de la biblioth�que."
LangString SEC0002_DESC ${LANG_FRENCH} "Pages web de libQGLViewer, incluant la documentation de l'API."
LangString SEC0003_DESC ${LANG_FRENCH} "Fichiers d'ent�te n�cessaires au d�veloppement avec libQGLViewer."

LangString ExamplesSection ${LANG_ENGLISH} "Examples"
LangString ExamplesSection ${LANG_FRENCH} "Exemples"

LangString Documentation ${LANG_ENGLISH} "Documentation"
LangString Documentation ${LANG_FRENCH} "Documentation"

LangString Development ${LANG_ENGLISH} "Development"
LangString Development ${LANG_FRENCH} "D�veloppement"

LangString examples ${LANG_ENGLISH} "examples"
LangString examples ${LANG_FRENCH} "exemples"

LangString doc ${LANG_ENGLISH} "doc"
LangString doc ${LANG_FRENCH} "doc"

LangString reference ${LANG_ENGLISH} "API"
LangString reference ${LANG_FRENCH} "API"

LangString basic ${LANG_ENGLISH} "basic"
LangString basic ${LANG_FRENCH} "basiques"

LangString pedagogical ${LANG_ENGLISH} "pedagogical"
LangString pedagogical ${LANG_FRENCH} "p�dagogiques"

LangString advanced ${LANG_ENGLISH} "advanced"
LangString advanced ${LANG_FRENCH} "avanc�s"