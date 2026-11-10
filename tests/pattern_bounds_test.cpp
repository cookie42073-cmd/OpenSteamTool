#include "Utils/SteamMetadata/PatternBounds.h"
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <limits>

int main() {
    using PatternBounds::IsInModule;
    assert(!IsInModule(0, 100));
    assert(IsInModule(1, 100));
    assert(IsInModule(99, 100));
    assert(!IsInModule(100, 100));
    assert(!IsInModule(101, 100));
    assert(!IsInModule(1, 0));
    assert(!IsInModule(std::numeric_limits<uintptr_t>::max(), 4096));
    return 0;
}
