# convert-css-fontsize-px-to-rem

A script that parses a CSS file which its `font-size` rules are written with
units of `px`, and converts them to `font-size` with `rem` units.

## Run

Open *powershell.exe* and run:
```
.\convert-css-fontsize-px-to-rem.ps1 -TargetCssFile <TargetCssFile> -PathToSaveNewCssFile <PathToSaveNewCssFile> -RemPxValue <RemPxValue>
```

In case you encouter an error, try running with:
```
powershell.exe -NoLogo -ExecutionPolicy Bypass -Command ".\convert-css-fontsize-px-to-rem.ps1 -TargetCssFile <TargetCssFile> -PathToSaveNewCssFile <PathToSaveNewCssFile> -RemPxValue <RemPxValue>"
```

## Help

To view the full documentation of the script, open *powershell.exe* and run:
```
Get-Help .\convert-css-fontsize-px-to-rem.ps1 -Full
```
