param (
    [String] $PackageName,
    [String] $Version,
    [String] $BasePackagePath,
    [String[]] $Spaces
)

$ErrorActionPreference = "Stop"
$InformationPreference = "Continue"
$WarningPreference = "SilentlyContinue"

Trap
{
  Write-Error $_.InvocationInfo.ScriptName -ErrorAction Continue
  $line = "$($_.InvocationInfo.ScriptLineNumber): $($_.InvocationInfo.Line)"
  Write-Error $line -ErrorAction Continue
  Write-Error $_
}
function CommandAliasFunction
{
  Write-Information ""
  Write-Information "$args"
  $cmd, $args = $args
  & "$cmd" $args
  if ($LASTEXITCODE)
  {
    throw "Exception Occured"
  }
  Write-Information ""
}

Set-Alias -Name ce -Value CommandAliasFunction -Scope script

ce octo pack `
    --id="${PackageName}" `
    --format="Zip" --version="${Version}" `
    --basePath="$BasePackagePath" --outFolder="./packages"

foreach ($Space in $Spaces) {
    ce octo push `
        --package="./packages/${PackageName}.${Version}.zip" `
        --space="${Space}" `
        --overwrite-mode=OverwriteExisting
}
