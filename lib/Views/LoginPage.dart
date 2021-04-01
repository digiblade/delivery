import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'Register.dart';
// import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  // final auth = FirebaseAuth.instance;

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              const Color(0xFFFC5C00),
              const Color(0xFF7E2E00),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            // begin: const FractionalOffset(0.0, 0.0),
            // end: const FractionalOffset(1.0, 0.0),
            // stops: [0.0, 1.0],
            // tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login ",
                    style: TextStyle(
                      fontSize: 24,
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
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(),
                        ),
                      );
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
    );
  }
}