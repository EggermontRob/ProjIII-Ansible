# Markdown to PDF

Voor de Markdown naar pdf te converteren maken we gebruik van het script van [Bert Van Vreckem](https://github.com/bertvv). Het script om pdf's te genereren kan gevonden worden op [cheat-sheets]( https://github.com/bertvv/cheat-sheets).

# Installatie van nodige software

Voor het gemak maak gebruik van Chocolatey op Windows.
- Open de command prompt, voer deze uit als administrator en voer volgende code uit.
- Installeer de chocolatey package manager door het uitvoeren van volgende code.
```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```
- installeer gnu make.
```
choco install make
```
- installeer pandoc.
```
choco install pandoc
```
- installeer MiKTeX.
```
choco install miktex
```
- installeer de nodige fonts.
```
choco install dejavufonts
```
# Maken van een PDF

Voor het maken en updaten van PDF's maken we gebruik van volgende commando's.
- Voor alle bestanden
```
make
```
- Voor een specifiek bestand
```
make "filename.pdf"
```
