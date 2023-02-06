import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearShatePref(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  // ignore: use_build_context_synchronously
  context.read<LoginProvider>().clearLogin();
}
