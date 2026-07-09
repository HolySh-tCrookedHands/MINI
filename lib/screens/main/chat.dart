import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChatScreenState();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://onestopsolution.org/assets/sub-cat-imgs/no-icon.jpeg"),
            ),
            SizedBox(width: 10),
            Text("Еблан какой-то", 
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),)
            
          ],
       ),
    ),
  );
 }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          buildChatBar(),
        ],
      )
      ),
    );
    
  }
}