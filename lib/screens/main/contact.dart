import 'package:flutter/material.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<StatefulWidget> createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  
  Widget buildHeader() {
    return SizedBox(
      height: 120,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black
            )
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2), // Цвет тени с прозрачностью (в старых версиях: withOpacity(0.2))
              spreadRadius: 1,    // Насколько сильно тень увеличивается в размерах
              blurRadius: 10,     // Степень размытия тени
              offset: const Offset(0, 10), // Смещение тени: (X - вправо, Y - вниз)
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Контакты'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add)
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hint: Text(
                    "Поиск",
                    textAlign: TextAlign.center,
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildContent() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            Expanded(child: buildContent())
          ],
        )
      ),
    );
  }
}