import 'package:dealdiscover/widgets/ResponseItem.dart';
import 'package:flutter/material.dart';

class QuestionItem extends StatelessWidget {
  final String question;
  final List<String> responses;
  final Function(String) onSelectResponse;

  const QuestionItem({
    Key? key,
    required this.question,
    required this.responses,
    required this.onSelectResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: responses.map((response) {
            return ResponseItem(
              text: response,
              isQuestion: true,
              selected: false, // Change this based on your logic
              onTap: () {
                onSelectResponse(response);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
