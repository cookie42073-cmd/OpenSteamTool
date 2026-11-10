# Beginner guide: turn the source code into a Windows build

If this is your first time using GitHub, start here. You do not need to understand C++ to run the setup, but you do need a Windows computer and enough free space for development tools.

**Important:** This guide builds the program. It does not install DLLs into Steam, unlock games, or prove the program works with Steam. This integration branch is still experimental.

## Step 1: Get the files

1. Open the [integration branch on GitHub](https://github.com/cookie42073-cmd/OpenSteamTool/tree/integration/combined-safety-fixes).
2. Choose **Code**, then **Download ZIP**, unless you already have a local clone.
3. In Windows File Explorer, right-click the ZIP and choose **Extract All**.
4. Open the extracted folder containing `SETUP-BUILD.bat`.

You should see the files `SETUP-BUILD.bat`, `setup-build-tools.ps1`, and `beginner-build.bat`. Keep them in the same folder as the project's `src` directory.

## Step 2: Double-click SETUP-BUILD.bat

A command window checks for the tools required to compile the program. Here is what the names mean:

| Tool | What it does | What setup will do |
|---|---|---|
| **Git** | Helps download source-code dependencies | Ask permission to install it if missing |
| **Visual Studio C++ Build Tools** | The compiler that turns C++ text into Windows files | Ask permission to install it if missing, including the C++ workload |
| **CMake** | Organizes the compilation | Use Visual Studio's included copy if available, or ask to install CMake |

Windows may show an administrator permission window. **Read every prompt before accepting.** A compiler installation can be several gigabytes and may need a restart.

Setup uses Microsoft's Windows Package Manager (`winget`) to obtain the named tools. It does not secretly install packages or accept license agreements for you. If `winget` is missing, install Microsoft's **App Installer** and try again. If you decline a required tool, the program will explain that the build is not yet ready.

Once the tools are available, setup can check them and ask whether to compile the source. You can answer **N** if you only wanted to prepare the computer.

## Step 3: Build the source

If all checks pass, choose **Y** when asked whether to build. The existing `beginner-build.bat` runs the build process. If you don't want to use guided setup, you can also double-click `beginner-build.bat` directly when all tools are installed.

The first build downloads development dependencies and may take longer than later builds. The script uses conservative compilation settings to reduce the chance of compiler problems on supported Visual Studio versions.

After a successful build, open `build\Release`. You should see these three output files:

- `OpenSteamTool.dll`
- `dwmapi.dll`
- `xinput1_4.dll`

These are **build outputs**, not installers. Their presence does not establish that the program will function correctly with your version of Steam.

## Step 4: What if something fails?

- **'winget' not found:** Install Windows **App Installer** from Microsoft.
- **Git not found after installation:** Close the terminal and open setup again.
- **C++ tools not detected:** Open **Visual Studio Installer** and confirm **Desktop development with C++** and a Windows SDK are installed.
- **CMake not found:** Reopen setup; it can detect the copy included with Visual Studio or offer a separate installation.
- **A build error appears:** Copy the first actual error and final exit code into a GitHub issue. Do not post passwords, tickets, game keys, or private information.

To see what is already installed **without installing or building anything**, open Command Prompt in the extracted folder and run:

```bat
SETUP-BUILD.bat -CheckOnly
```

## Optional runtime testing and legal notice

This project contains software that changes how Steam loads or handles certain functions, including access-related features. Compiling it does not grant permission to use software or content you do not own or have authorization to use. The current experimental fork has not been validated as an end-user Steam release.

For background on the three DLLs, backups, risks and recovery, read [Installation and rollback](INSTALLATION_AND_ROLLBACK.md). **The guided setup does not install DLLs into Steam.**

This fork maintains the original project's [GPL-3.0 license](../LICENSE). It is independent of Valve and Steam. A successful build is not proof of Steam compatibility or lawful use.

If the source build or tested fix worked for you, consider starring the repository and [opening an issue](https://github.com/cookie42073-cmd/OpenSteamTool/issues) describing what you tested. A detailed report is more helpful than a star alone.
