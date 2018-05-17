#include "../../backend/light_orb.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(3.5, 5));
}

symbol_orb west (light::orb_symbol::sun, "forest_temple");
symbol_orb east (light::orb_symbol::rise, "forest_temple");

[start]
void orbs()
{
  set_position(west, vec(1.5, 5));
  set_position(east, vec(5.5, 5));
}