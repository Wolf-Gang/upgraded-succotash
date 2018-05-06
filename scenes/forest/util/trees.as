
entity create_tree()
{
  return add_entity("woods_tilemap", "tree");
}

void create_tree(vec pPos)
{
  entity tree = create_tree();
  set_anchor(tree, anchor::bottom);
  set_position(tree, pPos);
  
  collision::box tree_box = collision::create(collision::type::wall);
  collision::set_position(tree_box, pPos + pixel(-12, -18));
  collision::set_size(tree_box, pixel(24, 16));
}

void create_wall_tree(vec pPos)
{
  entity tree = create_tree();
  set_anchor(tree, anchor::bottom);
  set_position(tree, pPos);
  
  collision::box tree_box = collision::create(collision::type::wall);
  collision::set_position(tree_box, pPos + pixel(-12, -26));
  collision::set_size(tree_box, pixel(24, 30));
}