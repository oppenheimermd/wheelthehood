
import 'package:get_it/get_it.dart';
import 'package:wheelthehood/core/services/api_users.dart';
import 'package:wheelthehood/core/services/auth.dart';
import 'package:wheelthehood/core/services/auth_service.dart';
import 'package:wheelthehood/core/view_models/CRUDModel.dart';
import 'package:wheelthehood/core/view_models/dashboard_model.dart';
import 'package:wheelthehood/core/view_models/home_model.dart';
import 'package:wheelthehood/core/view_models/login_model.dart';
import 'package:wheelthehood/core/view_models/root_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthService>( () => Auth());

  //  We'll use a {Factory] for home model.  This means that every time
  //  you request this type it creates a new one.
  locator.registerFactory(() =>RootModel());
  locator.registerFactory(() =>LoginModel());
  locator.registerFactory(() =>HomeModel());
  locator.registerLazySingleton(() => CRUDModel());
  locator.registerFactory(() =>DashboardModel());

  //  Going to have to refactor the below method to work
  //  with objects other that [User]
  //locator.registerLazySingleton<ApiService>( () => ApiUsers('users'));
  locator.registerLazySingleton(() => ApiUsers('users'));

}
