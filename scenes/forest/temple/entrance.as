#include "../../backend/light_orb.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(3.5, 7));
}

light_orb orb1;
light_orb orb2;
light_orb orb3;
light_orb orb4;

[start]
void orbs()
{
  set_position(orb1, vec(1.5, 7));
  set_position(orb2, vec(5.5, 7));
  set_position(orb3, vec(1.5, 1));
  set_position(orb4, vec(5.5, 1));
  light::keep_on(orb1);
  light::keep_on(orb2);
  light::keep_on(orb3);
  light::keep_on(orb4);
}