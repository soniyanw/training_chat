import 'package:chat_firebase/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String msg = '';
  var controll = TextEditingController();
  void sendmsg() async {
    FocusScope.of(context).unfocus();
    final uidd = await FirebaseAuth.instance.currentUser!.uid;
    final data =
        await FirebaseFirestore.instance.collection('users').doc(uidd).get();
    await FirebaseFirestore.instance.collection('chats').doc().set({
      "msg": msg,
      "userid": data['id'],
      'name': data['name'],
      'time': Timestamp.now()
    });
    controll.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Messages()),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controll,
                  onChanged: (val) {
                    setState(() {
                      msg = val;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              IconButton(
                  onPressed: controll.text.isEmpty
                      ? null
                      : () {
                          sendmsg();
                        },
                  icon: Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
