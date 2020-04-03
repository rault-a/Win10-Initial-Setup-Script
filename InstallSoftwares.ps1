Function DownloadFile {
  param([string]$Url, [string]$Output)

  Import-Module BitsTransfer
  Start-BitsTransfer -Source $Url -Destination $Output  
}

Function InstallMSI {
  param([string]$Path, [string[]]$Options)
  $AllArgs = @("/I", "$Path", "/quiet") + $Options
  Start-Process msiexec.exe -Wait -ArgumentList $AllArgs
}

Function InstallExe {
  param([string]$Path)

  Start-Process $Path -Wait
}

DownloadFile "https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64&lang=en-US" "firefox.msi"
InstallMSI "$pwd\firefox.msi" @("TASKBAR_SHORTCUT=true", "DESKTOP_SHORTCUT=false", "START_MENU_SHORTCUT=true")

DownloadFile "https://discordapp.com/api/download?platform=win" "discord.exe"
InstallExe "$pwd/discord.exe"
