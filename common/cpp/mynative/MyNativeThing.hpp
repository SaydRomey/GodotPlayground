#ifndef MY_NATIVE_THING_HPP
#define MY_NATIVE_THING_HPP

#include "godot_includes.hpp"

namespace godot
{
	class MyNativeThing : public Node
	{
		GDCLASS(MyNativeThing, Node)

		protected:
			static void _bind_methods();

		public:
			void _init(); // optional constructor
			String hello();
	};
}

#endif // MY_NATIVE_THING_HPP
