import 'package:lawyer_bro/features/authentication/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalDB {
  static final LocalDB _LocalDB = LocalDB._internal();

  final box = GetStorage();

  LocalDB._internal();

  static LocalDB get instance => _LocalDB;

  void setUser(UserModel user) async => box.write("user", user.toJson());

  Future<bool> isUserLogin() async {
    final user = await box.read("user");
    return user != null && user['id'] != null;
  }

  UserModel? getUser() => box.read("user");

  void removeUser() => box.remove("user");
}
