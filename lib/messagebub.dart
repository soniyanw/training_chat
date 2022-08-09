import 'package:flutter/material.dart';

class MessageBub extends StatelessWidget {
  final String msg;
  final String name;
  final bool isme;
  final Key key;
  MessageBub(this.msg, this.name, this.isme, {required this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isme ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          child: Text(isme ? name : ''),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            width: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.grey),
            child: Text(msg),
          ),
        ),
        Container(
          child: Text(!isme ? name : ''),
        )
      ],
    );
  }
}
