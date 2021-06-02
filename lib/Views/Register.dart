// import 'package:firebase_auth/firebase_auth.dart';
import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:flutter/material.dart';
import 'Company/HomePage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  // final auth = FirebaseAuth.instance;
  // final firebase = FirebaseFirestore.instance;
  bool obscure = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.srcOver),
              fit: BoxFit.cover,
              image: Image.asset("assets/background.jpg").image),
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
                    "Register",
                    style: TextStyle(
                      fontSize: 32,
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
                      controller: userCtrl,
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
                    // color: Color(0xff040707),
                    color: Colors.white,
                    height: 60,
                    text: "Register",
                    textColor: Colors.black,
                    onPressed: () async {
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
                          "Already Have Account?",
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
                                builder: (BuildContext context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text("Sign In"),
                        )
                      ],
                    ),
                  ),
                  // if (auth.currentUser != null)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Continue preveious session",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // if (auth.currentUser != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext conetxt) => HomePage(),
                              ),
                            );
                            // }
                          },
                          child: Text("Click here"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // checkUser(String email) async {
  //   final data = await firebase
  //       .collection("user")
  //       .where("email", isEqualTo: email)
  //       .get();
  //   return data.size;
  // }

  // addUser(String email, String password) async {
  //   firebase.collection("user").doc("email").set({
  //     "email": email,
  //     "parentemail": "",
  //     "password": password,
  //   });
  // }
}
