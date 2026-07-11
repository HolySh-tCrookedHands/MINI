import 'package:flutter/material.dart';
import 'package:mini/screens/auth/controlSing.dart';
import 'package:mini/screens/main/index.dart';
import 'package:mini/utils/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final bool isSingIn = false;

  @override
  Widget build(BuildContext context) {
    DynamicTheme data = DynamicTheme();
    data.mainColor = Colors.indigo;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini',
      theme:data.appTheme,
      home: isSingIn == false ? SingUpInScreen() : IndexScreen(),
    );
  }
}
