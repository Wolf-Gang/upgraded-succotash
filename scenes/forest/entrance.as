
[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(9.5, 11.7));
}

[start]
void lumi_start()
{
  if(has_flag("the_journey_commences!\\[T]/"))
    return;
  
  lumi::priv::lumi_init();
  lumi::set_user_control(false);
  lumi::detach();
  
  set_position(lumi, vec(3.5, 4.7));
  //
  light::set_radius(lumi, 2);
  light::set_attenuation(lumi, 2);
}

[start]
void handle_groups()
{
  if(has_flag("the_journey_commences!\\[T]/"))
    group::enable("meet_lumi", false);
}

[group meet_lumi]
void meeting()
{
  
  /*
  narrative::start();
  narrative::set_speaker(lumi);
  narrative::set_expression("lumi_expr", "sleepy_talk");
  */
  
  say("Hmm...?");
  nl("The sun?");
  
  //narrative::set_expression("lumi_expr", "excited_talk");
  
  say("Oh!");
  
  //narrative::set_expression("lumi_expr", "talk");
  
  nl("You must be one of those sun folks.");
  
  //narrative::hide();
  //animation_thingy();
  
  say("Nice to meet you.");
  nl("I'm Lumi.");
  nl("I'm the sun...");
  append(" kind of.");
  
  say("I'll explain later.");
  nl("Let's go!");
  
  lumi::attach();
  lumi::set_user_control(true);
  
  // light::set_radius(lumi, lumi::priv::light_radius);
  // light::set_attenuation(lumi, lumi::priv::light_attenuation);
  
  set_flag("the_journey_commences!\\[T]/");
  
  player::lock(false);
  narrative::end();
  group::enable("meet_lumi", false);
}

[group friendlysign]
void readme()
{
  if(lumi.is_lighting(vec(10, 7.9)))
  {
    say("Welcome to the Very Welcoming Forest.");
    nl("Please enjoy your stay!");
  } 
  else
  {
    say("It's too dark to make out anything.");
  }
  player::lock(false);
  narrative::end();
}

