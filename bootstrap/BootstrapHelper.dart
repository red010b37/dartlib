library dartlib.util.BootstrapHelper;

import 'dart:html';




// BOOTSTRAP DD FUNCTIONALITY

void bootstrapDropdownCreate(List ddItems)
{
  
  for(Element element in ddItems)
  {
    element.onMouseOver.listen((e) => bootstrapDropdownMouseOver(e));
    element.onMouseOut.listen((e) => bootstrapDropdownMouseOut(e));
  }
}


void bootstrapDropdownMouseOver(MouseEvent e)
{
  e.preventDefault();
  Element el = e.currentTarget;
  el.classes.add('open');
}

void bootstrapDropdownMouseOut(MouseEvent e)
{
  e.preventDefault();
  Element el = e.currentTarget;
  el.classes.remove('open');
}
