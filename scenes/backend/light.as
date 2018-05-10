
namespace light
{

namespace priv
{
  entity bg_light;
  [start]
  void setup()
  {
    light::initialize();
    
    bg_light = light::add();
    light::set_color(bg_light, color(0, .1, 1, .3));
    light::set_radius(bg_light, 128);
    light::set_attenuation(bg_light, 96);
    
    set_parent(bg_light, player::get());
  }
}

}