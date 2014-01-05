library dartlib.utils.string.StringsUtil;

import 'dart:html';

class StringsUtil
{
  static String removeWhitespace(String string)
  {
    return string.split(' ').join();
  }
}