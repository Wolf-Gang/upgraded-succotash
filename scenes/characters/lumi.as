entity lumi;

namespace lumi
{

namespace priv
{
  const float light_radius = 1.5;
  
  [start]
  void lumi_init()
  {
    if(!has_flag("the_journey_commences!\\[T]/"))
      return;
    
    lumi = add_entity("lumi");
    
    if(has_flag("lumi_attached"))
      lumi::attach();
  }
}

void attach()
{
  set_parent(lumi, player::get());
  set_position(lumi, vec(0, 0));
  //set_atlas(lumi, attached);
  set_flag("lumi_attached");
  dprint("attached");
}

void detach()
{
  detach_parent(lumi);
  //set_atlas(lumi, "default:default");
  unset_flag("lumi_attached");
}

/* bool is_lighting(vec pPos)
{
  
} */

}