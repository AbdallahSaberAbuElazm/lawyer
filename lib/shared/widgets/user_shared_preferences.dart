import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static Future init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  static Future setUserInfo(
      {required String userId,
      required String email,
      required String username,
      required bool isLawyer,
      required String avatarUrl,
      required String avatarName,
      required String category,
      required String dates,
      required String info,
      required String yearsExp,
      required bool isAdmin
      // required double rates,
      }) async {
    await _sharedPreferences.setString('userId', userId);
    await _sharedPreferences.setString('email', email);
    await _sharedPreferences.setString('username', username);
    await _sharedPreferences.setBool('isLawyer', isLawyer);
    await _sharedPreferences.setString('avatarUrl', avatarUrl);
    await _sharedPreferences.setString('photoName', avatarName);
    await _sharedPreferences.setString('category', category);
    await _sharedPreferences.setString('dates', dates);
    await _sharedPreferences.setString('info', info);
    await _sharedPreferences.setString('yearsExp', yearsExp);
    await _sharedPreferences.setBool('isAdmin', isAdmin);
    // await _sharedPreferences.setDouble('rates', rates);
  }

  static Future setUserAvatar(
      {required String url, required String photoName}) async {
    await _sharedPreferences.setString('avatarUrl', url);
    await _sharedPreferences.setString('photoName', photoName);
  }

  static String? getUserId() => _sharedPreferences.getString('userId');
  static String? getUserCategory() => _sharedPreferences.getString('category');
  static String? getUserDates() => _sharedPreferences.getString('dates');
  static String? getUserInfo() => _sharedPreferences.getString('info');
  static String? getUserYearsExp() => _sharedPreferences.getString('yearsExp');
  static bool? getIsAdmin() => _sharedPreferences.getBool('isAdmin');
  // static double? getUserRates() => _sharedPreferences.getDouble('rates');
  static String? getUserAvatarUrl() =>
      _sharedPreferences.getString('avatarUrl');

  static String? getUserAvatarName() =>
      _sharedPreferences.getString('photoName');

  static String? getUserName() => _sharedPreferences.getString('username');

  static String? getUseremail() => _sharedPreferences.getString('email');
  static String? getUsermobile() => _sharedPreferences.getString('phone');
  static bool? getLawyer() => _sharedPreferences.getBool('isLawyer');

  static Future removeDataForLogout() async {
    await _sharedPreferences.remove('userId');
    await _sharedPreferences.remove('email');
    await _sharedPreferences.remove('username');
    await _sharedPreferences.remove('phone');
    await _sharedPreferences.remove('isLawyer');
    await _sharedPreferences.remove('photoName');
    await _sharedPreferences.remove('avatarUrl');
    await _sharedPreferences.remove('category');
    await _sharedPreferences.remove('yearsExp');
    await _sharedPreferences.remove('dates');
    // await _sharedPreferences.remove('rates');
    await _sharedPreferences.remove('info');
  }
}
