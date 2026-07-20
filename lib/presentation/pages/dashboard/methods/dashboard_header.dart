import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/profile/profile_screen.dart';

Widget dashboardHeader(BuildContext context) => Padding(
  padding: const EdgeInsets.all(16),
  child: Row(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ),
          );
        },
        child: CircleAvatar(
          radius: 36,
        ),
      ),

      horizontalSpaces(16),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Good Evening!"),
          Text(
            "Team 10",
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
