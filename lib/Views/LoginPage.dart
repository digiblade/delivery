import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/CustomDropdown.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:delivery/Models/Authmodel.dart';
import 'package:delivery/Views/SalesManager/SalesHome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'Company/HomePage.dart';
import 'Destributor/DHome.dart';
import 'Register.dart';
import 'SuperStokies/SSHome.dart';
// import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  // final auth = FirebaseAuth.instance;

  bool obscure = true;
  int type = 1;
  @override
  void initState() {
    super.initState();
    checkLoginData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.srcOver),
              fit: BoxFit.cover,
              image: Image.asset("assets/background.jpg").image),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 32,
            ),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login ",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InputField(
                        hint: "Useremail",
                        borderColor: Colors.white.withOpacity(0.5),
                        controller: userCtrl,
                        fillColor: Colors.white.withOpacity(0.5),
                        hintColor: Colors.white,
                        isFilled: true,
                        isPassword: false,
                        textColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomDropdown(
                        items: {
                          'Company': 1,
                          'Super Stokist': 2,
                          'Distributor': 3,
                          'Area Sales Manager': 4,
                        },
                        onChange: changeVal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InputField(
                        hint: "Password",
                        borderColor: Colors.white.withOpacity(0.5),
                        controller: passCtrl,
                        fillColor: Colors.white.withOpacity(0.5),
                        hintColor: Colors.white,
                        isFilled: true,
                        isPassword: obscure,
                        textColor: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      child: (obscure)
                          ? Text(
                              "Show Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              "Hide Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    Button(
                      text: "Login",
                      textColor: Colors.black,
                      color: Colors.white,
                      height: 60,
                      onPressed: () async {
                        bool res = await checkLogin(
                          email: userCtrl.text,
                          password: passCtrl.text,
                          type: type,
                        );
                        if (res) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                switch (type) {
                                  case 1:
                                    return HomePage();
                                  case 2:
                                    return SSHome();
                                  case 3:
                                    return DHome();
                                  case 4:
                                    return SMHome();
                                  default:
                                    return SSHome();
                                }
                              },
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(msg: "invalid credentials");
                        }
                      },
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't Have Account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  checkLoginData(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool check = pref.getBool('islogin') ?? false;

    if (check) {
      String userid = pref.getString("userid");
      print(userid);
      int type = pref.getInt('type');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            switch (type) {
              case 1:
                return HomePage();
              case 2:
                return SSHome();
              case 3:
                return DHome();
              case 4:
                return SMHome();
              default:
                return LoginPage();
            }
          },
        ),
      );
    }
  }

  void changeVal(val) {
    setState(() {
      type = val;
    });
    print(type);
  }
}
