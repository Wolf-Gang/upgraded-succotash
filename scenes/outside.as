[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(0, 0));
}

[start]
void make_house()
{
  entity sunbro_house = add_entity("sunbro_house");
  set_position(sunbro_house, vec(10.5, 3));
}