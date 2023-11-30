import 'package:hive/hive.dart';
import 'package:nanny_app/core/model/access_token.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  final String _boxName = "test";
  final String _user = "user";
  final String _appToken = "appToken";

  static Box? _box;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = dir.path;
  }

  static void dispose() async {
    _box?.close();
  }

  Future<Box> get getHiveBox async {
    if (_box?.isOpen != true) {
      _box = Hive.box(name: _boxName);
    }
    return _box!;
  }

  Future<void> saveUser(User user) async {
    final Box box = await getHiveBox;
    box.put(_user, user.toMap());
  }

  Future<User?> getUser() async {
    final Box box = await getHiveBox;
    final res = await box.get(_user);
    if (res != null) {
      return User.fromMap(Map<String, dynamic>.from(res));
    } else {
      return null;
    }
  }

  Future<void> removeUser() async {
    final Box box = await getHiveBox;
    box.delete(_user);
  }

  Future<AppToken?> getAppToken() async {
    final Box box = await getHiveBox;
    final res = await box.get(_appToken);
    if (res != null) {
      return AppToken.fromJson(Map<String, dynamic>.from(res));
    } else {
      return null;
    }
  }

  Future<void> removeAppToken() async {
    final Box box = await getHiveBox;
    box.delete(_appToken);
  }

  Future<void> saveAppToken(AppToken token) async {
    final Box box = await getHiveBox;
    box.put(_appToken, token.toMap());
  }
}
