// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

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
          gradient: new LinearGradient(
            colors: [
              const Color(0xFFFC5C00),
              const Color(0xFF7E2E00),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
                    "Register",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: userCtrl,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Username",
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: passCtrl,
                      obscureText: obscure,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
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
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      // color: Color(0xff040707),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        Color(0xff040707),
                      )),
                      onPressed: () async {
                        // final newUser =
                        //     await auth.createUserWithEmailAndPassword(
                        //         email: userCtrl.text, password: passCtrl.text);
                        // print(newUser.additionalUserInfo!.profile);
                        // if (newUser.additionalUserInfo!.profile != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(),
                          ),
                        );
                        // }
                        // int data = await checkUser(userCtrl.text);
                        // if (data == 0) {
                        //   addUser(userCtrl.text, passCtrl.text);
                        // }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
