# config.ps1 - User settings for backup

# Directories to backup (space-separated)
$SourceDirs = @(
    "C:\Users\aditi\OneDrive\Desktop\linux-backup-system\TestBackup"
)

# Backup destination
$BackupDest = "C:\Users\aditi\Desktop\linux-backup-system\backups"

# Log file
$LogFile = "C:\Users\aditi\Desktop\linux-backup-system\logs\backup.log"

# Optional email (not implemented yet)
$Email = "your-email@example.com"