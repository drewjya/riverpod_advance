import 'package:equatable/equatable.dart';

import 'package:riverpod_advance/model/users_model.dart';

abstract class AuthState extends Equatable {
  final bool loggedIn;
  final UserModel? user;
  const AuthState({
    required this.loggedIn,
    this.user,
  });

  @override
  List<Object> get props => [loggedIn, user!];
}

class AuthSuccess extends AuthState {
  const AuthSuccess({required UserModel user})
      : super(loggedIn: true, user: user);
}

class AuthAuto extends AuthState {
  const AuthAuto({required UserModel user}) : super(loggedIn: true);
}

class AuthFailed extends AuthState {
  const AuthFailed() : super(loggedIn: false);
}

class AuthLoaded extends AuthState {
  const AuthLoaded() : super(loggedIn: false);
}

class AuthLogout extends AuthState {
  const AuthLogout({required UserModel user}) : super(loggedIn: false);
}
