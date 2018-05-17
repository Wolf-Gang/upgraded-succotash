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
    start_updating();
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
    ::set_position(mOrb, pPos);
    start_updating();
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
  
  void set_position(vec pPos)
  {
    ::set_position(mOrb, pPos);
  }
  
  void start_updating()
  {
    mUpdate = true;
  }
  
  void stop_updating()
  {
    mUpdate = false;
  }
  
  void update_light()
  {
    do
    {
      if(!mUpdate)
        continue;
      if(!light::is_on(mOrb) && lumi.is_lighting(mOrb))
        turn_on();
      else if(light::is_on(mOrb) && !lumi.is_lighting(mOrb))
        turn_off();
    } while(yield());
  }
  
  protected bool mUpdate;
  
  protected light_source mOrb;
}

class symbol_orb : light_orb
{
  symbol_orb(light::orb_symbol pSymbol, string pArea_name)
  {
    super();
    mSymbol = pSymbol;
    mArea_name = pArea_name;
    if(has_flag("orb_" + pArea_name + formatInt(mSymbol) + "_active"))
      light::keep_on(this);
  }
  
  symbol_orb(light::orb_symbol pSymbol, string pArea_name, vec pPos)
  {
    super(pPos);
    mSymbol = pSymbol;
    if(has_flag("orb_" + pArea_name + formatInt(mSymbol) + "_active"))
      light::keep_on(this);
  }
  
  protected light::orb_symbol mSymbol;
  protected string mArea_name;
}

class door_orb : symbol_orb
{
  door_orb(light::orb_symbol pSymbol, string pArea_name)
  {
    super(pSymbol, pArea_name);
  }
  
  void update_light()
  {
    if(light::is_on(mOrb))
      return;
    do
    {
      if(lumi.is_lighting(mOrb))
        activate();
    } while(!light::is_on(this) && yield());
  }
  
  private void activate()
  {
    light::keep_on(this);
    set_flag("orb_" + mArea_name + formatInt(mSymbol) + "_active");
  }
}

namespace light
{
  enum orb_symbol
  {
    below = 0,
    sun,
    rise,
    anew
  }
  
  bool is_on(light_orb@ l)
  {
    return l.is_on();
  }
  
  void keep_on(light_orb@ l)
  {
    l.stop_updating();
    l.turn_on();
  }
}

void set_position(light_orb@ l, vec pPos)
{
  l.set_position(pPos);
}