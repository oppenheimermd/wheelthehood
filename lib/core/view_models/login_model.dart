
import 'package:wheelthehood/core/models/user.dart';
import 'package:wheelthehood/core/services/auth_service.dart';
import 'package:wheelthehood/core/view_models/base_model.dart';
import 'package:wheelthehood/locator.dart';

class LoginModel extends BaseModel{

  LoginModel(){
    authService = locator<AuthService>();
  }

  AuthService authService = locator<AuthService>();



  Future<bool> signInWithGoogle() async {
    try {
      final User _user = await authService.signInWithGoogle();
      var success = _user == null? false : true;
      return success;
    }
    catch(e){
      print('Google SignIn Error: $e');
      return false;
    }
  }

}