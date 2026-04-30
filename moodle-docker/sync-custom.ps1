# Pushes ./custom/theme/* and ./custom/local/* into the running moodle-app
# container, then purges Moodle caches so the changes take effect.
#
# Usage:  .\sync-custom.ps1
#
# Run this every time you edit theme SCSS / PHP or plugin code.

$ErrorActionPreference = 'Stop'

if (-not (docker ps --filter name=moodle-app --format '{{.Names}}')) {
    Write-Error "moodle-app container is not running. Start it with: docker compose up -d"
}

$root = $PSScriptRoot

# --- Themes ---
Get-ChildItem (Join-Path $root 'custom\theme') -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "==> Syncing theme: $($_.Name)"
    docker exec moodle-app rm -rf "/bitnami/moodle/theme/$($_.Name)"
    docker cp "$($_.FullName)" "moodle-app:/bitnami/moodle/theme/"
    docker exec moodle-app chown -R 1001:0 "/bitnami/moodle/theme/$($_.Name)"
}

# --- Local plugins ---
Get-ChildItem (Join-Path $root 'custom\local') -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "==> Syncing local plugin: $($_.Name)"
    docker exec moodle-app rm -rf "/bitnami/moodle/local/$($_.Name)"
    docker cp "$($_.FullName)" "moodle-app:/bitnami/moodle/local/"
    docker exec moodle-app chown -R 1001:0 "/bitnami/moodle/local/$($_.Name)"
}

Write-Host "==> Purging Moodle caches"
docker exec moodle-app php /opt/bitnami/moodle/admin/cli/purge_caches.php

Write-Host ""
Write-Host "Done. If you added a NEW plugin/theme, also visit:" -ForegroundColor Yellow
Write-Host "  http://localhost:8080/admin   (triggers plugin installation prompt)"
