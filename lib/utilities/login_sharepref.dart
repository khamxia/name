import 'package:shared_preferences/shared_preferences.dart';

class LoginSharePref {
  final String phonelogin = 'phone_login';
  final String passwordlogin = 'password_login';
  final String tokenresponse = 'token_response';

  Future<void> setPhoneLogin(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(phonelogin, phone);
  }

  Future<void> setPasswordLogin(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(passwordlogin, password);
  }

  Future<void> setTokenResponse(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenresponse, token);
  }

  Future<String> getPhoneLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(phonelogin) ?? '';
  }

  Future<String> getPasswordLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordlogin) ?? '';
  }

  Future<String> getTokenResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenresponse) ?? '';
  }
}
