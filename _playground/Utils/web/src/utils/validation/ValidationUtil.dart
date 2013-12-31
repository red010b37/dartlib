library dartlib.utils.validation.ValidationUtil;

import 'dart:html';

class ValidationUtil
{
  static ResultMap validate(String validationText, {List rules, Element helper:null})
  {
    ResultMap resultMap = new ResultMap();
    List<ValidationResult> results = new List<ValidationResult>();
    
    if(rules.contains(Rules.ALL)) rules = [Rules.EMAIL, Rules.NO_SLASHES, Rules.NO_WHITESPACE, Rules.NOT_EMPTY];
    
    for(int i = 0; i < rules.length; i++)
    {
      switch(rules[i])
      {
        case Rules.EMAIL :
          results.add(asEmail(validationText, helper:helper));
          break;
          
        case Rules.MIN_LENGTH :
          results.add(minLength(validationText, helper:helper));
          break;
          
        case Rules.NOT_EMPTY :
          results.add(notEmpty(validationText, helper:helper));
          break;
          
        case Rules.NO_WHITESPACE :
          results.add(noWhitespace(validationText, helper:helper));
          break;
          
        case Rules.NO_SLASHES :
          results.add(noSlashes(validationText, helper:helper));
          break;
      }
    }
    
    int valid = 0;
    for(int i = 0; i < results.length; i++)
    {
      resultMap.errors.add(results[i]);
      if(results[i].result){
        valid++;
      }
    }
    
    resultMap.result = (valid == results.length);

    return resultMap;
  }
  
  /**
   * As Email
   * 
   * Check if the String is a valid email address
   * 
   * @param String    validationText            The String to validate
   * @param Element   helper                    An element that can be shown or hidden for error fix hinting
   */ 
  static ValidationResult asEmail(String validationText, {Element helper:null})
  {
    ValidationResult result;
    String exp = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(exp);
    
    if(regExp.hasMatch(validationText))
    {
      hideHelper(helper:helper);
      
      return result = new ValidationResult(true, Rules.EMAIL);
    } else {
      showHelper(helper:helper);
      
      return result = new ValidationResult(false, Rules.EMAIL);
    }
  }
  
  /**
   * Min Length
   * 
   * Check if the String length meets the min length
   * 
   * @param String    validationText            The String to validate
   * @param int       mLength                   Minimum length of the String
   * @param Element   helper                    An element that can be shown or hidden for error fix hinting
   */ 
  static ValidationResult minLength(String validationText, {int mLength, Element helper:null})
  {
    ValidationResult result;
    
    if(validationText.length >= mLength)
    {
      hideHelper(helper:helper);
      
      return result = new ValidationResult(true, Rules.MIN_LENGTH);
    } else {
      showHelper(helper:helper);
      
      return result = new ValidationResult(false, Rules.MIN_LENGTH);
    }
  }
  
  /**
   * Not Empty
   * 
   * Make sure the String has characters in it
   * 
   * @param String    validationText            The String to validate
   * @param Element   helper                    An element that can be shown or hidden for error fix hinting
   */ 
  static ValidationResult notEmpty(String validationText, {Element helper:null})
  {
    ValidationResult result;
    
    if(minLength(validationText, mLength:1, helper:helper).result)
    {
      return result = new ValidationResult(true, Rules.NOT_EMPTY);
    } else {
      return result = new ValidationResult(false, Rules.NOT_EMPTY);
    }
  }
  
  /**
   * No Whitespace
   * 
   * Make sure the String has characters in it
   * 
   * @param String    validationText            The String to validate
   * @param Element   helper                    An element that can be shown or hidden for error fix hinting
   */ 
  static ValidationResult noWhitespace(String validationText, {Element helper:null})
  {
    ValidationResult result;
    
    if(validationText.contains(' '))
    {
      hideHelper(helper:helper);
      
      return result = new ValidationResult(false, Rules.NO_WHITESPACE);
    } else {
      showHelper(helper:helper);
      
      return result = new ValidationResult(true, Rules.NO_WHITESPACE);
    }
  }
  
  /**
   * Has slashes
   * 
   * Checks if the String contains any slashes. ie / or \
   * 
   * @param String    validationText            The String to validate
   * @param Element   helper                    An element that can be shown or hidden for error fix hinting
   */ 
  static ValidationResult noSlashes(String validationText, {Element helper:null})
  {
    ValidationResult result;
    
    if(validationText.contains('\\') || validationText.contains('/'))
    {
      hideHelper(helper:helper);
      
      return result = new ValidationResult(false, Rules.NO_SLASHES);
    } else {
      showHelper(helper:helper);
      
      return result = new ValidationResult(true, Rules.NO_SLASHES);
    }
  }
  
  static void showHelper({ParagraphElement helper:null})
  {
    if(helper != null)
    {
      helper.classes.remove('hide');
      helper.classes.add('show');
    }
  }
  
  static void hideHelper({ParagraphElement helper:null})
  {
    if(helper != null)
    {
      helper.classes.add('hide');
      helper.classes.remove('show');
    }
  }
}

class ValidationResult
{
  bool _result = false;
  int _errorCode = -1;
  String _errorType = "";
  
  ValidationResult(this._result, this._errorType)
  {
    
  }
  
  bool get result => _result;
  void set result(bool val)
  {
    _result = val;
  }
  
  int get errorCode => _errorCode;
  void set errorCode(int val)
  {
    _errorCode = val;
  }
  
  String get errorType => _errorType;
  void set errorType(String val)
  {
    _errorType = val;
  }
}

class ResultMap
{
  bool _result = false;
  List<ValidationResult> _errors = new List<ValidationResult>();
  
  ResultMap()
  {
    
  }
  
  bool get result => _result;
  void set result(bool val)
  {
    _result = val;
  }
  
  List<ValidationResult> get errors => _errors;
  void set errors(List<ValidationResult> val)
  {
    _errors = val;
  }
}

class Rules
{
  static const String ALL = "all";
  static const String NOT_EMPTY = "not_empty";
  static const String MIN_LENGTH = "min_length";
  static const String EMAIL = "email";
  static const String NO_SLASHES = "no_slashes";
  static const String NO_WHITESPACE = "no_whitespace";
}