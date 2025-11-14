import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/data/repositories/auth_repository.dart';
import 'package:tom_travel_app/logic/states/auth_states.dart';

// أدارة الحالات لتسجيل الدخول
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;

  AuthCubit(this._repo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _repo.login(email: email, password: password);
      emit(AuthSuccess(result.user, result.token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

   Future<void> register(String name, String email, String password , String phone) async {
    emit(AuthLoading());
    try {
      final result = await _repo.register(
        name: name,
        email: email,
        password: password,
        phone: phone.toString(),
      );
      emit(AuthSuccess(result.user, result.token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}