import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/background.jpg',
              fit: BoxFit.cover
            )
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width - 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadiusGeometry.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "MINI",
                            style: TextStyle(
                              fontSize: 30
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Divider(color: Colors.black,),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hint: Text("Логин", textAlign: TextAlign.center,),
                                prefixIcon: Icon(Icons.person)
                              ),
                            ),
                            const SizedBox(height: 50,),
                            TextField(
                              obscureText:true,
                              obscuringCharacter: "*",
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hint: Text("Пароль", textAlign: TextAlign.center,),
                                prefixIcon: Icon(Icons.lock)
                              ),
                            ),
                            const SizedBox(height: 50,),
                            TextField(
                              obscureText:true,
                              obscuringCharacter: "*",
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hint: Text("Подтвердите пароль", textAlign: TextAlign.center,),
                                prefixIcon: Icon(Icons.repeat)
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: Text('Зарегистрироваться')
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}