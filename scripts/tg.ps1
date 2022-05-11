[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $lifecycle
)

$ErrorActionPreference = "Stop"
$InformationPreference = "Continue"
$WarningPreference = "SilentlyContinue"
function CommandAliasFunction {
    Write-Information ""
    Write-Information "$args"
    $cmd, $args = $args
    $params = $args -split " "
    & "$cmd" @params
    if ($LASTEXITCODE) {
        throw "Exception Occured"
    }
    Write-Information ""
}

Set-Alias -Name ce -Value CommandAliasFunction -Scope script

$pwd= Get-Location
ce terragrunt run-all $lifecycle -var-file $pwd/terraform.tfvars.json
