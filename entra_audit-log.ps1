# Microsoft Graph importálása
Import-Module Microsoft.Graph

# Bejelentkezés az Entra ID API-ba (Microsoft Graph)
Connect-MgGraph -Scopes "AuditLog.Read.All"

# Végtelen ciklus 30 perces frissítéssel
while ($true) {
    # Időbélyeg az aktuális futáshoz
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $AuditLogFile = "/home/$env:USER/entra_audit_logs_{$Timestamp}.json"

    # Ha van már log töröli
    if (Test-Path $AuditLogFile) {
        Remove-Item $AuditLogFile -Force
    }

    # Időintervallum beállítása (pl. az utolsó 30 perc)
    $StartDate = (Get-Date).AddMinutes(-30).ToString("yyyy-MM-ddTHH:mm:ssZ")
    $EndDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")

    # Audit események lekérése
    $AuditLogs = Get-MgAuditLogSignIn -All

    # JSON fájlba mentés
    $AuditLogs | ConvertTo-Json -Depth 3 | Out-File $AuditLogFile

    Write-Host "Audit log frissítve: $AuditLogFile"

    # 30 perc várakozás
    Start-Sleep -Seconds 1800
}

# Ha a szkript leáll, akkor bontsuk a kapcsolatot
Disconnect-MgGraph
