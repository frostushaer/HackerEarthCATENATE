import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userLanguageKey = "USERLANGUAGEKEY";
  static String userTypeKey = "USERTYPEKEY";
  static String userPushKey = "USERPUSHKEY";

  // saving the data to SF

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveUserType(bool isUserOrg) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userTypeKey, isUserOrg);
  }

  static Future<bool> saveUserPushKey(String userPush) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userPushKey, userPush);
  }

  // getting the data from SF

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<bool?> getUserTypeStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userTypeKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserPushKey() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userPushKey);
  }
}
