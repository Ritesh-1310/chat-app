import 'package:chatapp/custom_ui/avtar_card.dart';
import 'package:chatapp/custom_ui/contact_card.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Dev Stack", status: "A full stack developer"),
    ChatModel(name: "Balram", status: "Flutter Developer..........."),
    ChatModel(name: "Saket", status: "Web developer..."),
    ChatModel(name: "Bhanu Dev", status: "App developer...."),
    ChatModel(name: "Collins", status: "Raect developer.."),
    ChatModel(name: "Kishor", status: "Full Stack Web"),
    ChatModel(name: "Testing1", status: "Example work"),
    ChatModel(name: "Testing2", status: "Sharing is caring"),
    ChatModel(name: "Divyanshu", status: "....."),
    ChatModel(name: "Helper", status: "Love you Mom Dad"),
    ChatModel(name: "Tester", status: "I find the bugs"),
  ];
  List<ChatModel> groupmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Set the back icon color to red
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Add participants",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: const Color(0xFF128C7E),
        backgroundColor: AppColors.primaryAppColor,
        onPressed: () {},
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groupmember.length > 0 ? 90 : 10,
                  );
                }
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (contacts[index - 1].select == true) {
                        groupmember.remove(contacts[index - 1]);
                        contacts[index - 1].select = false;
                      } else {
                        groupmember.add(contacts[index - 1]);
                        contacts[index - 1].select = true;
                      }
                    });
                  },
                  child: ContactCard(
                    contact: contacts[index - 1],
                  ),
                );
              }),
          groupmember.length > 0
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].select == true) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    groupmember.remove(contacts[index]);
                                    contacts[index].select = false;
                                  });
                                },
                                child: AvatarCard(
                                  chatModel: contacts[index],
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
