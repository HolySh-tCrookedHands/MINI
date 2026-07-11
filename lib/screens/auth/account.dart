import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            
            Text(
              "Артём",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // ДИНАМИЧЕСКИ: Основной цвет текста
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 30),
            
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "о себе", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 5),
                    Text(
                      "«Судьба ведет того, кто хочет, и тащит того, кто не хочет.» — Клеанф",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            SizedBox(
              width: 200, 
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  foregroundColor: theme.colorScheme.onSecondaryContainer,
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
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: theme.colorScheme.onError,
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
