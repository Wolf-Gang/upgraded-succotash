#include "light.as"

class light_source
{
  light_source() {}
  
  light_source(entity pSource, entity pLight)
  {
    mSource = pSource;
    mLight  = pLight;
  }
  
  void set_source(entity pSource)
  {
    mSource = pSource;
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
    return pPos.distance(get_absolute_position(mSource)) <= mRadius;
  }
  
  void set_radius(float pRadius)
  {
    mRadius = pRadius;
    light::set_radius(mLight, pRadius * 32);
  }
  
  void set_attenuation(float pAttenuation)
  {
    light::set_attenuation(mLight, pAttenuation);
  }
  
  void set_color(color pColor)
  {
    light::set_color(mLight, pColor);
  }
  
  float get_radius()
  {
    return mRadius;
  }
  
  entity opImplConv() const { return mSource; }
  
  private float mRadius;
  
  private entity mSource;
  private entity mLight;
}

namespace light
{

void set_attenuation(light_source l, float pAttenuation)
{
  l.set_attenuation(pAttenuation * 32);
}

void set_radius(light_source l, float pRadius)
{
  l.set_radius(pRadius);
}

void set_color(light_source l, color pColor)
{
  l.set_color(pColor);
}

}