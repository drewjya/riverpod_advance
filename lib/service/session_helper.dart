import 'package:hive/hive.dart';
import 'package:riverpod_advance/model/users_model.dart';

class SessionHelper {
  static Future<UserModel?> read() async {
    var box = await Hive.openBox('riverpod_advance');
    var result = box.get('session');
    if (result != null) {
      return UserModel(
          username: result["username"],
          password: result["password"],
          id: result["id"]);
    }
    return null;
  }

  static write(UserModel userModel) async {
    var box = await Hive.openBox('riverpod_advance');
    box.put('session', {
      "username": userModel.username,
      "password": userModel.password,
      "id": userModel.id
    });
  }

  static logout() async {
    var box = await Hive.openBox('riverpod_advance');
    box.delete('session');
  }
}
