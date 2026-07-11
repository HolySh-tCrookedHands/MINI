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

  late final TextEditingController textController = TextEditingController(); 

  final List<ChatMessage> _messages = [
    ChatMessage(text: "Дарова гандон", isMe: true),
    ChatMessage(text: "Пашол нахуй", isMe: false)
  ];

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
              const Text("Пользователь", 
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
 
  Widget buildMessageBubble(ChatMessage message) {
    final isMe = message.isMe;

    final align = isMe
      ? Alignment.bottomRight
      : Alignment.bottomLeft;

    final color = isMe
      ? const Color.fromARGB(255, 67, 98, 43)
      : const Color.fromARGB(255, 108, 111, 107);

    return Align(
      alignment: align,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Text(
            message.text,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }


  Widget buildChatArea() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return buildMessageBubble(_messages[index]);
        },
      ),
    );
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true));
    });

    textController.clear();
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
                controller: textController,
                decoration: InputDecoration(
                hintText: "Введите сообщение...",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                onSubmitted: (_) => sendMessage(),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: IconButton( onPressed: sendMessage, icon: Icon(Icons.send, size: 30,),),)
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
            buildChatArea()
          ),
          buildMessageSender(),  
        ],
      )
      ),
    ); 
  }
}



