# backup.ps1 - Windows version

# Load source directories from config
. .\config.ps1

# Ensure folders exist
if (!(Test-Path "logs")) { 
    New-Item -ItemType Directory -Path "logs" | Out-Null 
}

# Ensure backups folder exists correctly
if (!(Test-Path "backups")) {
    New-Item -ItemType Directory -Path "backups" -Force | Out-Null
}

# Define log file path
$LogFile = "logs\backup.log"

# Create empty log file if it doesn't exist
if (!(Test-Path $LogFile)) { 
    New-Item -ItemType File -Path $LogFile | Out-Null 
}

# Create timestamped backup folder
$Date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$CurrentBackupPath = Join-Path "backups" $Date
# Always create unique folder safely
$CurrentBackupPath = Join-Path "backups" $Date
$CurrentBackupPath = $CurrentBackupPath + "_" + (Get-Random -Maximum 1000)

New-Item -ItemType Directory -Path $CurrentBackupPath -Force | Out-Null

# Log start
Add-Content -Path $LogFile -Value "Backup started at $(Get-Date)"

# Copy each folder safely
foreach ($Dir in $SourceDirs) {
    try {
        if (Test-Path $Dir) {
            $DestPath = Join-Path $CurrentBackupPath (Split-Path $Dir -Leaf)
            Copy-Item -Path $Dir -Destination $DestPath -Recurse -Force -ErrorAction Stop
            Add-Content -Path $LogFile -Value "Backed up ${Dir} successfully."
        } else {
            Add-Content -Path $LogFile -Value "Directory ${Dir} not found!"
        }
    } catch {
        Add-Content -Path $LogFile -Value "Skipped ${Dir}: Access denied or error."
    }
}

# Log end
Add-Content -Path $LogFile -Value "Backup finished at $(Get-Date)"
Add-Content -Path $LogFile -Value "-------------------------------------------"