#include "util/trees.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(9.375, 2));
}

[start]
void make_house()
{
  entity sunbro_house = add_entity("sunbro_house");
  set_position(sunbro_house, vec(10.5, 1.5));
}
