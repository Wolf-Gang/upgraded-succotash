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
  lwall = add_entity("woods_tilemap", "old_wall");
  rwall = add_entity("woods_tilemap", "old_wall");
  set_position(lwall, vec(6.5, 5));
  set_position(rwall, vec(9.5, 5));
  
  ldoor = add_entity("woods_tilemap", "l_old_door");
  rdoor = add_entity("woods_tilemap", "r_old_door");
  set_position(ldoor, vec(7.5, 5));
  set_position(rdoor, vec(8.5, 5));
}

light_orb cracked_orb (vec(2.5, 9));
light_orb cracked_orb2 (vec(3.5, 0));

[start]
void imtired()
{
  cracked_orb.update_light();
}

[start]
void imtiredtoo()
{
  cracked_orb2.update_light();
}

bool door_open = false;

void open_door()
{
  set_atlas(lwall, "old_wall_l");
  set_atlas(rwall, "old_wall_l");
  set_atlas(rdoor, "r_old_door_open");
  set_atlas(ldoor, "l_old_door_open");
  group::enable("lightdoor", false);
  door_open = true;
  animation::start(rdoor);
  animation::play_wait(ldoor);
}

void close_door()
{
  set_atlas(lwall, "old_wall");
  set_atlas(rwall, "old_wall");
  set_atlas(rdoor, "r_old_door");
  set_atlas(ldoor, "l_old_door");
  group::enable("lightdoor", true);
  door_open = false;
}

[start]
void operate_door()
{
  do
  {
    if(door_open && !(light::is_on(cracked_orb) || light::is_on(cracked_orb2)))
      close_door();
    else if(!door_open && (light::is_on(cracked_orb) || light::is_on(cracked_orb2)))
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