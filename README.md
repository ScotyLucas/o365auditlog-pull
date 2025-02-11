# o365auditlog-pull
## Ez egy pws script ami menti a audit logokat o365-ről.

## 1. Telepísd a pws-t linuxra:
  sudo apt update && sudo apt install -y powershell

## 2. Amint ez kész van nyisd meg a powershell-t linuxon:
   pws

## 3. Telepísd a Microsoft.Graph-t, mivel azon keresztűl pullolja:
     Install-Module Microsoft.Graph -Scope CurrentUser

## 4. Utána létrehozol egy .ps1 kiterjesztésű fájlt.
     mkdir entra_audit_log.ps1 

## 5.  Utána beilleszted a kódot a SAJÁT Entra API-t és beállítod, hogy milyen időközönként fusson le, de ha azt szerkeszted akkor ezt is szerkeszteni kell:
     # Időintervallum beállítása (pl. az utolsó 30 perc)
    $StartDate = (Get-Date).AddMinutes(-30).ToString("yyyy-MM-ddTHH:mm:ssZ")
    $EndDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")

## 6. Miután ezzel megvagy ments el ctrl+x, y, enter.

## 7. Használd ez a kódot, hogy a háttértben futasd a pws-t kódot:
    nohup pwsh /home/user/entra_audit_log.ps1 &

## 8. Ha leakarod állítani akkor keresd meg a PID-et ezzel:
    ps aux | grep entra_audit_log.ps1

## 9. Majd ird be ezt és lefog állni:
    kill <PID>
