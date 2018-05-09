#include "util/trees.as"

[start]
void create_light()
{
	
	light::initialize(); // things will go dark
	entity l = light::add();
	set_parent(l, player::get());
	//set_position(l, pixel(150, 0)); // you can use set position normally
	light::set_color(l, color(0.6, 0.4, 1, 1));
	light::set_radius(l, 50);
	light::set_attenuation(l, 40);
	//light::remove(l); // Remove light
	
	float timer = 0;
	while(yield())
	{
		timer += get_delta();
		if (floor(timer % 2) == 0)
			light::set_radius(l, 50);
		else
			light::set_radius(l, 60);
	}
}

[start]
void start()
{
	
	if(!has_came_through_door())
		set_position(player::get(), vec(9.375, 2));
}

[start]
void make_house()
{
  entity sunbro_house = add_entity("sunbro_house");
  set_position(sunbro_house, vec(10.5, 1.5));
}
