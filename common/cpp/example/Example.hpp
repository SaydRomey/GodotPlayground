
#ifndef EXAMPLE_HPP
# define EXAMPLE_HPP

# include "godot_includes.hpp"

namespace godot
{
	class Example : public Node
	{
		GDCLASS(Example, Node)

		protected:
			static void	_bind_methods();

		public:
			void	_init(); // optional constructor
			String	hello();
	};
}

#endif // EXAMPLE_HPP
