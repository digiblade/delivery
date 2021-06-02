import 'package:dio/dio.dart';

import 'AllUrl.dart';

class User {
  int userid;
  String username;
  int usertype;
  String useremail;
  String userfirmname;
  String usermobile;
  String useroffice;
  String usergodown;
  String usergst;
  String userdescription;
  User({
    this.userid,
    this.username,
    this.useremail,
    this.usertype,
    this.userfirmname,
    this.usermobile,
    this.useroffice,
    this.usergodown,
    this.usergst,
    this.userdescription,
  });
}

Future<List<User>> getUserData() async {
  List<User> user = [];
  Dio dio = Dio();
  dynamic response = await dio.get(api + "getalluser");
  if (response.statusCode == 200) {
    dynamic data = response.data;
    for (dynamic res in data) {
      User u = User(
        userid: int.parse(res['user_id']),
        username: res['user_name'],
        useremail: res['user_email'],
        usertype: int.parse(res['user_type']),
        userfirmname: res['user_firmname'],
        usermobile: res['user_mobile'],
        useroffice: res['user_officeaddress'],
        usergodown: res['user_godownaddress'],
        usergst: res['user_gstNo'],
        userdescription: res['user_description'],
      );
      user.add(u);
    }
  }
  return user;
}
