// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dealdiscover/model/comment.dart';
import 'package:dealdiscover/utils/colors.dart';

class CommentItem extends StatefulWidget {
  final Comment comments;

  const CommentItem({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: MyColors.backbtn1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                Border.all(color: Colors.white, width: 2), // Add white border
          ),
          child: CircleAvatar(
            backgroundImage: widget.comments.pic.isNotEmpty
                ? NetworkImage(
                    'http://10.0.2.2:3000/images/${widget.comments.pic}') // Use NetworkImage for URLs
                : AssetImage('assets/images/user_pic.png') as ImageProvider,
          ),
        ),
        title: Text(
          widget.comments.username,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.comments.text,
        ),
      ),
    );
  }
}
