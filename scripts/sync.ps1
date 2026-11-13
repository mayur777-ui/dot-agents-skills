<#
.SYNOPSIS
    Syncs repository skills to Antigravity global configuration.
.DESCRIPTION
    Dynamically scans all skill folders in this repository and creates live
    directory junctions in ~/.gemini/config/skills/ so Antigravity natively
    discovers and loads them across all projects on any Windows machine.
#>

$ErrorActionPreference = "Stop"

$RepoSkillsPath = (Resolve-Path "$PSScriptRoot\..\skills").Path
$GeminiConfigDir = "$HOME\.gemini\config"
$GlobalSkillsDir = "$GeminiConfigDir\skills"

Write-Host "Syncing skills to Antigravity..." -ForegroundColor Cyan
Write-Host "Source: $RepoSkillsPath" -ForegroundColor Gray
Write-Host "Target: $GlobalSkillsDir" -ForegroundColor Gray

# Ensure target directories exist
if (-not (Test-Path $GlobalSkillsDir)) {
    New-Item -ItemType Directory -Path $GlobalSkillsDir -Force | Out-Null
}

# Dynamically link every skill folder found in repository
$Skills = Get-ChildItem -Path $RepoSkillsPath -Directory

if ($Skills.Count -eq 0) {
    Write-Warning "No skill directories found in $RepoSkillsPath"
    exit 0
}

Write-Host "`nCreating live junctions..." -ForegroundColor Yellow

foreach ($Skill in $Skills) {
    $SkillName = $Skill.Name
    $SourcePath = $Skill.FullName
    $DestPath = "$GlobalSkillsDir\$SkillName"

    if (Test-Path $DestPath) {
        $Item = Get-Item -Path $DestPath -Force
        if ($Item.LinkType -eq "Junction" -and $Item.Target -eq $SourcePath) {
            Write-Host "  ✅ $SkillName (already linked)" -ForegroundColor Green
            continue
        }
        Remove-Item -Path $DestPath -Recurse -Force
    }

    New-Item -ItemType Junction -Path $DestPath -Target $SourcePath | Out-Null
    Write-Host "  🔗 Linked: $SkillName" -ForegroundColor Green
}

Write-Host "`n✅ Successfully synced $($Skills.Count) skills to Antigravity!" -ForegroundColor Green
Write-Host "Note: Start a new chat in Antigravity to load new skills into the prompt." -ForegroundColor Cyan
