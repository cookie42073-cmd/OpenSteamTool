# Guided setup of Windows build prerequisites. Does not install into Steam.
param([switch]$CheckOnly)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root
function Heading($message) { Write-Host ''; Write-Host ("=== " + $message + " ===") }
function Confirm-Install($name, $id, [string]$override = '') {
    if ($CheckOnly) { Write-Host "[MISSING] $name; check-only: no changes made."; return $false }
    $ans = Read-Host "Install $name through Windows Package Manager? Admin approval might be needed. [y/N]"
    if ($ans -notin @('y','Y','yes','YES')) { Write-Host "[SKIPPED] $name"; return $false }
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host '[ERROR] Windows Package Manager (winget) missing. Install Microsoft App Installer.'
        return $false
    }
    Write-Host "Source: winget; package: $id. Read and accept license prompts yourself."
    $arguments = @('install','--id',$id,'--exact','--source','winget','--interactive')
    if ($override) {
        $arguments = @('install','--id',$id,'--exact','--source','winget','--override',$override)
    }
    & winget @arguments
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Installer returned $LASTEXITCODE for $name."
        return $false
    }
    Write-Host "[OK] Installation command finished for $name. A restart may be required."
    return $true
}
Heading 'OpenSteamTool: beginner Windows build setup'
Write-Host 'This checks/install tools that compile C++ source code into DLL files.'
Write-Host 'It NEVER copies DLLs into Steam. A successful build is not a runtime test.'
Write-Host 'C++ Build Tools = compiler. CMake = build organizer. Git = source download tool.'
if ($CheckOnly) { Write-Host '[CHECK ONLY] No downloads or installations will occur.' }
$git = Get-Command git -ErrorAction SilentlyContinue
if ($git) { Write-Host "[OK] Git: $($git.Source)" }
else { [void](Confirm-Install 'Git' 'Git.Git') }
$vswhere = Join-Path ([Environment]::GetFolderPath('ProgramFilesX86')) 'Microsoft Visual Studio\Installer\vswhere.exe'
$vs = $null
if (Test-Path $vswhere) {
    $vs = & $vswhere -latest -products '*' -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
}
if ($vs) { Write-Host "[OK] Visual Studio C++ compiler: $vs" }
else {
    [void](Confirm-Install 'Visual Studio C++ Build Tools plus Windows SDK' 'Microsoft.VisualStudio.BuildTools' '--passive --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended')
}
$cmake = Get-Command cmake -ErrorAction SilentlyContinue
if (-not $cmake -and $vs) {
    $bundled = Join-Path $vs 'Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe'
    if (Test-Path $bundled) { $cmake = Get-Item $bundled }
}
if ($cmake) { Write-Host '[OK] CMake is available.' }
else { [void](Confirm-Install 'CMake' 'Kitware.CMake') }
Heading 'Next'
Write-Host 'If you installed software, reopen this window or restart Windows if prompted.'
Write-Host 'Run SETUP-BUILD.bat again to verify dependencies and then build.'
if ($CheckOnly) { if ($git -and $vs -and $cmake) { exit 0 } else { exit 1 } }
$ans = Read-Host 'Check build prerequisites now? [Y/n]'
if ($ans -notin @('n','N','no','NO')) {
    & cmd.exe /c (Join-Path $root 'beginner-build.bat') '--check-only'
    if ($LASTEXITCODE -ne 0) {
        Write-Host '[INFO] A tool is still missing, needs a restart, or requires manual setup.'
        exit 1
    }
    $build = Read-Host 'Build the project source now (no Steam installation)? [y/N]'
    if ($build -in @('y','Y','yes','YES')) {
        & cmd.exe /c (Join-Path $root 'beginner-build.bat')
        exit $LASTEXITCODE
    }
}
Write-Host 'Setup completed. Steam was not modified.'
