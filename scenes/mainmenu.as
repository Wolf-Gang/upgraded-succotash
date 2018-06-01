
[start]
void start()
{
	set_visible(player::get(), false);
  entity B = add_entity("main");
  set_anchor(B, anchor::topleft);
  make_gui(B, 0);
}

menu mm;

[start]
void mainmenu()
{
  /* array<text_entry> = {
    text_entry
  }; */
}