#include "../backend/light_orb.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(6, 11));
}

array<entity> rightwalls;
array<entity> leftwalls;
entity rightdoor;
entity leftdoor;

[start]
void buildawall()
{
  for(uint i = 0; i < 3; i++)
  {
    rightwalls.insertLast(add_entity("walls", "wall"));
    set_position(rightwalls[i], vec(9.5 - i, 6));
  }
  
  rightdoor = add_entity("walls", "rdoor");
  set_position(rightdoor, vec(6.5, 6));
  
  leftdoor = add_entity("walls", "ldoor");
  set_position(leftdoor, vec(5.5, 6));
  
  for(uint i = 0; i < 4; i++)
  {
    leftwalls.insertLast(add_entity("walls", "wall"));
    set_position(leftwalls[i], vec(4.5 - i, 6));
  }
}

[start]
void check_door()
{
  if(has_flag("first_puzzle"))
    open_door();
}

void open_door()
{
  set_atlas(rightdoor, "rdoor_l");
  set_atlas(leftdoor, "ldoor_l");
  animation::start(rightdoor);
  animation::start(leftdoor);
  
  for(uint i = 0; i < 3; i++)
    set_atlas(rightwalls[i], "wall_l");
  for(uint i = 0; i < 4; i++)
    set_atlas(leftwalls[i], "wall_l");
  
  group::enable("lightdoor", false);
}

light_orb orb1;

[start]
void orbl()
{
  set_position(orb1, vec(4.5, 7));
  
  if(has_flag("first_puzzle"))
  {
    light::keep_on(orb1);
    return;
  }
  
  orb1.update_light();
}

light_orb orb2;

[start]
void orbr()
{
  set_position(orb2, vec(7.5, 7));
  
  if(has_flag("first_puzzle"))
  {
    light::keep_on(orb2);
    return;
  }
  
  orb2.update_light();
}

[start]
void check_orbs()
{
  if(has_flag("first_puzzle"))
    return;
  do
  {
    if(!light::is_on(orb1) || !light::is_on(orb2))
      continue;
    
    set_flag("first_puzzle");
    open_door();
    return;
  } while (yield());
}