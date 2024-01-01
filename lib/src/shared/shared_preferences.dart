import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPreferences() async {
  return await SharedPreferences.getInstance();
}
