#include "light.as"

class light_source
{
  light_source() {}
  
  light_source(entity pSource, entity pLight)
  {
    set_source(pSource);
    set_light(pLight);
  }
  
  void set_source(entity pSource)
  {
    mSource = pSource;
    
    if(mLight.is_valid())
    {
      add_child(mSource, mLight);
      set_position(mLight, vec(0, 0));
    }
  }
  
  void set_light(entity pLight)
  {
    mLight = pLight;
    light::set_radius(mLight, mRadius * 32);
    
    if(mSource.is_valid())
    {
      set_parent(mLight, mSource);
      set_position(mLight, vec(0, 0));
    }
  }
  
  bool is_lighting(vec pPos)
  {
    return pPos.distance(get_absolute_position(mSource) - vec(6, 5) + get_position(player::get())) <= mRadius;
  }
  
  bool is_lighting(entity e)
  {
    return get_absolute_position(mSource).distance(get_absolute_position(e)) <= mRadius;
  }
  
  void turn_on()
  {
    is_on = true;
    light::set_color(mLight, mColor);
  }
  
  void turn_off()
  {
    is_on = false;
    light::set_color(mLight, light::off);
  }
  
  void set_radius(float pRadius)
  {
    mRadius = pRadius;
    light::set_radius(mLight, pRadius * 32);
  }
  
  void set_attenuation(float pAttenuation)
  {
    light::set_attenuation(mLight, pAttenuation * 32);
  }
  
  void set_color(color pColor)
  {
    mColor = pColor;
    light::set_color(mLight, mColor);
  }
  
  float get_radius()
  {
    return mRadius;
  }
  
  entity opImplConv() const { return mSource; }
  
  private bool is_on;
  
  private color mColor;
  
  private float mRadius;
  
  private entity mSource;
  private entity mLight;
}

namespace light
{

void set_attenuation(light_source@ l, float pAttenuation)
{
  l.set_attenuation(pAttenuation);
}

void set_radius(light_source@ l, float pRadius)
{
  l.set_radius(pRadius);
}

void set_color(light_source@ l, color pColor)
{
  l.set_color(pColor);
}

void turn_on(light_source@ l, bool pOn = true)
{
  pOn ? l.turn_on() : l.turn_off();
}
  
void turn_off(light_source@ l)
{
  turn_on(l, false);
}

}