#include "util/trees.as"

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

[start]
void create_forest()
{
  create_tree(vec(7, 2.5));
  
  //top
  create_tree(vec(.7, .3));
  for(uint i = 0; i < 10; i++)
    create_tree(vec(4.3 + i, .3));
  
  //bottom
  for(uint i = 0; i < 15; i++)
    create_tree(vec(.3 + i, 9.3));
  
  //left
  for(uint i = 0; i < 9; i++)
    create_wall_tree(vec(-.3, .3 + i));
  
  //right
  for(uint i = 0; i < 9; i++)
    create_wall_tree(vec(14.3, .3 + i));
  
  //forest entrance
  create_tree(vec(1.3, -.4));
  create_tree(vec(3.7, -.4));
  
}