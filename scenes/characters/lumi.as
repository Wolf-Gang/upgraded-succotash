#include "../backend/light_source.as"
#include "../backend/float.as"

light_source lumi ();

namespace lumi
{

namespace priv
{
  bool is_attached;
  bool can_control = true;
  
  const float light_radius_l = 4;
  const float light_attenuation_l = 3;
  
  const float light_radius_s = 2;
  const float light_attenuation_s = 2.5;
  
  vec light_offset = vec(0, -.5);
  
  color light_color (.95, .95, 1, 1);
  
  void use_small_light_texture()
  {
    set_texture(lumi, "lumi-small-light");
    set_atlas(lumi, "default:default");
  }
  
  void use_lumi_texture()
  {
    set_texture(lumi, "lumi");
    set_atlas(lumi, "default:default");
  }
  
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
      if(has_flag("the_journey_commences!\\[T]/") && is_triggered("lumi") && can_control)
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
    lumi.set_light_offset(light_offset);
    
    light::set_radius(lumi, light_radius_l);
    light::set_color(lumi, light_color);
    light::set_attenuation(lumi, light_attenuation_l);
    
    use_small_light_texture();
    set_z(lumi, get_z(lumi) + 1);
    set_parent(lumi, player::get());
    set_position(lumi, vec(0, 0));
	
    float_entity(lumi, .1, 5, -1);
    
    is_attached = true;
  
    yield();
    light::remove_bg_light();
  }
}

void set_user_control(bool pY)
{
  lumi::priv::can_control = pY;
}

void attach()
{
  player::lock(true);
  set_z(lumi, get_z(lumi) + 1);
  lumi::priv::use_small_light_texture();
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
  set_z(lumi, get_z(lumi) - 1);
  lumi::priv::use_lumi_texture();
  detach_parent(lumi);
  set_position(lumi, get_position(player::get()));
  //set_atlas(lumi, "default:default");
  
  light::set_attenuation(lumi, lumi::priv::light_attenuation_s);
  light::set_radius(lumi, lumi::priv::light_radius_s);
  
  light::return_bg_light();
  
  lumi::priv::is_attached = false;
}

}