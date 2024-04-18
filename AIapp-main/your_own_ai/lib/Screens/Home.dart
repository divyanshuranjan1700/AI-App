import 'package:flutter/material.dart';
import 'package:your_own_ai/Screens/chat_home.dart';
import 'package:your_own_ai/Screens/img_home.dart';
import 'package:your_own_ai/Screens/img_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey,
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  ),
      home: Scaffold(
        body: SafeArea(
          child: Center(child: 
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>chat_home()));
            }, child: Text("Chat with Home")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>img_home()));
            }, child: Text("Image Generator")),
          ],
        )
      )),
      ),
    );
  }
}