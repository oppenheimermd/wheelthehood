
import 'package:wheelthehood/core/services/auth_service.dart';
import 'package:wheelthehood/core/view_models/base_model.dart';
import 'package:wheelthehood/locator.dart';

class HomeModel extends BaseModel {

  AuthService authService = locator<AuthService>();

  HomeModel(){
    authService = locator<AuthService>();
  }

}