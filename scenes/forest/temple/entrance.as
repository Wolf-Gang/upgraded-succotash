#include "../../backend/light_orb.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(3.5, 7));
}

on_orb orb1 (vec(1.5, 7));
on_orb orb2 (vec(5.5, 7));
on_orb orb3 (vec(1.5, 1));
on_orb orb4 (vec(5.5, 1));
