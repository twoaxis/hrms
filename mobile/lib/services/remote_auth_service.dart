import 'package:hrms/abstract/auth_service.dart';
import 'package:hrms/models/auth_response.dart';

class RemoteAuthService extends AuthService{
  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      return AuthResponse(
        accessToken: "fake_access_token_123",
        refreshToken: "fake_refresh_token_456",
      );
    } catch (_) {
      throw Exception("Invalid email or password");
    }
  }
}
