#include "light.as"

class light_source
{
  light_source()
  {
    mIs_on = true;
  }
  
  light_source(entity pSource, entity pLight)
  {
    mIs_on = true;
    mLight_offset = vec(0, 0);
    set_source(pSource);
    set_light(pLight);
  }
  
  void set_source(entity pSource)
  {
    mSource = pSource;
    
    if(mLight.is_valid())
    {
      add_child(mSource, mLight);
      set_position(mLight, mLight_offset);
    }
  }
  
  void set_light(entity pLight)
  {
    mLight = pLight;
    light::set_radius(mLight, mRadius * 32);
    
    if(mSource.is_valid())
    {
      set_parent(mLight, mSource);
      set_position(mLight, mLight_offset);
    }
  }
  
  void set_light_offset(vec pOffset)
  {
    mLight_offset = pOffset;
    set_position(mLight, mLight_offset);
  }
  
  bool is_lighting(vec pPos)
  {
    if(!mIs_on)
      return false;
    return pPos.distance(get_absolute_position(mLight) - vec(6, 5) + get_position(player::get())) <= mRadius;
  }
  
  bool is_lighting(entity e)
  {
    if(!mIs_on)
      return false;
    return get_absolute_position(mLight).distance(get_absolute_position(e)) <= mRadius;
  }
  
  void turn_on()
  {
    mIs_on = true;
    light::set_color(mLight, mColor);
  }
  
  void turn_off()
  {
    mIs_on = false;
    light::set_color(mLight, light::off);
  }
  
  bool is_on()
  {
    return mIs_on;
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
    if(mIs_on)
      light::set_color(mLight, mColor);
  }
  
  float get_radius()
  {
    return mRadius;
  }
  
  entity opImplConv() const { return mSource; }
  
  private bool mIs_on;
  
  private color mColor;
  
  private float mRadius;
  
  private entity mSource;
  private entity mLight;
  
  private vec mLight_offset;
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

void turn_on(light_source@ l)
{
  l.turn_on();
}
  
void turn_off(light_source@ l)
{
  l.turn_off();
}

bool is_on(light_source@ l)
{
  return l.is_on();
}

}