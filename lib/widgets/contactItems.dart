import "package:flutter/material.dart";
import "package:mini/models/contactItem.dart";

class ContactItems extends StatelessWidget {
  final ContactItemModel data;
  const ContactItems({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GestureDetector(
        onTap: () {print("click");},
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (data.urlAvatar == "none")
                  CircleAvatar(
                    radius: 30,
                    child: Text(data.name[0]),
                  )
                else
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(data.urlAvatar),
                  ),
                Text(data.name),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}