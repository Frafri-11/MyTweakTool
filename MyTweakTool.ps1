# MyTweakTool.ps1 - GPUWORLD Tweaks Launcher
Clear-Host
$Host.UI.RawUI.WindowTitle = "GPUWORLD Optimization Tool"

# Avvio silenzioso
Start-Sleep -Seconds 1.8
Clear-Host

# ===== LOGO =====
@"
GGGGGGGGGGGGGGGG           WW                 WW         TTTTTTTTTTTTTTTTTTT
GG:::::::::::::::G          WW               WW          T:::::::::::::::::T
GG:::::::::::::::G           WW     WW     WW           T:::::::::::::::::T
G:::::GGGGGGGG::::G           WW   WWWW   WW            T:::::TT:::::::TTT
G:::::G         GGGGGG         WW WWWWWW WW             TTTTTT  TTTTTTT
G:::::G                        WWWW     WWWW                     T:::::T
G:::::G     GGGGGGG            WW         WW                     T:::::T
G:::::G     G:::::G            WW         WW                     T:::::T
G:::::G     G:::::G            WW         WW                     T:::::T
G:::::G     G:::::G            WW         WW                     T:::::T
G:::::G         GGGGGG         WW         WW                     T:::::T
G:::::GGGGGGGG::::G            WW         WW                     T:::::T
GG:::::::::::::::G             WW         WW                     T:::::T
GG:::::::::::::::G             WW         WW                     T:::::T
 GGGGGGGGGGGGGGG               WW         WW                     TTTTTTT
"@

Write-Host ""
Write-Host ""
Write-Host "====GPUWORLD Tweaks===="
Write-Host "====Windows Toolbox===="
Write-Host ""

# ===== CREAZIONE CARTELLA SCRIPTS =====
$scriptsPath = Join-Path $PSScriptRoot "scripts"
if (-not (Test-Path $scriptsPath)) {
    New-Item -Path $scriptsPath -ItemType Directory | Out-Null
    Write-Host ""
    Write-Host "[+] Cartella 'scripts' creata. Inserisci qui i tuoi .bat o .ps1"
    Write-Host "Premi INVIO per chiudere..."
    pause
    exit
}

# ===== MENU DINAMICO =====
function Show-Menu {
    Clear-Host
    Write-Host "============================="
    Write-Host " GPUWORLD TWEAKS - MENU BASE"
    Write-Host "============================="
    Write-Host ""
    $files = Get-ChildItem -Path $scriptsPath -Include *.ps1, *.bat -File
    if ($files.Count -eq 0) {
        Write-Host "Nessuno script trovato nella cartella 'scripts'."
        Write-Host ""
        pause
        exit
    }

    $i = 1
    foreach ($f in $files) {
        Write-Host "[$i] $($f.Name)"
        $i++
    }
    Write-Host "[0] Esci"
    Write-Host ""
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Seleziona un numero"

    if ($choice -eq '0') { exit }

    $files = Get-ChildItem -Path $scriptsPath -Include *.ps1, *.bat -File
    if ($choice -gt 0 -and $choice -le $files.Count) {
        $selected = $files[$choice - 1]
        Write-Host ""
        Write-Host "[+] Esecuzione di $($selected.Name)..."
        if ($selected.Extension -eq ".ps1") {
            powershell.exe -ExecutionPolicy Bypass -File $selected.FullName
        }
        elseif ($selected.Extension -eq ".bat") {
            Start-Process -FilePath $selected.FullName -Wait
        }
        pause
    }
    else {
        Write-Host "Scelta non valida."
        Start-Sleep -Seconds 1
    }
}
