# Combined source preview (not a Steam-ready release)

This branch collects the fork's Windows build convenience changes together with both repair pull requests for source-level evaluation.

## Included work

- Windows beginner build scripts and tool detection from fork main (upstream PR #230).
- Reject IPC metadata containing no usable methods (upstream PR #234).
- Clear stale failed-state on a pattern reload, prevent reuse of stale pattern maps, and check direct pattern RVAs against module bounds (upstream PR #235).
- An isolated C++ pattern-loader recovery test runner in tests/.

## How to get this source version

On GitHub choose the branch named release/verified-source-preview, then Code > Download ZIP, or clone this branch with Git. The default main branch may not include these changes while upstream review is pending.

## What the build means

Build outputs are OpenSteamTool.dll, dwmapi.dll and xinput1_4.dll. These are experimental binary artifacts, not evidence of safe compatibility with any installed Steam version.

Earlier offline evidence:
- IPC metadata loader 8/8 cases passed in an isolated C++ harness.
- Pattern loader 15/15 cases passed in an isolated C++ harness.
- Steam-monitor resolver 83/83 Python tests passed on its separate repair branch.
- A diagnostic Release build passed with C++ optimizations disabled and one compilation worker because the stock MSVC 14.51 build had C1001 internal compiler failures.

**Live Steam runtime, access-control behavior, current public metadata feed and stock optimized build remain unverified.** This branch must not be labeled as a fully working Steam release. No game content or authorization tickets are included.

## How to report a problem

Record Windows version, exact commit SHA, Visual Studio version, the first error in your build log, expected/actual behavior, and whether the result was an offline test or a real supported integration test. Do not post access tokens, tickets, or private credentials.

## License

The project follows the upstream GPL-3.0 license and third-party notices. Respect software and content licensing; source availability does not grant ownership of games or DLC.
