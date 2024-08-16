import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget {
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
      // Adjust card properties as needed
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                Border.all(color: Colors.white, width: 2), // Add white border
          ),
          child: CircleAvatar(
            // Display user's image
            backgroundImage: AssetImage(
              'assets/images/user_pic.png',
            ),
          ),
        ),
        title: Text(
          // Display username
          'Oumaima Esghir',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          // Display comment text
          'Nice Hotel!!',
        ),
      ),
    );
  }
}
