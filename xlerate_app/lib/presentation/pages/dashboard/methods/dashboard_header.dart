import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';

Widget dashboardHeader() => Padding(
  padding: const EdgeInsets.all(16),
  child: Row(
    children: [
      CircleAvatar(
        radius: 36,
      ),

      horizontalSpaces(16),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Good Evening!"),
          Text(
            "Ferry Gunawan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),

      Spacer(),

      IconButton(
        onPressed: () {
          // ! TODO : Navigate to Notification Page
        },
        icon: Icon(
          Icons.notifications,
          size: 36,
        ),
      ),
    ],
  ),
);
