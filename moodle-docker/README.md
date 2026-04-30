# Castle Tintagel Moodle (local Docker)

## Status
- Stack: MariaDB 10.11 + Bitnami Moodle 5.0.2 (image `bitnamilegacy/moodle:5.0.2`)
- URL: http://localhost:8080
- Login: `admin` / `ChangeMe!2026`  ← change immediately

## Start / stop
```powershell
docker compose up -d        # start
docker compose down         # stop (data preserved)
docker compose down -v      # stop AND wipe everything
docker compose logs -f moodle
```
First boot: ~90s. Subsequent boots: ~10s.

## Dev workflow
- **Configuration & content** -> web UI at http://localhost:8080
- **Custom theme** -> edit files in `custom/theme/tintagel/` in VS Code, then:
  ```powershell
  .\sync-custom.ps1
  ```
  This pushes your changes into the running container and purges Moodle caches.
  After adding a NEW theme/plugin, also visit http://localhost:8080/admin to
  trigger the install prompt; then activate at:
  Site administration -> Appearance -> Themes -> Theme selector -> Tintagel
- **Custom plugins** -> drop into `custom/local/<pluginname>/`, run `.\sync-custom.ps1`
- **Inspect container** -> Docker VS Code extension -> right-click `moodle-app`
  -> "Attach Shell" or "Attach Visual Studio Code"

## Backup
```powershell
.\backup.ps1
```
Outputs `backups\moodle-db-<ts>.sql` and `backups\moodledata-<ts>.tar.gz`.

## Notable deviations from the original spec
- MariaDB 10.6 -> **10.11** (Moodle 5.x requires 10.11+).
- `bitnami/moodle:latest` -> **`bitnamilegacy/moodle:5.0.2`** (Bitnami retired
  free `:latest` tag on Aug 28 2025; legacy registry hosts the last free builds).
- Custom code is NOT bind-mounted (it broke Bitnami's installer). Use
  `sync-custom.ps1` instead.
- Added DB `utf8mb4` charset, healthcheck, and explicit admin credentials.

