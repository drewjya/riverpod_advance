import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/model/users_model.dart';
import 'package:riverpod_advance/provider/authentication/auth_state.dart';
import 'package:riverpod_advance/service/db_helper.dart';
import 'package:riverpod_advance/service/session_helper.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthLoaded()) {
    _onAuto();
  }
  _onAuto() async {
    final session = await SessionHelper.read();

    if (session != null) {
      final login = await DbHelper.login(session, true);

      if (login != null) {
        state = AuthAuto(user: login);
        state = AuthSuccess(user: login);
      } else {
        state = const AuthLoaded();
      }
    } else {
      state = const AuthLoaded();
    }
  }

  onLogin(UserModel userModel) async {
    if (state is AuthLoaded) {
      final login = await DbHelper.login(userModel, false);
      if (login != null) {
        state = AuthSuccess(user: login);
      } else {
        state = const AuthFailed();
        state = const AuthLoaded();
      }
    } else {
      state = const AuthLoaded();
    }
  }

  onSignup(UserModel userModel) async {
    if (state is AuthLoaded) {
      final result = await DbHelper.signUp(userModel);
      state = AuthSuccess(user: result);
    } else {
      state = const AuthLoaded();
    }
  }

  onLogout(UserModel user) async {
    SessionHelper.logout();
    state = AuthLogout(user: user);
    state = const AuthLoaded();
  }
}
