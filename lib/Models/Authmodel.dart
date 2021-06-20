import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AllUrl.dart';

checkLogin({
  String email,
  String password,
  int type,
}) async {
  Dio dio = Dio();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool res = false;
  FormData form = FormData.fromMap({
    'email': email,
    'password': password,
    'type': type,
  });
  dynamic response = await dio.post(api + "user", data: form);
  if (response.statusCode == 200) {
    dynamic data = response.data;
    res = data['response'];
  }
  print(email);
  if (res) {
    pref.setBool("islogin", true);
    pref.setString("userid", email);
    pref.setInt("type", type);
  }
  return res;
}

logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove('islogin');
  pref.remove('userid');
  pref.remove('type');
}
