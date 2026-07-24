import 'package:flutter/material.dart';
import 'package:mini/models/msgModel.dart';

class MsgBubble extends StatelessWidget {
  final ChatMessage data;

  const MsgBubble({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMe = data.isMe;

    final align = isMe
      ? Alignment.bottomRight
      : Alignment.bottomLeft;

    final backgroundBubble = isMe
      ? theme.colorScheme.primary
      : theme.colorScheme.secondary;

    return Align(
      alignment: align,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.scrim),
            color: backgroundBubble,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.end,
            spacing: 10,
            runSpacing: 4,
            children: [
              Text(
                data.text,
                style: TextStyle(fontSize: 16, color: theme.canvasColor),
              ),
              isMe ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.time,
                    style: TextStyle(fontSize: 12, color: theme.canvasColor)
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    data.isRead ? Icons.done_all : Icons.done,
                    size: 16,
                    color: theme.colorScheme.onTertiary,
                  )
                ]
              ) : Text(
                data.time,
                style: TextStyle(fontSize: 12, color: theme.canvasColor)
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MsgBubbleSystem extends StatelessWidget {
  final ChatMessage content; 
  const MsgBubbleSystem({
    super.key,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Card(
        color: theme.focusColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: theme.secondaryHeaderColor),
          borderRadius: BorderRadiusGeometry.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content.text),
        ),
      ),
    );
  }
}