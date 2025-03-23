# Commented out slow stuff

Import-Module -Name Terminal-Icons
New-Alias which Get-Command

#oh-my-posh init pwsh --config 'C:\Users\rpeab\.dotfiles\powershell\bubblesextra.omp.json' | Invoke-Expression

# Ensure split panes open in same directory
# (comment out if oh-my-posh is enabled)
function prompt {
  $loc = $executionContext.SessionState.Path.CurrentLocation;

  $out = ""
  if ($loc.Provider.Name -eq "FileSystem") {
    $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
  return $out
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function make-link ($target, $link) {
  New-Item -Path $link -ItemType SymbolicLink -Value $target
}
