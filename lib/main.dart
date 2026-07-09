import 'package:flutter/material.dart';
import 'package:mini/screens/auth/controlSing.dart';
import 'package:mini/screens/main/index.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final bool isSingIn = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isSingIn == false ? SingUpInScreen() : IndexScreen(),
    );
  }
}
