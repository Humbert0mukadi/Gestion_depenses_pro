# Launcher executable (Windows)

This project includes a PySide6-based launcher (`launcher/run_launcher.py`) that provides a GUI to:

- Start / stop the Flask server
- Open the app in the default browser
- Install dependencies and create a `.venv` without using the command line
- View/save logs and choose log file to tail

How to build (Windows):
1. Activate your venv and install requirements:
   ```powershell
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   pip install -r requirement.txt
   ```
2. Run the build script to generate a single-file EXE:
   ```powershell
   .\make_exe.ps1
   ```

Notes:
- The built executable will be placed in `dist\GestionDepensesLauncher.exe`.
- The exe bundles the launcher and necessary assets; the Flask app is imported from the project next to it.
- PySide6 binaries increase exe size significantly but give a modern UI.

---

## CI builds (Windows) ✅

- A GitHub Actions workflow (`.github/workflows/build-windows-pyinstaller.yml`) is included and builds Windows executables on push to `main` and `feature/form-ux`, on pull requests, and via manual dispatch.
- The workflow performs an onedir build (zipped) and a onefile build; artifacts are uploaded to the workflow run as downloadable files named `GestionDepensesLauncherDir-<sha>.zip` and `GestionDepensesLauncher-<sha>`.
- To trigger a manual build: open the repository **Actions** tab, select **Build Windows executables (PyInstaller)**, and click **Run workflow**.
- To fetch the artifacts: open the workflow run page after it completes and download the artifacts from the **Artifacts** section.

> Tip: the onedir artifact is useful for quick testing; the onefile exe is the final distributable (may be large). If you'd like, I can add a step to automatically create a GitHub Release and attach the onefile exe.
