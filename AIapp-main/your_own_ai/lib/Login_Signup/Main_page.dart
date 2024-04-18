import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_own_ai/Login_Signup/login.dart';
import 'package:your_own_ai/Screens/Home.dart';
// import 'package:voting_app/Screens/homeScreen.dart';
// import 'package:voting_app/Screens/loginScreen.dart';

class Main_page extends StatelessWidget {
  const Main_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            }
            else {
              // Navigator.pop(context);
              return loginScreen();
            }
          }),
    );
  }
}
