[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(9.375, 3.6));
}

[start]
void make_house()
{
  entity sunbro_house = add_entity("sunbro_house");
  set_position(sunbro_house, vec(10.5, 3));
}

void create_tree(vec pPos)
{
  entity tree = create_tree();
  set_position(tree, pPos);
}

entity create_tree()
{
  return add_entity("woods_tilemap", "tree");
}

[start]
void create_forest()
{
  //TODO
}