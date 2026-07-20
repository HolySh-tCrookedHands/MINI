import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mini/models/chatItemModel.dart';
import 'package:mini/models/msgModel.dart';
import 'package:mini/utils/provider/settings.dart';
import 'package:mini/widgets/messageBubble.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ChatItemModel data;
  const ChatScreen({
    super.key,
    required this.data
  });

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  late final TextEditingController msgTextController = TextEditingController(); 
  final FocusNode _focusNode = FocusNode();
  
  bool _isTextFieldEmpty = true;
  bool _showEmoji = false;

  final List<ChatMessage> _messages = [
    ChatMessage(text: "Чат создан", isMe: false, time: "...", typeMsg: "system"),
    ChatMessage(text: "Дарова гандон", isMe: true, time: "12:00", isRead: true),
    ChatMessage(text: "Пашол нахуй", isMe: false, time: "12:10")
  ];

  @override
  void initState() {
    super.initState();
    msgTextController.addListener(_handleTextChanged);
    
    // Если пользователь кликает на поле ввода, закрываем панель эмодзи
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showEmoji = false;
        });
      }
    });
  }

  @override
  void dispose() {
    msgTextController.removeListener(_handleTextChanged);
    msgTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onEmojiSelected(Emoji emoji) {
    final text = msgTextController.text;
    final selection = msgTextController.selection;

    // Находим позицию курсора
    final int start = selection.start;
    final int end = selection.end;

    if (start >= 0) {
      final newText = text.replaceRange(start, end, emoji.emoji);
      msgTextController.text = newText;
      
      msgTextController.selection = TextSelection.collapsed(
        offset: start + emoji.emoji.length,
      );
    } else {
      msgTextController.text = text + emoji.emoji;
    }
  }

  void _handleTextChanged() {
    final isEmpty = msgTextController.text.trim().isEmpty;
    if (_isTextFieldEmpty != isEmpty) {
      setState(() {
        _isTextFieldEmpty = isEmpty;
      });
    }
  }

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
            backgroundImage: NetworkImage(widget.data.urlAvatar),
          ),
        ],
      ),
      title: Text(widget.data.title),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert)
        )
      ],
    );
  }
 

  Widget buildChatArea() {
    return ListView.separated(
      separatorBuilder:(context, index) {
        return const SizedBox(height: 10,);
      },
      padding: const EdgeInsets.all(8.0),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final data = _messages[index];
        if (data.typeMsg == "user") {
          return MsgBubble(data:data);
        } else if (data.typeMsg == "system") {
          return MsgBubbleSystem(content: data);
        }
          
      },
    );
  }

  void sendMessage() {
    final text = msgTextController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final String minutes = now.minute < 10 ? '0${now.minute}' : '${now.minute}';
    final String formattedTime = '${now.hour}:$minutes';

    setState(() {
      _messages.add(
        ChatMessage(
          text: text, 
          isMe: true,
          time: formattedTime,
          isRead: false
        )
      );
    });

    msgTextController.clear();
  }

  void addMedia() {
    print('Добавили медиа файл');
  }

  Widget buildMessageSender() {
    final double maxSenderHeight = MediaQuery.of(context).size.height * 0.7;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end, 
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: IconButton(
                icon: Icon(
                  _showEmoji ? Icons.keyboard : Icons.emoji_emotions,
                  size: 28,
                  color: Colors.grey[700],
                ),
                onPressed: () {
                  if (_showEmoji) {
                    // Переключаем на клавиатуру
                    _focusNode.requestFocus();
                  } else {
                    // Убираем клавиатуру и показываем эмодзи
                    _focusNode.unfocus();
                    setState(() {
                      _showEmoji = true;
                    });
                  }
                },
              ),
            ),
            
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: maxSenderHeight,
                ),
                child: TextField(
                  controller: msgTextController,
                  focusNode: _focusNode,
                  maxLines: null, 
                  keyboardType: TextInputType.multiline, 
                  decoration: const InputDecoration(
                    hintText: "Введите сообщение...",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
            ),
            
            // Кнопка Отправки / Медиа
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 5), 
              child: _isTextFieldEmpty 
                  ? IconButton(
                      onPressed: addMedia,
                      icon: const Icon(Icons.attach_file, size: 30),
                    )
                  : IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send, size: 30),
                    ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: buildChatBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: () {
                      final path = settings.wallpaperPath;
                      if (path == null || path.isEmpty) {
                        return Container(
                          color: Colors.grey[900],
                          child: const Center(child: Text('Обои не заданы')),
                        );
                      }
                      
                      return Image.file(
                        File(path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[900],
                            child: const Center(child: Text('Обои не найдены')),
                          );
                        },
                      );
                    }(),
                  ),
                  buildChatArea()
                ],
              )
            ),
            buildMessageSender(),  
            
            if (_showEmoji)
              Center(
                child: EmojiPicker(
                  onEmojiSelected: (categotriam, emoji) => _onEmojiSelected(emoji),
                )
              ),
          ],
        ),
      ),
    ); 
  }
}
