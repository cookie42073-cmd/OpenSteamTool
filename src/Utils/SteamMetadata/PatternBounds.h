#pragma once

#include <cstddef>
#include <cstdint>

namespace PatternBounds {
// Validate a metadata-provided offset without performing pointer arithmetic.
// A zero RVA is a missing address, never an executable function location.
inline bool IsInModule(uintptr_t rva, size_t moduleSize) {
    return rva != 0 && rva < moduleSize;
}
}
