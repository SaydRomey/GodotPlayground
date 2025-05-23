#include "MyNativeThing.hpp"

using namespace	godot;

void MyNativeThing::_bind_methods()
{
	ClassDB::bind_method(D_METHOD("hello"), &MyNativeThing::hello);
}

void MyNativeThing::_init()
{
	// Initialization here
}

String MyNativeThing::hello()
{
	return ("Hello from C++!");
}
