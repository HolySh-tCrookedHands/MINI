import 'package:flutter/material.dart';
import 'package:mini/widgets/chatItems.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  late List<List<dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = [
      [
        "Артём", 
        "https://bipbap.ru/wp-content/uploads/2022/11/1652235714_41-kartinkin-net-p-prikolnie-kartinki-dlya-stima-44.jpg",
        false
      ],
      [
        "Димон", 
        "https://img.magnific.com/free-vector/hacker-realistic-composition_98292-38.jpg?semt=ais_hybrid&w=740&q=80",
        true
      ],
      [
        "Студ Максимум", 
        "https://uprostim.com/wp-content/uploads/2021/02/discord-karen-dessire.jpg",
        false
      ],
    ];
  }
  
  Widget buildListChat() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ChatItem(
          title: data[index][0],
          urlAvatar: data[index][1],
          isOnline: data[index][2]
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildListChat();
  }
}