#include "util/trees.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(1.5, 30.5));
}

[start]
void lumi_start()
{
  lumi = add_entity("lumi");
  set_position(lumi, vec(-1.5, 22.5));
}

[group meet_lumi]
void meeting()
{
  
}
