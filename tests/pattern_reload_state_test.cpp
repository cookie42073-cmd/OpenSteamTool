#include "Utils/SteamMetadata/PatternReloadState.h"
#include <cassert>
#include <unordered_map>
#include <unordered_set>

int main() {
    std::unordered_map<int, int> maps{{1, 42}, {2, 99}};
    std::unordered_set<int> failures{1, 3};
    // Retrying failed module 1 clears both stale metadata and failed status.
    PatternReloadState::Begin(1, maps, failures);
    assert(!maps.contains(1));
    assert(!failures.contains(1));
    assert(maps.at(2) == 99);
    assert(failures.contains(3));
    // A later success can populate fresh metadata; a new attempt clears it.
    maps[1] = 123;
    PatternReloadState::Begin(1, maps, failures);
    assert(!maps.contains(1));
    // Previously failed module without a map becomes eligible for retry.
    PatternReloadState::Begin(3, maps, failures);
    assert(!failures.contains(3));
    return 0;
}
