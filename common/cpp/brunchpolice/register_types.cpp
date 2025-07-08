
#include <godot_cpp/godot.hpp>
#include "Brunchpolice.hpp"

using namespace godot;

void	initialize_brunchpolice_module(ModuleInitializationLevel p_level)
{
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE)
	{
		return ;
	}
	ClassDB::register_class<Brunchpolice>();
}

void	uninitialize_brunchpolice_module(ModuleInitializationLevel p_level)
{
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE)
	{
		return ;
	}
	// Cleanup if needed
}

extern "C"
{
	// Must match `entry_symbol` in .gdextension
	GDExtensionBool GDE_EXPORT brunchpolice_init(
		const GDExtensionInterfaceGetProcAddress p_get_proc_address,
		const GDExtensionClassLibraryPtr p_library,
		GDExtensionInitialization* r_initialization
	){
		static GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library, r_initialization);
		
		init_obj.register_initializer(initialize_brunchpolice_module);
		init_obj.register_terminator(uninitialize_brunchpolice_module);
		init_obj.set_minimum_library_initialization_level(MODULE_INITIALIZATION_LEVEL_SCENE);
		
		return (init_obj.init());
	}
}
