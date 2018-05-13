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
    rightwalls.insertLast(add_entity("woods_tilemap", "old_wall"));
    set_position(rightwalls[i], vec(9.5 - i, 6));
  }
  
  rightdoor = add_entity("woods_tilemap", "r_old_door");
  set_position(rightdoor, vec(6.5, 6));
  
  leftdoor = add_entity("woods_tilemap", "l_old_door");
  set_position(leftdoor, vec(5.5, 6));
  
  for(uint i = 0; i < 4; i++)
  {
    leftwalls.insertLast(add_entity("woods_tilemap", "old_wall"));
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
  set_atlas(rightdoor, "r_old_door_open");
  set_atlas(leftdoor, "l_old_door_open");
  animation::start(rightdoor);
  animation::start(leftdoor);
  
  for(uint i = 0; i < 3; i++)
    set_atlas(rightwalls[i], "old_wall_l");
  for(uint i = 0; i < 4; i++)
    set_atlas(leftwalls[i], "old_wall_l");
  
  group::enable("lightdoor", false);
}

entity orb1;
bool orb1_light = false;

[start]
void orbl()
{
  orb1 = add_entity("woods_tilemap", "orb");
  set_position(orb1, vec(4.5, 7));
  
  if(has_flag("first_puzzle"))
  {
    set_atlas(orb1, "orb_l");
    return;
  }
  
  while(!has_flag("first_puzzle") && yield())
  {
    if(!orb1_light && lumi.is_lighting(orb1))
    {
      set_atlas(orb1, "orb_l");
      orb1_light = true;
    }
    else if(orb1_light && !lumi.is_lighting(orb1))
    {
      set_atlas(orb1, "orb");
      orb1_light = false;
    }
  }
  
  set_atlas(orb1, "orb_l");
}

entity orb2;
bool orb2_light = false;

[start]
void orbr()
{
  orb2 = add_entity("woods_tilemap", "orb");
  set_position(orb2, vec(7.5, 7));
  
  if(has_flag("first_puzzle"))
  {
    set_atlas(orb2, "orb_l");
    return;
  }
  
  while(!has_flag("first_puzzle") && yield())
  {
    if(!orb2_light && lumi.is_lighting(orb2))
    {
      set_atlas(orb2, "orb_l");
      orb2_light = true;
    }
    else if(orb2_light && !lumi.is_lighting(orb2))
    {
      set_atlas(orb2, "orb");
      orb2_light = false;
    }
  }
  
  set_atlas(orb2, "orb_l");
}

[start]
void check_orbs()
{
  if(has_flag("first_puzzle"))
    return;
  do
  {
    if(!orb1_light && !orb2_light)
      continue;
    
    set_flag("first_puzzle");
    open_door();
    return;
  } while (yield());
}