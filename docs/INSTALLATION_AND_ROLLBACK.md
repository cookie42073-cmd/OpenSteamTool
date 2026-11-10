# Installation, risk, and rollback guide

This guide explains the difference between **building** this community fork and **using its DLLs**. The current integration branch is experimental and **has not been verified for end-user Steam runtime compatibility**. No automatic Steam installer is supplied.

## 1. Before downloading

- Review the [GPL-3.0 license](../LICENSE), [README](../README.md), and the source changes before deciding to use this fork.
- Confirm that you have the rights and permissions required for the software and features you intend to test. Do not use this project to obtain unauthorized access to games, DLC, or accounts.
- Understand that DLLs loaded into a third-party application can cause crashes, security warnings, broken updates, or account/platform consequences. A disclaimer or a user's decision to proceed **does not eliminate a maintainer's possible legal responsibilities**.
- The original project and this fork are not affiliated with, endorsed by, or supported by Valve or Steam.

## 2. Build the source (no installation)

1. Obtain the source from this fork's [integration branch](https://github.com/cookie42073-cmd/OpenSteamTool/tree/integration/combined-safety-fixes) and extract it to a directory you control.
2. Install the development prerequisites described in [BEGINNER_BUILD.md](BEGINNER_BUILD.md).
3. Double-click `beginner-build.bat` in the extracted repository. It checks build dependencies, configures CMake, and compiles the source. Running `beginner-build.bat --check-only` from Command Prompt checks prerequisites without building.
4. Check for `build/Release/OpenSteamTool.dll`, `build/Release/dwmapi.dll`, and `build/Release/xinput1_4.dll`. These are compiled **outputs**, not proof that Steam will load or support them.

**The launcher does not copy DLLs to Steam, change Steam settings, download missing game entitlements, or automate runtime installation.**

## 3. Understand the optional manual runtime setup

The upstream README describes a manual setup where its three built DLLs are placed alongside the Steam executable. The two proxy-named DLLs (`dwmapi.dll` and `xinput1_4.dll`) participate in loading the project, so using them changes Steam's normal runtime environment. They are **not** ordinary Windows system DLL updates and should never be copied into Windows system directories.

For this experimental fork, there is **no verified supported Steam build, approved installer, or compatibility guarantee**. We do not recommend deploying the current test outputs to an active Steam installation. If you are an authorized developer conducting a legitimate compatibility evaluation, use an isolated test environment rather than relying on your primary Steam installation. Do not bypass software access controls or licensing requirements.

Before any authorized change to a test environment, inventory the existing files, preserve a separate verified backup of your original configuration and affected files, and record the exact source commit and DLL checksums. Never overwrite someone else's installation or launch conflicting DLL loaders without understanding what they do.

## 4. If the test environment stops working

1. Stop the application under test and do not repeatedly launch it with a suspected incompatible DLL set.
2. Restore only the files and settings from the **verified pre-test backup**, keeping the test artifacts separate; do not delete unrelated DLLs or account data.
3. If the environment is still broken, use the application's official repair/verify workflow and consult its vendor's documentation.
4. Keep redacted diagnostic logs and reproduce failures without posting Steam credentials, access tokens, ownership tickets, serials, game keys, or personal identifiers.

## 5. Help improve the fork

Submit a reproducible report to [this fork's issue tracker](https://github.com/cookie42073-cmd/OpenSteamTool/issues) with Windows version, software build/version, fork commit, exact steps, expected vs. observed result, and redacted logs. Clearly distinguish a **successful compilation**, an **offline regression test**, and a **verified runtime result**. If the verified fixes helped you, consider starring the repository and describing the use case you tested.

## License and legal information

This fork preserves the upstream **GNU GPL version 3** license and applicable third-party notices. Software is provided without warranty to the extent permitted by the license and applicable law. Legal rights and obligations cannot be waived simply by placing a disclaimer in a README. United States copyright law, including [17 U.S.C. 1201](https://uscode.house.gov/us/usc/119-134/t17/s1201/), may impose additional restrictions depending on the functionality and how software is distributed or used. Seek qualified legal advice before broadly distributing any DRM-circumvention-related binaries.
