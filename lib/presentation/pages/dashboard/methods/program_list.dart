import 'package:flutter/material.dart';

Widget programList() => Padding(
  padding: const EdgeInsets.only(left: 16, right: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Best Program for You",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      // * List of Programs
    ],
  ),
);
