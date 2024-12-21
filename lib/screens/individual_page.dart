import 'package:chatapp/custom_ui/own_messgae_crad.dart';
import 'package:chatapp/custom_ui/reply_card.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/model/message_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../res/colors.dart';
import '../widgets/bottom_sheet.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({
    super.key,
    required this.chatModel,
    required this.sourchat,
  });
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    // connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    connect();
  }

  void connect() {

    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.191.19:5000", <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      },
    );

    socket.connect();

    socket.emit("signin", widget.sourchat.id);

    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print('msg: $msg');
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });

    print(socket.connected);
  }

  void sendMessage(
    String message,
    String senderName,
    String sentTo,
    int sourceId,
    int targetId,
  ) {
    setMessage("source", message);
    socket.emit("message", {
      "message": message,
      "sender": senderName,
      "sentTo": sentTo,
      "sourceId": sourceId,
      "targetId": targetId,
    });
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print('messages: $messages');

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5,),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                    ),
                  ],
                ),
              ),
              
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "last seen today at 12:05",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.videocam,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                PopupMenuButton<String>(
                  // padding: const EdgeInsets.all(0),
                  onSelected: (value) {
                    print('value: $value');
                  },
                  icon: const Icon(
                    Icons.more_vert, // Default icon for PopupMenuButton
                    color: Colors.white, // Set the icon color to red
                  ),
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      const PopupMenuItem(
                        value: "View Contact",
                        child: Text("View Contact"),
                      ),
                      const PopupMenuItem(
                        value: "Media, links, and docs",
                        child: Text("Media, links, and docs"),
                      ),
                      const PopupMenuItem(
                        value: "Whatsapp Web",
                        child: Text("Whatsapp Web"),
                      ),
                      const PopupMenuItem(
                        value: "Search",
                        child: Text("Search"),
                      ),
                      const PopupMenuItem(
                        value: "Mute Notification",
                        child: Text("Mute Notification"),
                      ),
                      const PopupMenuItem(
                        value: "Wallpaper",
                        child: Text("Wallpaper"),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  children: [
                    Expanded(
                      // height: MediaQuery.of(context).size.height - 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: messages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == messages.length) {
                            return Container(
                              height: 70,
                            );
                          }
                          if (messages[index].type == "source") {
                            return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return ReplyCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                      left: 2,
                                      right: 2,
                                      bottom: 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      controller: _controller,
                                      focusNode: focusNode,
                                      textAlignVertical: TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      onChanged: (value) {
                                        if (value.length > 0) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            show
                                                ? Icons.keyboard
                                                : Icons.emoji_emotions_outlined,
                                          ),
                                          onPressed: () {
                                            if (!show) {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                            }
                                            setState(() {
                                              show = !show;
                                            });
                                          },
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.attach_file),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet(context),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.camera_alt),
                                              onPressed: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (builder) =>
                                                //             CameraApp()));
                                              },
                                            ),
                                          ],
                                        ),
                                        contentPadding: const EdgeInsets.all(5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    right: 2,
                                    left: 2,
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: AppColors.primaryAppColor,
                                    child: IconButton(
                                      icon: Icon(
                                        sendButton ? Icons.send : Icons.mic,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (sendButton) {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.easeOut);
                                          sendMessage(
                                            _controller.text,
                                            widget.sourchat.name!,
                                            widget.chatModel.name!,
                                            widget.sourchat.id!,
                                            widget.chatModel.id!,
                                          );
                                          _controller.clear();
                                          setState(
                                            () {
                                              sendButton = false;
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            show ? emojiSelect() : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        // rows: 4,
        // columns: 7,
        onEmojiSelected: (emoji, category) {
      print(emoji);
      setState(() {
        // _controller.text = _controller.text + emoji?.emoji;
      });
    });
  }
}
