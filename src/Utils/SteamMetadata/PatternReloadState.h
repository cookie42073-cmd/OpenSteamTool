#pragma once

// Reset previous metadata for this module before trying a new load. A prior
// failure must not block a later successful reload, and a failed new load
// must not leave its previously accepted address map behind.
namespace PatternReloadState {
    template <typename Module, typename Maps, typename Failures>
    void Begin(Module module, Maps& maps, Failures& failedModules) {
        maps.erase(module);
        failedModules.erase(module);
    }
}
