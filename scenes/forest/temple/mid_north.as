#include "../../backend/light_orb.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(0, 0));
}