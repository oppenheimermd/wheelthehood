
import 'package:wheelthehood/core/enums/types.dart';
import 'package:wheelthehood/core/services/auth_service.dart';
import 'package:wheelthehood/core/view_models/base_model.dart';
import 'package:wheelthehood/locator.dart';


class RootModel extends BaseModel{
  final AuthService authService = locator<AuthService>();
  String errorMessage;
  AuthStatus authStatus;


  RootModel(){
    authStatus = AuthStatus.notDetermined;
    initState();
  }

  void signedIn() {
    setState(ViewState.Busy);
    authStatus = AuthStatus.signedIn;
    setState(ViewState.Idle);
  }

  void signedOut() {
    setState(ViewState.Busy);
    authStatus = AuthStatus.notSignedIn;
    setState(ViewState.Idle);
  }

  AuthStatus getAuthStatus(){
    return authStatus;
  }

  void initState(){
    authService.currentUser().then((user){
      setState(ViewState.Busy);
      authStatus = user  == null? AuthStatus.notSignedIn : AuthStatus.signedIn;
      if(user != null){
        print("userid: ${user.uid} username: ${user.email}");
      }
      setState(ViewState.Idle);
    });
  }
}