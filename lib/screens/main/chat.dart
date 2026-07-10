import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}

class ChatScreenState extends State<ChatScreen> {
 
 Widget buildChatBar() {
  return SizedBox(
    height: 70,
    child: Container(
       decoration: BoxDecoration(
          color: const Color.fromARGB(255, 43, 42, 42),
          border: Border(bottom: BorderSide(color: Colors.black)),
       ),
       child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://onestopsolution.org/assets/sub-cat-imgs/no-icon.jpeg"),
            ),
            const Text("Еблан какой-то", 
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),),
            const Icon(
               Icons.more_horiz,
               size: 40,
              ),
          ],
       ),
    ),
  );
 }
 
 Widget buildChatArea() {
    return SizedBox(
      height: 100,
      child: Container(
      color: const Color.fromARGB(255, 45, 99, 226),
     ),
    );
  }

 Widget buildMessageSender() {
  return SizedBox(
    
    child: Container(
      color: Colors.blueGrey,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
              hintText: "Введите сообщение...",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Icon(Icons.send, size: 30,),),
        ],
      ),
    ),
  );
 }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildChatBar(),
          Expanded(child:
          buildChatArea(),
          ),
          buildMessageSender(),  
        ],
      )
      ),
    );
    
  }

}

