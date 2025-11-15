import 'package:hrms/abstract/auth_service.dart';
import 'package:hrms/core/locator.dart';
import 'package:hrms/models/auth_response.dart';

class LoginViewModel {
  bool isLoading = false;
  String? errorMessage;

  Future<AuthResponse?> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;

    try {
      final response = await locator<AuthService>().login(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
    }
  }
}
