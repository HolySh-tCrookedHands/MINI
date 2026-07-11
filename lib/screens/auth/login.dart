import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onclickSwitch;

  const LoginScreen({
    super.key,
    required this.onclickSwitch,
  });

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text('Войти')
                ),
                TextButton(
                  onPressed: widget.onclickSwitch,
                  child: Text(
                    "Нет аккаунта? Не беда!\nЖми сюда чтобы зарегистрироваться!",
                    textAlign: TextAlign.center,
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}