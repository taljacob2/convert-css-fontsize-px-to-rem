<#
  .DESCRIPTION
  A script that parses a CSS file which its `font-size` rules are written with
  units of `px`, and converts them to `font-size` with `rem` units.

  .PARAMETER TargetCssFile
  Specify the path to the target CSS file, that you wish to covert its rules of
  `font-size: *px` to `font-size: *rem`.

  .PARAMETER PathToSaveNewCssFile
  Specify where to save the new CSS file.
  ATTENTION: This **cannot** be `$TargetCssFile`.

  .PARAMETER RemPxValue
  Specify the `:root`'s `font-size`'s `px` value. By default, in every browser,
  the `px` value is `16`.

  .INPUTS
  None. You cannot pipe objects to this script.

  .OUTPUTS
  convert-css-fontsize-px-to-rem.ps1 generates the new conveted CSS file to
  the path specified in `$PathToSaveNewCssFile`.

  .NOTES
  MIT License
  Author: Tal Jacob

  .EXAMPLE
  PS> .\convert-css-fontsize-px-to-rem.ps1 -targetcssfile src\style.css -pathtosavenewcssfile src\new-style.css -rempxvalue 16

  .EXAMPLE
  PS> .\convert-css-fontsize-px-to-rem.ps1 -TargetCssFile src/style.css -PathToSaveNewCssFile src/new-style.css -RemPxValue 14

  .LINK
  Online version: https://github.com/taljacob2/convert-css-fontsize-px-to-rem
#>

param (
    [parameter(mandatory)][string]$TargetCssFile,
    [parameter(mandatory)][string]$PathToSaveNewCssFile,
    [int]$RemPxValue = 16)


# Init empty list that will serve as the new CSS file.
$newCssFileAsStringList = @()

# Read CSS file.
[System.IO.StreamReader]$sr = 
    [System.IO.File]::Open($TargetCssFile, [System.IO.FileMode]::Open)
while (-not $sr.EndOfStream)
{
    $line = $sr.ReadLine()

    $pxValueAsString = $line |
        Select-String -Pattern "font-size:(.*)px" -AllMatches |
            Foreach {$_.Matches} |
                Foreach {$_.Groups[1].Value}

    $newCssFileAsStringList+=$line
    if ($pxValueAsString -eq $null){
        continue
    }

    [int]$pxValueAsInt = [convert]::ToInt32($pxValueAsString)
    $remValue = $pxValueAsInt / $RemPxValue

    $newLine = $line -replace ("font-size:.*px", "font-size: ${remValue}rem")

    # Replace last element in `$newCssFileAsStringList` with `$newline`.
    $newCssFileAsStringList[$newCssFileAsStringList.Count - 1]=$newline
}
$sr.Close() 

# Write-Output($newCssFileAsStringList) # Debug

# Write new file.
$newCssFileAsStringList | Out-File -Force $PathToSaveNewCssFile    
