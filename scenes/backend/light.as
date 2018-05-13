
namespace light
{

const color off (0, 0, 0, 0);

namespace priv
{
  entity bg_light;
  const color bg_color (0, .1, 1, .3);
  
  [start]
  void setup()
  {
    light::initialize();
    
    bg_light = light::add();
    light::set_color(bg_light, light::priv::bg_color);
    light::set_radius(bg_light, 128);
    light::set_attenuation(bg_light, 96);
    
    set_parent(bg_light, player::get());
  }
}

void remove_bg_light()
{
  set_color(light::priv::bg_light, off);
}

void return_bg_light()
{
  set_color(light::priv::bg_light, light::priv::bg_color);
}

//note: this can also make the radius smaller
void expand(entity l, float pRadius, float pTime)
{
  float rate = (light::get_radius(l) - pRadius)/pTime;
  
  for(float t = 0; t < pTime; t += get_delta())
  {
    light::set_radius(l, light::get_radius(l) + rate * get_delta());
    yield();
  }
  light::set_radius(l, pRadius);
}

}