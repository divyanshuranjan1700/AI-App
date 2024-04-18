import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:your_own_ai/Login_Signup/login.dart';
import 'package:your_own_ai/Screens/Home.dart';
import 'package:your_own_ai/Screens/chat_home.dart';
import 'package:your_own_ai/Screens/img_home.dart';
import 'package:your_own_ai/openAi/ImageGeneration/image_apicall.dart';

// import 'Screens/img_home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String image = '';
    var isloaded = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: loginScreen(),
      home: Home(),
      // home:img_home(),
      // home: chat_home(),
    );
  }
}
