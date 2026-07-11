import 'package:flutter/material.dart';
import 'package:mini/screens/auth/login.dart';
import 'package:mini/screens/auth/registration.dart';

class SingUpInScreen extends StatefulWidget {
  const SingUpInScreen({super.key});

  @override
  State<StatefulWidget> createState() => SingUpInScreenState();
}

class SingUpInScreenState extends State<SingUpInScreen> {

  bool isSingUp = false;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      LoginScreen(
        onclickSwitch: () {
          setState(() {
            isSingUp = true;
          });
        },
      ),
      SignUpScreen(
        onclickSwitch: () {
          setState(() {
            isSingUp = false;
          });
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: theme.primaryColor
              ),
            )
          ),
          _screens[isSingUp == true ? 1 : 0]
        ],
      )
    );
  }
}