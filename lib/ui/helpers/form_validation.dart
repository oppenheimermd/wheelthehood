class EmailFieldValidator {

  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regex = new RegExp(pattern);


  static String validate(String value) {
    //return value.isEmpty ? 'Email can\'t be empty' : null;
    if((value.isEmpty) || (!regex.hasMatch(value)))
    {
      return 'Email not valid';
    }
    else{
      return null;
    }
  }

}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class DisplayNameValidator{
  static int minDisplayLength = 4;
  static String validate(String value){
    if((value.length < minDisplayLength) ||(value.isEmpty)) {
      return 'Display name field must be more than $minDisplayLength characters';
    }else{
      return null;
    }
  }
}