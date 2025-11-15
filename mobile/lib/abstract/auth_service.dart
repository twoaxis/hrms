import 'package:hrms/models/auth_response.dart';

abstract class AuthService {
  Future<AuthResponse> login({
    required String email,
    required String password,
  });
}