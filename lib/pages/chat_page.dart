// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp/custom_ui/custom_card.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/screens/select_contact.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    Key? key,
    required this.chatmodels,
    required this.sourchat,
  }) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryAppColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => const SelectContact(),
            ),
          );
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (contex, index) => CustomCard(
          chatModel: widget.chatmodels[index],
          sourchat: widget.sourchat,
        ),
      ),
    );
  }
}
