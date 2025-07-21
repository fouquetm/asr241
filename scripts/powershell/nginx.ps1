# nginx.ps1
# Déploie une configuration Nginx sur Windows

param(
    [string]$NginxConfPath = "C:\nginx\conf\nginx.conf",
    [string]$NewConfSource = ".\nginx.conf"
)

function Ensure-NginxInstalled {
    if (-not (Get-Command nginx.exe -ErrorAction SilentlyContinue)) {
        Write-Host "Nginx n'est pas installé. Téléchargez-le depuis https://nginx.org/en/download.html"
        exit 1
    }
}

function Backup-Config {
    if (Test-Path $NginxConfPath) {
        $backupPath = "$NginxConfPath.bak_$(Get-Date -Format 'yyyyMMddHHmmss')"
        Copy-Item $NginxConfPath $backupPath
        Write-Host "Configuration sauvegardée : $backupPath"
    }
}

function Deploy-Config {
    Copy-Item $NewConfSource $NginxConfPath -Force
    Write-Host "Nouvelle configuration déployée."
}

function Reload-Nginx {
    Stop-Process -Name nginx -ErrorAction SilentlyContinue
    Start-Process -FilePath "nginx.exe"
    Write-Host "Nginx redémarré avec la nouvelle configuration."
}

# Script principal
Ensure-NginxInstalled
Backup-Config
Deploy-Config
Reload-Nginx