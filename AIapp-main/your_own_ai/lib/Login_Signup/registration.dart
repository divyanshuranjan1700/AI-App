import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_own_ai/Login_Signup/services/firebase_auth_mathods.dart';
import 'package:your_own_ai/Screens/Home.dart';

import '../utils/showSnackbar.dart';

class Field extends StatefulWidget {
  final String title;
  final Icon icon;
  final TextEditingController controller;
  final Object? id;
  const Field(
      {required this.title,
      required this.icon,
      required this.controller,
      this.id,
      super.key});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[100]!))),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              prefixIcon: widget.icon,
              border: InputBorder.none,
              hintText: widget.title,
              hintStyle: TextStyle(color: Colors.grey[400])),
        ),
      ),
    );
  }
}

class registrationScreen extends StatefulWidget {
  const registrationScreen({super.key});

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  void signUpUser() async {
    FirebaseAuthMethod(FirebaseAuth.instance, GoogleAuthProvider()).EmailSignup(
        email: emailController.text,
        password: passwordController.text,
        context: context);
    setState(() {
      emailController.text = "";
      passwordController.text = "";
    });
    showSnackbar(context, "Signup successfully");
  }

  void logInUser() async {
    FirebaseAuthMethod(FirebaseAuth.instance, GoogleAuthProvider())
        .loginUsingEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context);
    setState(() {
      emailController.text = "";
      passwordController.text = "";
    });
    showSnackbar(context, "Login successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SafeArea(
          child: Column(children: [
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
                                image:
                                    AssetImage('assets/images/light-1.png'))),
                      )),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'))),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'))),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 200),
                      child: Center(
                        child: Text(
                          "Sign Up",
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
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: [
                                    Field(
                                      title: " Enter your name ",
                                      icon: Icon(Icons.person),
                                      controller: nameController,
                                    ),
                                    Field(
                                      title: "Email",
                                      icon: Icon(Icons.email),
                                      controller: emailController,
                                      id: "emailid",
                                    ),
                                    Field(
                                      title: "Password",
                                      icon: Icon(Icons.password),
                                      controller: passwordController,
                                      id: "pass",
                                    ),
                                    Field(
                                      title: "Confirm Password",
                                      icon: Icon(Icons.password),
                                      controller: confPassController,
                                      id: "confPass",
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(4, 42, 126, 1),
                            Color.fromRGBO(4, 42, 126, .6),
                          ])),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (passwordController.text == confPassController.text) {
                        signUpUser();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        logInUser();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else {
                        showSnackbar(context, "Password dosen't match");
                      }
                    },
                  ),
                ],
              ),
            ),
          ]),
        )));
  }
}
