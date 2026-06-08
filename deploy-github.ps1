# Deploy portfolio to GitHub Pages — permanent free link, no password
# Your CV link will be: https://mimiko-coder.github.io/

$git = "C:\Program Files\Git\bin\git.exe"
$gh = "C:\Program Files\GitHub CLI\gh.exe"
$repoName = "Mimiko-coder.github.io"

Write-Host "Checking GitHub login..." -ForegroundColor Cyan
& $gh auth status
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Sign in first. Run this command and follow the browser steps:" -ForegroundColor Yellow
    Write-Host '  & "C:\Program Files\GitHub CLI\gh.exe" auth login' -ForegroundColor White
    exit 1
}

& $git branch -M main

Write-Host "Creating repository and pushing files..." -ForegroundColor Cyan
& $gh repo create $repoName --public --source=. --remote=origin --push 2>$null
if ($LASTEXITCODE -ne 0) {
    & $git remote remove origin 2>$null
    & $git remote add origin "https://github.com/Mimiko-coder/$repoName.git"
    & $git push -u origin main --force
}

Write-Host "Enabling GitHub Pages..." -ForegroundColor Cyan
& $gh api repos/Mimiko-coder/$repoName/pages -X POST -f "build_type=legacy" -f "source[branch]=main" -f "source[path]=/" 2>$null

Write-Host ""
Write-Host "Your permanent portfolio link (put this on your CV):" -ForegroundColor Green
Write-Host "https://mimiko-coder.github.io/" -ForegroundColor Green
Write-Host ""
Write-Host "No password. Anyone can click and view it anytime." -ForegroundColor Cyan
