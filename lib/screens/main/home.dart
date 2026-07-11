import 'package:flutter/material.dart';
import 'package:mini/models/chatItemModel.dart';
import 'package:mini/widgets/chatItems.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  late List<ChatItemModel> data;

  @override
  void initState() {
    super.initState();
    data = GetChatList();
  }

  List<ChatItemModel> GetChatList() {
    return [
      ChatItemModel(
        id:0,
        title: "Артём", 
        urlAvatar: "https://bipbap.ru/wp-content/uploads/2022/11/1652235714_41-kartinkin-net-p-prikolnie-kartinki-dlya-stima-44.jpg", 
        isOnline: false
      ),
      ChatItemModel(
        id:1,
        title: "Димон",
        urlAvatar: "https://img.magnific.com/free-vector/hacker-realistic-composition_98292-38.jpg?semt=ais_hybrid&w=740&q=80",
        isOnline: true
      ),
       ChatItemModel(
        id:2,
        title: "Студ Максимум",
        urlAvatar: "https://uprostim.com/wp-content/uploads/2021/02/discord-karen-dessire.jpg",
        isOnline: false
      ),
    ];
  }
  
  Widget buildListChat() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        ChatItemModel chat = data[index];
        return ChatItem(
          title: chat.title,
          urlAvatar: chat.urlAvatar,
          isOnline: chat.isOnline,
          callback: () {print(chat.id);}
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildListChat();
  }
}