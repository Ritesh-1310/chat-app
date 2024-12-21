import 'package:chatapp/custom_ui/button_card.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late ChatModel sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Ritesh Ranjan",
      isGroup: false,
      currentMessage: "Hi Ritesh",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Nitesh Ranjan",
      isGroup: false,
      currentMessage: "Hi Nitesh",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),

    ChatModel(
      name: "Priyranjan",
      isGroup: false,
      currentMessage: "Hi Priy",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),

    ChatModel(
      name: "Chitranjan",
      isGroup: false,
      currentMessage: "Hi Chitranjan",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Specific status bar color
        statusBarIconBrightness: Brightness.dark, // Specific icon brightness
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
          child: ListView.builder(
            itemCount: chatmodels.length,
            itemBuilder: (contex, index) => InkWell(
              onTap: () {
                sourceChat = chatmodels.removeAt(index);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => Homescreen(
                      chatmodels: chatmodels,
                      sourchat: sourceChat,
                    ),
                  ),
                );
              },
              child: ButtonCard(
                name: chatmodels[index].name!,
                icon: Icons.person,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
