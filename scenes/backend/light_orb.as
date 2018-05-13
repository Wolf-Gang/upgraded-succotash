#include "light_source.as"

color orb_color (1, 1, .8, .7);
const float orb_radius = .7;
const float orb_attenuation = 1;
const vec orb_offset (0, -.5);

class light_orb
{
  light_orb()
  {
    mOrb.set_source(add_entity("woods_tilemap", "orb"));
    mOrb.set_light(light::add());
    
    light::set_radius(mOrb, orb_radius);
    light::set_color(mOrb, color(1, 1, .8, .7));
    //light::set_color(mOrb, orb_color);
    light::set_attenuation(mOrb, orb_attenuation);
    
    mOrb.set_light_offset(vec(0, -.5));
    //mOrb.set_light_offset(orb_offset);
    mOrb.turn_off();
  }
  
  light_orb(vec pPos)
  {
    mOrb.set_source(add_entity("woods_tilemap", "orb"));
    mOrb.set_light(light::add());
    
    light::set_color(mOrb, color(1, 1, .8, .7));
    //light::set_color(mOrb, orb_color);
    light::set_radius(mOrb, orb_radius);
    light::set_attenuation(mOrb, orb_attenuation);
    
    mOrb.set_light_offset(vec(0, -.5));
    //mOrb.set_light_offset(orb_offset);
    mOrb.turn_off();
    set_position(mOrb, pPos);
  }
  
  void update_light()
  {
    if(!light::is_on(mOrb) && lumi.is_lighting(mOrb))
      turn_on();
    else if(light::is_on(mOrb) && !lumi.is_lighting(mOrb))
      turn_off();
  }
  
  bool is_on()
  {
    return light::is_on(mOrb);
  }
  
  void turn_on()
  {
    light::turn_on(mOrb);
    set_atlas(mOrb, "orb_l");
  }
  
  void turn_off()
  {
    light::turn_off(mOrb);
    set_atlas(mOrb, "orb");
  }
  
  private light_source mOrb;
}

namespace light
{
  bool is_on(light_orb@ l)
  {
    return l.is_on();
  }
}