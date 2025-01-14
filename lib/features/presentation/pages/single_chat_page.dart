
import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:group_chat/features/domain/entities/group_entity.dart';
import 'package:group_chat/features/domain/entities/single_chat_entity.dart';
import 'package:group_chat/features/domain/entities/text_messsage_entity.dart';
import 'package:group_chat/features/presentation/cubit/chat/chat_cubit.dart';
import 'package:group_chat/features/presentation/cubit/group/group_cubit.dart';

class SingleChatPage extends StatefulWidget {
  final SingleChatEntity singleChatEntity;
  const SingleChatPage({super.key,required this.singleChatEntity});

  @override
  SingleChatPageState createState() => SingleChatPageState();
}

class SingleChatPageState extends State<SingleChatPage> {
  String messageContent = "";
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final bool _changeKeyboardType = false;
  int _menuIndex = 0;


  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
    BlocProvider.of<ChatCubit>(context).getMessages(channelId: widget.singleChatEntity.groupId);
    //FIXME: call get all messages
    super.initState();
  }
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  check(){

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: appBarMain(context),
      appBar: AppBar(
        title: Text(widget.singleChatEntity.groupName),
      ),
      body: BlocBuilder<ChatCubit,ChatState>(
        builder: (index,chatState){

          if (chatState is ChatLoaded){
            return Column(
              children: [
                _messagesListWidget(chatState),
                _sendMessageTextField(),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _sendMessageTextField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: const Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 60),
                      child: Scrollbar(
                        child: TextField(
                          style: const TextStyle(fontSize: 14),
                          controller: _messageController,
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message"),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _messageController.text.isEmpty
                          ? Icon(
                        Icons.camera_alt,
                        color: Colors.grey[500],
                      )
                          : const Text(""),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              if (_messageController.text.isEmpty) {
                //TODO:send voice message
              } else {
                print(_messageController.text);
                BlocProvider.of<ChatCubit>(context)
                .sendTextMessage(textMessageEntity: TextMessageEntity(
                  time: Timestamp.now(),
                  senderId: widget.singleChatEntity.uid,
                  content: _messageController.text,
                  senderName: widget.singleChatEntity.username,
                  type: "TEXT"
                ), channelId: widget.singleChatEntity.groupId);
                BlocProvider.of<GroupCubit>(context).updateGroup(groupEntity: GroupEntity(
                  groupId: widget.singleChatEntity.groupId,
                  lastMessage: _messageController.text,
                  creationTime: Timestamp.now(),
                ));
                setState(() {
                  _messageController.clear();
                });
              }
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Icon(
                _messageController.text.isEmpty ? Icons.mic : Icons
                    .send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _messagesListWidget(ChatLoaded messages) {
    Timer(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInQuad,
      );
    });
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messages.messages.length,
        itemBuilder: (_, index) {
          final message = messages.messages[index];

          if (message.senderId == widget.singleChatEntity.uid) {
            return _messageLayout(
              name: "Me",
              alignName: TextAlign.end,
              color: Colors.lightGreen[400],
              time: DateFormat('hh:mm a').format(message.time!.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.end,
              nip: BubbleNip.rightTop,
              text: message.content,
            );
          } else {
            return _messageLayout(
              color: Colors.white,
              name: "${message.senderName}",
              alignName: TextAlign.end,
              time: DateFormat('hh:mm a').format(message.time!.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.start,
              nip: BubbleNip.leftTop,
              text: message.content,
            );
          }
        },
      ),
    );
  }

  Widget _messageLayout({
    text,
    time,
    color,
    align,
    boxAlign,
    nip,
    crossAlign,
    String? name,
    alignName,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$name",
                    textAlign: alignName,
                    style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text,
                    textAlign: align,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(
                        .4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }


}