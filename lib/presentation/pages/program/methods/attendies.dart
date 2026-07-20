import 'package:flutter/material.dart';

Widget attendies() => Padding(
  padding: const EdgeInsets.all(16),
  child: Row(
    children: [
      // * Participants
      SizedBox(
        width: 150,
        height: 44,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.amber,
              child: Text("S"),
            ),
            Positioned(
              left: 30,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.red,
                child: Text("F"),
              ),
            ),
            Positioned(
              left: 60,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.green,
                child: Text("G"),
              ),
            ),
            Positioned(
              left: 90,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey,
                child: Text("+"),
              ),
            ),
          ],
        ),
      ),

      Text(
        "67 joined",
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),

      const Spacer(),

      // * Seats number
      Column(
        children: [
          Text("No. of seats left"),
          Text(
            "33 Seat(s)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    ],
  ),
);
