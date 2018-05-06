#include "util/trees.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(1.5, 30.5));
}