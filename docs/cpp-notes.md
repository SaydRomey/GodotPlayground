
# Notes - cpp gdnative `.so` (shared object) library

## TODO

### Auto-add class to `register_types.cpp`
If we add `BaseState` or `PlayerController`, auto-insert into:
```cpp
#include "BaseState.hpp"
// [...]
    godot::ClassDB::register_class<BaseState>();
```
Can be done with `sed` or a small Python helper.

---

## Template-like `mynative` for cloning

### `common/cpp/mynative/`

```hpp
// godot_includes.hpp
#pragma once

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/godot.hpp>
```
```py
# SConstruct
import os

env = Environment()
env['CXX'] = 'g++'
env.Append(CXXFLAGS=['-std=c++17', '-g', '-fPIC'])

GODOT_CPP = '../godot-cpp'
env.Append(CPPPATH=[
    f"{GODOT_CPP}/godot-headers",
    f"{GODOT_CPP}/include",
    f"{GODOT_CPP}/gen/include",
	f"{GODOT_CPP}/gdextension"
])
env.Append(LIBPATH=[f"{GODOT_CPP}/bin"])
env.Append(LINKFLAGS=[
    '-Wl,--whole-archive',
    f"{GODOT_CPP}/bin/libgodot-cpp.linux.template_debug.x86_64.a",
    '-Wl,--no-whole-archive'
])

sources = Glob("*.cpp")
env.SharedLibrary("mynative", sources)
```

> [!NOTE]
> TODO better
```cpp
// register_types.cpp
#include <godot_cpp/godot.hpp>
#include "MyNativeThing.hpp"

using namespace godot;

void initialize_mynative_module(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
		return;
	}
	ClassDB::register_class<MyNativeThing>();
}

void uninitialize_mynative_module(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
		return;
	}
	// Cleanup if needed
}

extern "C" {

	// Must match `entry_symbol` in .gdextension
	GDExtensionBool GDE_EXPORT my_native_library_init(const GDExtensionInterfaceGetProcAddress p_get_proc_address,
													  const GDExtensionClassLibraryPtr p_library,
													  GDExtensionInitialization *r_initialization) {
		static GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library, r_initialization);
	
		init_obj.register_initializer(initialize_mynative_module);
		init_obj.register_terminator(uninitialize_mynative_module);
		init_obj.set_minimum_library_initialization_level(MODULE_INITIALIZATION_LEVEL_SCENE);
	
		return init_obj.init();
	}
}
```

---

## Symlink the .so library

For the C++ files, because we are not directly using 
.cpp or .hpp files in our Godot project — 
we are using the compiled .so (shared object) library instead.\

### Symlink the .so library
> (we might use this in scripts)
```bash
ln -s ../../../common/cpp/mynative/libmynative.so native/libmynative.so
```
This means:
- The `.so` file is exposed to **Godot** through the `native/` folder.
- Godot only needs that symlink to load our GDExtension.

### Should we symlink every `.cpp`/`.hpp`?

No. The `.cpp` and `.hpp` files are:
- Used only during compilation via `scons`.
- Located in `common/cpp/mynative/`.

As long as our `Makefile` targets (e.g., `cpp-build`) 
know where to find and build them, we're all set.

### When should we re-link .so?
Only if:
- The `.so` is moved.
- The symlink breaks.
- We're creating a new project and want to use the same `.so`.

Then we just re-create that one symlink to `libmynative.so`.