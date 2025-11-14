import 'package:tom_travel_app/core/network/base_api.dart';
import 'package:tom_travel_app/data/models/user_model.dart';


class AuthResult {
  final UserModel user;
  final String token;

  AuthResult(this.user, this.token);
}
// يتصل ب base_api و يرسل الايميل و الباسورد
class AuthRepository {
  final BaseApi _api = BaseApi();

  Future<AuthResult> login({required String email, required String password}) async {
    final response = await _api.post('/login', {
      'email': email,
      'password': password,
    });

    final user = UserModel.fromJson(response.data['user']);
    final token = response.data['token'];

    return AuthResult(user, token);
  }

  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
  final response = await _api.post('/register', {
    'name': name,
    'email': email,
    'password': password,
    if (phone != null) 'phone': phone,
  });

  final user = UserModel.fromJson(response.data['user']);
  final token = response.data['token'];
  return AuthResult(user, token);
  }
}