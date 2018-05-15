#include "../backend/light_source.as"
#include "../backend/float.as"

light_source lumi ();

namespace lumi
{

namespace priv
{
  bool is_attached;
  
  const float light_radius_l = 4;
  const float light_attenuation_l = 3;
  
  const float light_radius_s = 2;
  const float light_attenuation_s = 2.5;
  
  color light_color (1, 1, 1, 1);
  
  [start]
  void lumi_check_flag()
  {
    if(!has_flag("the_journey_commences!\\[T]/"))
      return;
    lumi_init();
  }
  
  [start]
  void check_input()
  {
    while(yield())
    {
      if(has_flag("the_journey_commences!\\[T]/") && is_triggered("lumi"))
      {
        is_attached ? lumi::detach() : lumi::attach();
      }   
    }
  }
  
  void lumi_init()
  {
    entity lumi_e = add_entity("lumi");
    
    entity lumi_light = light::add();
    
    lumi.set_source(lumi_e);
    lumi.set_light(lumi_light);
    
    light::set_radius(lumi, light_radius_l);
    light::set_color(lumi, color(1, 1, 1, 1));
    light::set_attenuation(lumi, light_attenuation_l);
    
    set_parent(lumi, player::get());
    set_position(lumi, vec(0, 0));
	
	float_entity(lumi_e, .1, 5, -1);
	
    is_attached = true;
	
    yield();
    light::remove_bg_light();
  }
}

void attach()
{
  player::lock(true);
  //set_atlas(lumi, "to_player");
  //animation::start(lumi);
  /* get_position(player::get()).distance */ move(lumi, get_position(player::get()), .4);
  //set_atlas(lumi, "attached");
  
  set_parent(lumi, player::get());
  set_position(lumi, vec(0, 0));
  
  light::set_attenuation(lumi, lumi::priv::light_attenuation_l);
  light::set_radius(lumi, lumi::priv::light_radius_l);
  
  light::remove_bg_light();
  
  lumi::priv::is_attached = true;
  
  player::lock(false);
}

void detach()
{
  detach_parent(lumi);
  set_position(lumi, get_position(player::get()));
  //set_atlas(lumi, "default:default");
  
  light::set_attenuation(lumi, lumi::priv::light_attenuation_s);
  light::set_radius(lumi, lumi::priv::light_radius_s);
  
  light::return_bg_light();
  
  lumi::priv::is_attached = false;
}

}