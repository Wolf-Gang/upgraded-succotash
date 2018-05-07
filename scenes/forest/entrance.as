#include "util/trees.as"

[start]
void start()
{
	if(!has_came_through_door())
		set_position(player::get(), vec(1.5, 30.5));
}

[start]
void lumi_start()
{
  lumi = add_entity("lumi");
  set_position(lumi, vec(-1.5, 22.5));
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
  
  //do thing
  
  set_flag("the_journey_commences!\\[T]/");
  
  narrative::end();
  group::enable("meet_lumi", false);
}
