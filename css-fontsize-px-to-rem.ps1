<#
A script that parses a CSS file which its `font-size` rules are written with
units of `px`, and converts those lines to `font-size` with `rem` units.

Author: Tal Jacob
#>

# ------------------------------- Parameters  ---------------------------------- 

$targetCssFile = "src/style.css"

# ATTENTION: This **cannot** be `$targetCssFile`.
$PATH_TO_SAVE_NEW_CSS_FILE = "src/new-style.css"
$REM_PX_VALUE = 14

# ---------------------------------- Code -------------------------------------- 

# Init empty list that will serve as the new CSS file.
$newCssFileAsStringList = @()

# Read CSS file.
[System.IO.StreamReader]$sr = [System.IO.File]::Open($targetCssFile, [System.IO.FileMode]::Open)
while (-not $sr.EndOfStream){
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
    $remValue = $pxValueAsInt / $REM_PX_VALUE

    $newLine = $line -replace ("font-size:.*px;?", "font-size: ${remValue}rem;")

    # Replace last element in `$newCssFileAsStringList` with `$newline`.
    $newCssFileAsStringList[$newCssFileAsStringList.Count - 1]=$newline
}
$sr.Close() 

# Write-Output($newCssFileAsStringList) # Debug

# Write new file.
$newCssFileAsStringList | Out-File -Force $PATH_TO_SAVE_NEW_CSS_FILE
