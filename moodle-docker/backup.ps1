$ErrorActionPreference = "Stop"
$ts  = Get-Date -Format "yyyyMMdd-HHmm"
$dir = Join-Path $PSScriptRoot "backups"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
docker exec moodle-db sh -c "mysqldump -u moodleuser -pmoodlepass --single-transaction --quick --lock-tables=false moodle" |
    Out-File -Encoding ascii -FilePath (Join-Path $dir "moodle-db-$ts.sql")
docker run --rm -v moodle-docker_moodle_data:/data:ro -v "${dir}:/backup" alpine `
    sh -c "tar czf /backup/moodledata-$ts.tar.gz -C /data ."
Write-Host "Backup written to $dir"
