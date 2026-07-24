import 'package:flutter/material.dart';
import 'package:mini/models/contactItem.dart';
import 'package:mini/widgets/contactItems.dart';



class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<StatefulWidget> createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  
  late List<ContactItemModel> data;

  @override
  void initState() {
    super.initState();
    data = GetContactList();
  }


  List<ContactItemModel> GetContactList() {
    return [
      ContactItemModel(
        id: 1, 
        name: "Димон", 
        isOnline: true
      ),
      ContactItemModel(
        id: 2,
        name: "Максон", 
        isOnline: false
      ),
      ContactItemModel(
        id: 3, 
        name: "Женя", 
        isOnline: true
      )
    ];
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Поиск",
        ),
      ),
    );
  }

  Widget buildContent() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ContactItems(data: data[index]);
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearchBar(),
        Expanded(
          child: buildContent(),
        ),
      ],
    );
  }
}