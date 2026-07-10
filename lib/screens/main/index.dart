import 'package:flutter/material.dart';
import 'package:mini/screens/auth/account.dart';
import 'package:mini/screens/main/contact.dart';
import 'package:mini/screens/main/home.dart';
import 'package:mini/screens/main/settings.dart';

class IndexScreen extends StatefulWidget  {
  const IndexScreen({super.key});

  @override
  State<StatefulWidget> createState() => IndexScreenState();
}

class IndexScreenState extends State<IndexScreen> {
  double sizeNavbarIcon = 30;
  int _currentIndex = 0;
  late final List<Widget> _screens;
  final List<String> _titles = [
    'Чаты',
    'Контакты',
    'Профиль',
  ];

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const ContactScreen(),
      const AccountScreen()
    ];
  }


  AppBar buildHeader() {
    return AppBar(
      title: Text(_titles[_currentIndex]),
      actions: [
        if (_currentIndex == 0)
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsScreen()
                )
              );
            },
            icon: Icon(Icons.settings)
          ),
        if (_currentIndex == 1)
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add)
          ),
      ],
      shape: Border(
        bottom: BorderSide(
          color: Colors.black
        )
      ),
    );
  }

  Widget buildNavbar() {
    return SizedBox(
      height: 100,
      child: Card(
        // Исправил BorderRadiusGeometry на BorderRadius
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10), 
        ),
        shadowColor: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Сделал первую иконку тоже кнопкой
            IconButton(
              onPressed: () {
                setState(() => _currentIndex = 0); // Переключаем на Главную
              },
              icon: Icon(
                Icons.home,
                size: sizeNavbarIcon,
                // Подсвечиваем активную иконку синим цветом
                color: _currentIndex == 0 ? Colors.blue : Colors.black, 
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() => _currentIndex = 1); // Переключаем на Контакты
              },
              icon: Icon(
                Icons.people,
                size: sizeNavbarIcon,
                color: _currentIndex == 1 ? Colors.blue : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() => _currentIndex = 2); // Переключаем на Профиль
              },
              icon: Icon(
                Icons.person,
                size: sizeNavbarIcon,
                color: _currentIndex == 2 ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 2 ? AppBar() : buildHeader(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _screens[_currentIndex],
              ), 
            ),
            buildNavbar(),
          ],
        ),
      ),
    );
  }
}