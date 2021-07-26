import 'package:dio/dio.dart';

import 'AllUrl.dart';

class User {
  final int index;
  final int userid;
  final String username;
  final int usertype;
  final String useremail;
  final String userfirmname;
  final String usermobile;
  final String useroffice;
  final String usergodown;
  final String usergst;
  final String userdescription;
  User({
    this.index,
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
    int count = 1;
    dynamic data = response.data;
    for (dynamic res in data) {
      User u = User(
        index: count++,
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
