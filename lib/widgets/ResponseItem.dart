import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ResponseItem extends StatelessWidget {
  final String text;
  final bool isQuestion;
  final bool selected;
  final void Function() onTap;

  const ResponseItem({
    Key? key,
    required this.text,
    required this.isQuestion,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isQuestion
              ? Colors.white
              : selected
                  ? Colors.blue
                  : Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: isQuestion ? Colors.blue : Colors.transparent),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isQuestion
                ? Colors.blue
                : selected
                    ? Colors.white
                    : Colors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
