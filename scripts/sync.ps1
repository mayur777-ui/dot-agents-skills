<#
.SYNOPSIS
    Syncs My_Agent_Skills to Antigravity global configuration.
.DESCRIPTION
    Registers the repository's skills directory into ~/.gemini/config/skills.json
    so all skills are automatically discovered by Antigravity across all projects.
#>

$ErrorActionPreference = "Stop"

$RepoSkillsPath = (Resolve-Path "$PSScriptRoot\..\skills").Path -replace '\\', '/'
$GeminiConfigDir = "$HOME\.gemini\config"
$SkillsConfigFile = "$GeminiConfigDir\skills.json"

Write-Host "Syncing My_Agent_Skills to Antigravity..." -ForegroundColor Cyan
Write-Host "Skills Path: $RepoSkillsPath" -ForegroundColor Gray

# Ensure config directory exists
if (-not (Test-Path $GeminiConfigDir)) {
    New-Item -ItemType Directory -Path $GeminiConfigDir -Force | Out-Null
}

# Read existing skills.json or create initial structure
$Config = @{ entries = @() }

if (Test-Path $SkillsConfigFile) {
    try {
        $RawContent = Get-Content -Path $SkillsConfigFile -Raw
        if (-not [string]::IsNullOrWhiteSpace($RawContent)) {
            $ExistingJson = $RawContent | ConvertFrom-Json
            if ($ExistingJson.entries) {
                $Config.entries = @($ExistingJson.entries)
            }
        }
    } catch {
        Write-Warning "Could not parse existing skills.json. Creating fresh entries list."
    }
}

# Check if entry already registered
$AlreadyRegistered = $false
foreach ($entry in $Config.entries) {
    if ($entry.path -eq $RepoSkillsPath) {
        $AlreadyRegistered = $true
        break
    }
}

if (-not $AlreadyRegistered) {
    $Config.entries += @{ path = $RepoSkillsPath }
    $Config | ConvertTo-Json -Depth 5 | Set-Content -Path $SkillsConfigFile -Encoding UTF8
    Write-Host "Registered skills path in: $SkillsConfigFile" -ForegroundColor Green
} else {
    Write-Host "Skills path is already registered in: $SkillsConfigFile" -ForegroundColor Yellow
}

Write-Host "`nSkills registered successfully! Antigravity will now load:" -ForegroundColor Green
Get-ChildItem -Path "$PSScriptRoot\..\skills" -Directory | ForEach-Object {
    Write-Host "  - $($_.Name)" -ForegroundColor Cyan
}
