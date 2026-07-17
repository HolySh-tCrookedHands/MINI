import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mini/models/chatItemModel.dart';
import 'package:mini/models/msgModel.dart';

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
  final FocusNode _focusNode = FocusNode(); // Управляет фокусом клавиатуры
  
  bool _isTextFieldEmpty = true;
  bool _showEmoji = false; // Отвечает за показ панели эмодзи

  final List<ChatMessage> _messages = [
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
    _focusNode.dispose(); // Не забываем очистить фокус-ноду
    super.dispose();
  }

  void _onEmojiSelected(Emoji emoji) {
    final text = msgTextController.text;
    final selection = msgTextController.selection;

    // Находим позицию курсора
    final int start = selection.start;
    final int end = selection.end;

    if (start >= 0) {
      // Если курсор установлен, вставляем эмодзи прямо в эту позицию
      final newText = text.replaceRange(start, end, emoji.emoji);
      msgTextController.text = newText;
      
      // Сдвигаем курсор вперед сразу после вставленного эмодзи
      msgTextController.selection = TextSelection.collapsed(
        offset: start + emoji.emoji.length,
      );
    } else {
      // Если фокуса на поле нет и курсор не найден, просто добавляем в конец
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
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.end,
            spacing: 10,
            runSpacing: 4,
            children: [
              Text(
                message.text,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              isMe ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.time,
                    style: const TextStyle(fontSize: 12, color: Colors.white70)
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    size: 16,
                    color: Colors.white70,
                  )
                ]
              ) : Text(
                message.time,
                style: const TextStyle(fontSize: 12, color: Colors.white70)
              )
            ],
          ),
        ),
      ),
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
        return buildMessageBubble(_messages[index]);
      },
    );
  }

  void sendMessage() {
    final text = msgTextController.text.trim();
    if (text.isEmpty) return;

    // Добавляем ведущий ноль для минут, если они меньше 10 (например, 12:05 вместо 12:5)
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
            // Кнопка Эмодзи перед полем ввода
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
            
            // Текстовое поле
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: maxSenderHeight,
                ),
                child: TextField(
                  controller: msgTextController,
                  focusNode: _focusNode, // Привязываем фокус
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
    return Scaffold(
      appBar: buildChatBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildChatArea()
            ),
            buildMessageSender(),  
            
            // Сама панель эмодзи под полем ввода
            if (_showEmoji)
              Container(
                height: 250, // Высота панели с эмодзи
                child: Center(
                  child: EmojiPicker(
                    onEmojiSelected: (categotriam, emoji) => _onEmojiSelected(emoji),
                  )
                ),
              ),
          ],
        ),
      ),
    ); 
  }
}
