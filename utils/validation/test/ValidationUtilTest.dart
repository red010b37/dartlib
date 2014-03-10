import 'package:unittest/html_config.dart';
import 'package:unittest/unittest.dart';
import 'dart:html';

import '../ValidationUtil.dart';




main() {
    
    useHtmlConfiguration();
    //useHtmlEnhancedConfiguration();
    
   testNotEmpty();
}



void testNotEmpty()
{
    test('Not Empty - No string', () => expect(ValidationUtil.validate("", rules:[Rules.NOT_EMPTY]).result, isFalse));
    test('Not Empty - String', () => expect(ValidationUtil.validate("test string 83*##32", rules:[Rules.NOT_EMPTY]).result, isTrue));
}