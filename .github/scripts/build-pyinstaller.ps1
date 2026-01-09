# Helper script to run PyInstaller builds (used locally or in CI)
set -e
$ErrorActionPreference = 'Stop'
Write-Output "Starting PyInstaller builds..."

python -m pip install --upgrade pip
pip install -r requirement.txt
pip install pyinstaller pyinstaller-hooks-contrib --no-warn-script-location

Write-Output "Building onedir..."
python -m PyInstaller --clean --noconfirm --onedir --windowed --name GestionDepensesLauncherDir --add-data "Templates;Templates" --distpath dist_dir --workpath build_pyinstaller_dir --log-level INFO launcher\run_launcher.py 2>&1 | Tee-Object build_pyinstaller_dir.log

if (Test-Path dist_dir) {
    Write-Output "Compressing dist_dir into dist_dir.zip..."
    if (Test-Path dist_dir.zip) { Remove-Item dist_dir.zip }
    Compress-Archive -Path "dist_dir/*" -DestinationPath "dist_dir.zip" -Force
} else {
    Write-Error "dist_dir not found after onedir build"
}

Write-Output "Building onefile (single exe)..."
python -m PyInstaller --clean --noconfirm --onefile --windowed --name GestionDepensesLauncher --add-data "Templates;Templates" --distpath dist --workpath build_pyinstaller --log-level INFO launcher\run_launcher.py 2>&1 | Tee-Object build_pyinstaller_onefile.log

if (Test-Path dist) {
    Write-Output "Onefile dist created. Contents:"
    Get-ChildItem dist | ForEach-Object { Write-Output $_.FullName }
} else {
    Write-Error "dist not found after onefile build"
}

Write-Output "Done. Check logs: build_pyinstaller_dir.log, build_pyinstaller_onefile.log"