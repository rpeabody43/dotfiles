Import-Module -Name Terminal-Icons
New-Alias which Get-Command
oh-my-posh init pwsh --config 'C:\Users\rpeab\.dotfiles\powershell\bubblesextra.omp.json' | Invoke-Expression
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
