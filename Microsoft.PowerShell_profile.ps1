# Zoxide
Invoke-Expression (& {
  $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
  (zoxide init --hook $hook powershell | Out-String)
})

# PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Get-History
if(Test-Path alias:h) { Remove-Alias h }

# ENVIRONTMENT VARIABLES
$env:FZF_DEFAULT_COMMAND = "fd -a"
$env:FZF_CTRL_T_COMMAND = "$env:FZF_DEFAULT_COMMAND"
$env:FZF_Alt_C_COMMAND = "$env:FZF_DEFAULT_COMMAND -t d"
