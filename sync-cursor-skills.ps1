param(
    [switch]$DryRun
)

$CursorSkills = "$env:USERPROFILE\.cursor\skills"

$Sources = @(
    "D:\Personal\agent-skills",
    "D:\Personal\ai\caveman",
    "D:\Personal\ai\ponytail"
)

if (!(Test-Path $CursorSkills)) {
    New-Item -ItemType Directory -Path $CursorSkills | Out-Null
}

foreach ($Source in $Sources) {

    if (!(Test-Path $Source)) {
        Write-Host "[ERROR] Not found: $Source" -ForegroundColor Red
        continue
    }

    $SkillName = Split-Path $Source -Leaf
    $Link = Join-Path $CursorSkills $SkillName

    if (Test-Path $Link) {
        Write-Host "[OK] Exists: $SkillName" -ForegroundColor Green
        continue
    }

    Write-Host "[ADD] Add: $SkillName" -ForegroundColor Cyan

    if (!$DryRun) {
        New-Item `
            -ItemType SymbolicLink `
            -Path $Link `
            -Target $Source | Out-Null
    }
}