#include "../backend/light_orb.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(5, 9));
}

entity lwall;
entity rwall;
entity ldoor;
entity rdoor;

[start]
void buildawall()
{
  lwall = add_entity("walls", "wall");
  rwall = add_entity("walls", "wall");
  set_position(lwall, vec(6.5, 5));
  set_position(rwall, vec(9.5, 5));
  
  ldoor = add_entity("walls", "ldoor");
  rdoor = add_entity("walls", "rdoor");
  set_position(ldoor, vec(7.5, 5));
  set_position(rdoor, vec(8.5, 5));
}

cracked_orb corb (vec(2.5, 9));
cracked_orb corb2 (vec(3.5, 0));

bool door_open = false;

void open_door()
{
  set_atlas(lwall, "wall_l");
  set_atlas(rwall, "wall_l");
  set_atlas(rdoor, "rdoor_l");
  set_atlas(ldoor, "ldoor_l");
  group::enable("lightdoor", false);
  door_open = true;
  animation::start(rdoor);
  animation::play_wait(ldoor);
}

void close_door()
{
  set_atlas(lwall, "wall");
  set_atlas(rwall, "wall");
  set_atlas(rdoor, "rdoor");
  set_atlas(ldoor, "ldoor");
  group::enable("lightdoor", true);
  door_open = false;
}

[start]
void operate_door()
{
  do
  {
    if(door_open && !(light::is_on(corb) || light::is_on(corb2)))
      close_door();
    else if(!door_open && (light::is_on(corb) || light::is_on(corb2)))
      open_door();
  } while (yield());
}

[group sign]
void goodoldays()
{
  say("All these youngsters these days have forgotten the old ways..");
  say("[X] and [lshift], ya hear me?");
  nl("Those are the ways of the good ol' days...");
  narrative::end();
  player::lock(false);
}