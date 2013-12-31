import 'dart:html';

import '../src/utils/validation/ValidationUtil.dart';

import 'package:polymer/polymer.dart';

@CustomTag('utils-validation')
class Validation extends PolymerElement {
  
  bool get applyAuthorStyles => true;
  
  @observable bool is_all_valid = false;
  ObservableList errors = new ObservableList();
  
  Validation.created() : super.created();
  
  void onEmailValidateClick(MouseEvent ev)
  {
    ResultMap validationResult = ValidationUtil.validate($['textTestInput'].value, rules:[Rules.EMAIL]);
    
    is_all_valid = validationResult.result;
    errors.clear();
    errors.addAll(validationResult.errors);
  }
  
  void onLengthValidateClick(MouseEvent ev)
  {
    ValidationResult validationResult = ValidationUtil.minLength($['textTestInput'].value, mLength:3);
    
    is_all_valid = validationResult.result;
    errors.clear();
    errors.addAll([validationResult]);
  }
  
  void onValidateAllClick(MouseEvent ev)
  {
    ResultMap validationResult = ValidationUtil.validate($['textTestInput'].value, rules:[Rules.ALL]);
    
    errors.clear();
    errors.addAll(validationResult.errors);
    //print(errors);
    
    is_all_valid = (ValidationUtil.validate($['textTestInput'].value, rules:[Rules.ALL]).result);
  }
}

