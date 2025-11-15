import 'package:get_it/get_it.dart';
import 'package:hrms/abstract/auth_service.dart';
import 'package:hrms/services/remote_auth_service.dart';
import 'package:hrms/view_model/login_view_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(RemoteAuthService());
  locator.registerFactory<LoginViewModel>(
    () => LoginViewModel(),
  );
}
