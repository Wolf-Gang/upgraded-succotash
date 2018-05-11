#include "../backend/light_source.as"

light_source lumi ();

namespace lumi
{

namespace priv
{
  const float light_radius = 4;
  const float light_attenuation = 3;
  
  [start]
  void lumi_check_flag()
  {
    if(!has_flag("the_journey_commences!\\[T]/"))
      return;
    lumi_init();
  }
  
  void lumi_init()
  {
    entity lumi_e = add_entity("lumi");
    
    entity lumi_light = light::add();
    
    lumi.set_source(lumi_e);
    lumi.set_light(lumi_light);
    
    light::set_radius(lumi, light_radius);
    light::set_color(lumi, color(1, 1, 1, 1));
    light::set_attenuation(lumi, light_attenuation);
    
    if(has_flag("lumi_attached"))
      lumi::attach();
  }
}

void attach()
{
  set_parent(lumi, player::get());
  set_position(lumi, vec(0, 0));
  //set_atlas(lumi, attached);
  
  yield();
  light::remove_bg_light();
  
  set_flag("lumi_attached");
}

void detach()
{
  detach_parent(lumi);
  //set_atlas(lumi, "default:default");
  
  light::return_bg_light();
  
  unset_flag("lumi_attached");
}

}