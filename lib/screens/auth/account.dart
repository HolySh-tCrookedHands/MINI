import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage('https://cs12.pikabu.ru/post_img/big/2022/12/23/9/1671809947123212289.jpg'),
            ),
            const SizedBox(height: 30),
            
            const Text(
              "Артём",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            
            
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "о себе", 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Divider(),
                    SizedBox(height: 5),
                    Text(
                      "«Судьба ведет того, кто хочет, и тащит того, кто не хочет.» — Клеанф",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            SizedBox(
              width: 200, 
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey),
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Изменить"),
                    SizedBox(width: 10),
                    Icon(Icons.edit, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            SizedBox(
              width: 200,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Удалить"),
                    SizedBox(width: 10),
                    Icon(Icons.delete, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
