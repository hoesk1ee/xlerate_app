import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';

Widget detailsContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Program Details",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      verticalSpaces(8),

      Row(
        children: [
          Row(
            children: [
              Icon(
                Icons.date_range,
              ),
              horizontalSpaces(8),
              Text("Monday, 11 July 2026"),
            ],
          ),

          horizontalSpaces(24),
          Row(
            children: [
              Icon(
                Icons.watch_later,
              ),
              horizontalSpaces(8),
              Text("19:00 PM"),
            ],
          ),
        ],
      ),

      verticalSpaces(8),

      Row(
        children: [
          Icon(
            Icons.location_on,
          ),
          horizontalSpaces(8),
          Text("Virtual"),
        ],
      ),

      verticalSpaces(8),

      Row(
        children: [
          Icon(
            Icons.attach_money,
          ),
          horizontalSpaces(8),
          Text("Free"),
        ],
      ),

      verticalSpaces(16),

      Text(
        "Program Descriptions",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      verticalSpaces(8),
      Text(
        """
This workshop encourages creativity and patience while helping you understand how visual storytelling works through motion.

During the workshop, you will:

• Plan a simple animation idea or short story
• Capture frames step-by-step using objects or drawings
• Combine frames into a smooth animation sequence
• Review and refine your animation output

By the end of the workshop, you will have created your own animation and gained a practical understanding of how motion, timing, and visual storytelling come together to bring ideas to life.
        """,
        style: TextStyle(color: Colors.black87, height: 1.5),
      ),
    ],
  );
}
