import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';

Widget eventHeader(BuildContext context) => Stack(
  children: [
    // * Event image
    Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTguSCP9bOkyKIXkeatwy8Unw3GTQPm3kagBT0Yzkh2vXyXpS75jSpj-Qkb&s=10",
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
    ),

    // * Navigation button
    Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400.withOpacity(0.75),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // ! TODO : Implement add to favorite feature
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400.withOpacity(0.75),
              child: Icon(
                Icons.star_border_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          horizontalSpaces(16),

          GestureDetector(
            onTap: () {
              // ! TODO : Implement share event feature
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400.withOpacity(0.75),
              child: Icon(
                Icons.share,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    ),

    // * Event tags
    Positioned(
      bottom: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          color: Colors.grey.shade600.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "Excelerate | Tech",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
);
