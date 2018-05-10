
[start]
void start()
{
  if(!has_came_through_door())
    set_position(player::get(), vec(3.75, 1.5));
}

[start]
void inital_day()
{
  if(!has_flag("sun's_out"))
  {
    light::set_color(light::priv::bg_light, color(1, 1, 1, 1));
    light::set_radius(light::priv::bg_light, 1500);
  }
}