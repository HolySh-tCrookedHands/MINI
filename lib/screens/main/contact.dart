import 'package:flutter/material.dart';



class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<StatefulWidget> createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  
  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Поиск", // Используй hintText вместо hint: Text()
        ),
      ),
    );
  }

  Widget buildContent() {
    return Container();
  }


  @override
  Widget build(BuildContext context) {
    // Внимание: НИКАКИХ Scaffold, SafeArea и Navbar тут больше нет!
    return Column(
      children: [
        buildSearchBar(), // Строка поиска
        Expanded(
          child: buildContent(), // Сам список контактов
        ),
      ],
    );
  }
}