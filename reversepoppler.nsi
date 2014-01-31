; The name of the installer
Name "Reverse Poppler 2 point 45"

; The file to write
OutFile "reverse_poppler.exe"

; The default installation directory
InstallDir $PROGRAMFILES\winamp3

; The text to prompt the user to enter a directory
DirText "Choose Winamp3 Directory $\n $\n NOTE:This Will NOT WORK with Reverse Poppler 1 Installed, get RP2"
ShowInstDetails show

; The stuff to install
Section "ThisNameIsIgnoredSoWhyBother?"
  SetOutPath $INSTDIR\addons\reversepoppler
  File .\reversepoppler.maki
  File .\script.xml

SectionEnd ; end the section

; eof
