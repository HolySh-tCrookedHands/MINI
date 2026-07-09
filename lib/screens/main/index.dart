import 'package:flutter/material.dart';
import 'package:mini/screens/auth/account.dart';
import 'package:mini/screens/main/contact.dart';
import 'package:mini/screens/main/home.dart';

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
    'Главная',
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


  Widget buildHeader() {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black)),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _titles[_currentIndex],
                style: const TextStyle(fontSize: 25),
              ),
              if (_currentIndex == 0)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                )
              else if (_currentIndex == 1)
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.add),
                )
              else
                const SizedBox(width: 48),
            ],
          ),
        ),
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
      body: SafeArea(
        child: Column(
          children: [
            if (_currentIndex != 2)
              buildHeader(),
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