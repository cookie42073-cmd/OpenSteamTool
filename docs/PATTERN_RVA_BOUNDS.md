# Reject out-of-bounds metadata RVAs

## Defect
`PatternLoader::FindPattern` previously constructed a pointer from a supplied nonzero RVA without checking the containing module's image size. Malformed or stale metadata could therefore produce a pointer outside the loaded module image.

## Correction
When an RVA is provided, read the loaded module image bounds with `OSTPlatform::Memory::GetModuleImage` and reject missing images, zero-length images, and out-of-range RVAs before pointer arithmetic. Treat a rejected address as an unresolved function instead of a valid location.

## Tests
`tests/pattern_bounds_test.cpp` validates the production bounds predicate against seven synthetic cases, including offset zero, the first byte, the last valid byte, the exact end, an oversized offset, an empty image, and the maximum integer. The standalone MSVC test exited with code 0. The full Windows x64 Release build also exited with code 0 after compiling the changed `PatternLoader.cpp`.

## Limitations
Bounds checking establishes only that the offset falls within a module image; it does **not** guarantee an executable page, a function boundary, a correct signature, version compatibility, or safe invocation. Do not interpret this as a replacement Steam signature, licensing repair, or successful Steam runtime test. No installed Steam files were modified.
