import 'package:flutter/material.dart';
import 'package:mini/models/chatItemModel.dart';

class ChatScreen extends StatefulWidget {
  final ChatItemModel data;
  const ChatScreen({
    super.key,
    required this.data
  });

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}

class ChatScreenState extends State<ChatScreen> {

  late final TextEditingController msgTextController = TextEditingController(); 

  final List<ChatMessage> _messages = [
    ChatMessage(text: "Дарова гандон", isMe: true),
    ChatMessage(text: "Пашол нахуй", isMe: false)
  ];

  AppBar buildChatBar() {
    final theme = Theme.of(context);
    return AppBar(
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      leadingWidth: 100,
      backgroundColor: theme.focusColor,
      leading:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.data.urlAvatar), // Или NetworkImage
          ),
        ],
      ),
      title: Text(widget.data.title),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert)
        )
      ],
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
    return ListView.separated(
      separatorBuilder:(context, index) {
        return SizedBox(height: 10,);
      },
      padding: const EdgeInsets.all(8.0),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return buildMessageBubble(_messages[index]);
      },
    );
  }

  void sendMessage() {
    final text = msgTextController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true));
    });

    msgTextController.clear();
  }

  void addMedia() {
    print('Добавили медиа файл');
  }

  Widget buildMessageSender() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: msgTextController,
                decoration: InputDecoration(
                hintText: "Введите сообщение...",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                onSubmitted: (_) => sendMessage(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10, 
                bottom: 10
              ), 
              child:IconButton(
                onPressed:sendMessage,
                icon: Icon(
                  Icons.send , 
                  size: 30,
                ),
              )
            )
          ],
        ),
      ),
    );
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatBar(),
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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



