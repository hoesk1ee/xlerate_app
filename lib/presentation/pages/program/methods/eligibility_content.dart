import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';

Widget eligibilityContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Who can apply?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      verticalSpaces(8),
      Text("• Open for active university students"),
      Text("• Basic understanding of Flutter is a plus"),
      Text("• Passionate about software development"),
    ],
  );
}
