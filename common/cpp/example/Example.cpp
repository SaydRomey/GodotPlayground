
#include "Example.hpp"

using namespace godot;

void Example::_bind_methods()
{
	ClassDB::bind_method(D_METHOD("hello"), &Example::hello);
}

void Example::_init()
{
	// Initialization here
}

String Example::hello()
{
	return ("Hello from C++!");
}
