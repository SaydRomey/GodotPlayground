
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
