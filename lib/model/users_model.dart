
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String username;
  final String password;
  final int? id;
  const UserModel({
    this.id,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      id: map['id']?.toInt(),
    );
  }

  

  UserModel copyWith({
    String? username,
    String? password,
    int? id,
  }) {
    return UserModel(
      username: username ?? this.username,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }
}
