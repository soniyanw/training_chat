import 'package:chat_firebase/messagebub.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance.currentUser!.uid;
    Stream<QuerySnapshot<Map<String, dynamic>>> hello = FirebaseFirestore
        .instance
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();
    if (hello != null) {
      return StreamBuilder(
          stream: hello,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
            if (snapShot.hasData) {
              List<QueryDocumentSnapshot<Object?>> chatdata =
                  snapShot.data!.docs;
              return ListView.builder(
                reverse: true,
                itemCount: chatdata.length,
                itemBuilder: (context, index) {
                  return MessageBub(
                      chatdata[index]['msg'],
                      chatdata[index]['name'],
                      chatdata[index]['userid'] == currentuser,
                      key: ValueKey(chatdata[index].id));
                },
              );
              //id: doc.data()['id'] ?? ''
            } else {
              return Container(
                color: Colors.pink,
              );
            }
          });
    } else {
      return Container();
    }
  }
}
