
#ifndef BRUNCHPOLICE_HPP
# define BRUNCHPOLICE_HPP

# include "godot_includes.hpp"

namespace godot
{
	class Brunchpolice : public Node
	{
		GDCLASS(Brunchpolice, Node)

		protected:
			static void	_bind_methods();

		public:
			void	_init(); // optional constructor
			String	hello();
	};
}

#endif // BRUNCHPOLICE_HPP
