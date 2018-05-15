void float_entity(entity pFloater, float pHeight, float pPeriod, float pCycles = 1)
{
  create_thread(function(args)
  {
    entity pFloater = entity(args["pFloater"]);
    float pHeight = float(args["pHeight"]);
    float pPeriod = float(args["pPeriod"]);
    float pCycles = float(args["pCycles"]);
    float t = 0;
    if(pCycles < 0)
    {
      do{
        //The derivative of the sine function (the cosine function) is used here and below so that it doesn't
        //mess up other things that would affect z value
        // Note: This is still subject to floating point errors and the accuracy of the system's cosine approximate.
        //   This may result is the origin shifting after an extended amount of time.
        set_z(pFloater, get_z(pFloater) + (pHeight * cos((t * 2 * math::pi) / pPeriod) * get_delta()));
        t  = (t + get_delta()) % pPeriod;
      } while(yield());
    } else {
      for(t; t < pCycles * pPeriod; t += get_delta())
      {
        set_z(pFloater, get_z(pFloater) + pHeight * cos(t * 2 * math::pi * pPeriod) * get_delta());
        yield();
      }
    }
  }, dictionary = {{"pFloater", pFloater}, {"pHeight", pHeight}, {"pPeriod", pPeriod}, {"pCycles", pCycles}});
  
}

