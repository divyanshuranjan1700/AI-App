import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_own_ai/Login_Signup/Main_page.dart';
import 'package:your_own_ai/Login_Signup/registration.dart';
import 'package:your_own_ai/Login_Signup/reset.dart';
import 'package:your_own_ai/Login_Signup/services/firebase_auth_mathods.dart';
import 'package:your_own_ai/Screens/Home.dart';
import 'package:your_own_ai/utils/globals.dart' as globals;
// import 'package:voting_app/Screens/Main_page.dart';
// import 'package:voting_app/Screens/homeScreen.dart';
// import 'package:voting_app/Screens/registrationScreen.dart';
// import 'package:voting_app/Screens/resetPassScreen.dart';
// import 'package:voting_app/main.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:voting_app/utils/showSnakbar.dart';
// import '../firebase_options.dart';
// import 'package:voting_app/Services/Firebase_auth_methods.dart';
// import 'package:voting_app/utils/globals.dart' as globals;

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}
enum AuthStatus {
  notSignedIn,
  signedIn,
}
class _loginScreenState extends State<loginScreen> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  void initState() {
    super.initState();
    String? user = FirebaseAuth.instance.currentUser?.uid;
    setState(() {
      authStatus = user == globals.userdId
          ? AuthStatus.notSignedIn
          : AuthStatus.signedIn;
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }
  Screen() {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return loginScreen();
      case AuthStatus.signedIn:
        return Home();
    }
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passenable = true;
  void logInUser() async {
    // try {
    FirebaseAuthMethod(FirebaseAuth.instance, GoogleAuthProvider())
        .loginUsingEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context);
    globals.userdId = FirebaseAuth.instance.currentUser?.uid;
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Main_page()));
    setState(() {
      emailController.clear();
      passwordController.clear();
    });
    // } on FirebaseAuthException catch (e) {
    //   // if (e.code == "user-not-found") {
    //   //   showSnackbar(context, "Wrong Email entered");
    //   // }
    //   showSnackbar(context, e.message!);
    // }
    // setState(() {
    //   emailController.text = "";
    //   passwordController.text = "";
    // });
    // if(FirebaseAuth.instance.currentUser.)
    // globals.userId = FirebaseAuth.instance.currentUser.uid;
  }

  void loginGoogle() async {
    await FirebaseAuthMethod(FirebaseAuth.instance, GoogleAuthProvider())
        .signInWithGoogle(context);
    globals.userdId = FirebaseAuth.instance.currentUser?.uid;
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Main_page()));
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(4, 42, 126, 1),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 200),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[100]!))),
                              child: TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.mail),
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[100]!))),
                              child: TextField(
                                controller: passwordController,
                                obscureText: passenable,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                    suffix: IconButton(
                                        onPressed: () {
                                          //add Icon button at end of TextField
                                          setState(() {
                                            //refresh UI
                                            if (passenable) {
                                              //if passenable == true, make it false
                                              passenable = false;
                                            } else {
                                              passenable =
                                                  true; //if passenable == false, make it true
                                            }
                                          });
                                        },
                                        icon: Icon(passenable == true
                                            ? Icons.remove_red_eye
                                            : Icons.panorama_fish_eye)),
                                    prefixIcon: Icon(Icons.lock),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(4, 42, 126, 1),
                                Color.fromRGBO(4, 42, 126, .6),
                              ])),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () {
                          logInUser();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => reset())),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color.fromRGBO(4, 42, 126, 1),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, "/Signscreen");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          registrationScreen()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color.fromRGBO(4, 42, 126, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "or you can sign in with",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 8.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Image.asset(
                                  "assets/images/google_logo.png",
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              Text(
                                "Google",
                                style: TextStyle(
                                    color: Color.fromRGBO(4, 42, 126, 1),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          loginGoogle();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
