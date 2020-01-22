
import 'package:wheelthehood/core/enums/types.dart';
import 'package:wheelthehood/core/models/user.dart';
import 'package:wheelthehood/core/services/auth_service.dart';
import 'package:wheelthehood/core/view_models/CRUDModel.dart';
import 'package:wheelthehood/core/view_models/base_model.dart';
import 'package:wheelthehood/locator.dart';

class DashboardModel extends BaseModel {
  //UserApi _api = locator<Api>();
  AuthService _authService = locator<AuthService>();
  CRUDModel _crudModel = locator<CRUDModel>();

  User userDetails;

  Future<User> getUser(String uid) async {
    setState(ViewState.Busy);
    var user = await _authService.currentUser();
    userDetails = await _crudModel.getUserById(user.uid);
    setState(ViewState.Idle);
    return userDetails;
  }
}