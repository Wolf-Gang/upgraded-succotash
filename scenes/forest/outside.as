#include "util/trees.as"

//[start]
void create_light()
{
	
	light::initialize(); // things will go dark
	entity l = light::add();
	set_parent(l, player::get());
	light::set_color(l, color(1, 0, 0, 1));
	light::set_radius(l, 50);
	light::set_attenuation(l, 40);
	//light::remove(l); // Remove light
	
	entity l1 = light::add();
	set_parent(l1, player::get());
	light::set_color(l1, color(0, 1, 0, 1));
	light::set_radius(l1, 50);
	light::set_attenuation(l1, 40);
	
	entity l2 = light::add();
	set_parent(l2, player::get());
	light::set_color(l2, color(0, 0, 1, 1));
	light::set_radius(l2, 50);
	light::set_attenuation(l2, 40);
	
	float timer = 0;
	while(yield())
	{
		timer += get_delta();
		if (floor(timer % 2) == 0)
			light::set_radius(l, 50);
		else
			light::set_radius(l, 60);
		set_position(l1, vec(2, 0).rotate(360*timer*0.5));
		set_position(l2, vec(2, 0).rotate(360*timer*0.2));
		light::set_radius(l, (cos(timer*math::pi*0.6)+1)*16);
		light::set_attenuation(l, (cos(timer*math::pi*0.2)+1)*100);
		light::set_radius(l1, (cos(timer*math::pi*0.3)+1)*16);
		light::set_radius(l2, (cos(timer*math::pi)+1)*10);
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
	set_z(sunbro_house, -0.5);
}
