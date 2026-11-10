# Pattern metadata reload: clear stale state before retry

## Defect

`PatternLoader::Load` remembered modules whose previous metadata load failed using `g_failedModules`. On a later successful call for that same module, the loader populated new patterns but did not clear the failure marker. `FindPattern` consequently continued to reject lookups. A failed subsequent load could also leave an obsolete map present.

## Correction

At the start of each metadata load attempt, remove the module's old pattern map and prior failure marker using `PatternReloadState::Begin`. A subsequent fetch either installs a fresh map or records a new failure. Unrelated modules are not modified.

## Tests

`tests/pattern_reload_state_test.cpp` exercises the exact helper used by the production loader: old failure state and metadata are cleared, unrelated modules remain intact, and repeated retries work. The standalone MSVC test passed (exit code 0), and the full Windows Release build succeeded after recompiling `PatternLoader.cpp` (exit code 0).

## Limits

The policy test verifies state transitions in isolation; it is not an end-to-end test of the production `PatternLoader::Load` network/cache or hook installation behavior. It does not provide new signatures, restore missing upstream compatibility data, or verify operation inside Steam. Existing running Steam files were not modified.
