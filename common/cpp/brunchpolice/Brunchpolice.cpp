
#include "Brunchpolice.hpp"

using namespace godot;

void Brunchpolice::_bind_methods()
{
	ClassDB::bind_method(D_METHOD("hello"), &Brunchpolice::hello);
}

void Brunchpolice::_init()
{
	// Initialization here
}

String Brunchpolice::hello()
{
	return ("Hello from C++!");
}
