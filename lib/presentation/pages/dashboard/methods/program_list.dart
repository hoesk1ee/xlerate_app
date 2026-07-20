import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/program/program_detail_page.dart';

Widget programList(BuildContext context) => Padding(
  padding: const EdgeInsets.only(left: 16, right: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Best Program for You",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      verticalSpaces(8),

      // * List of Programs
      ListView.separated(
        itemCount: 6,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => programCard(context),

        separatorBuilder: (context, index) => verticalSpaces(12),
      ),
    ],
  ),
);

Widget programCard(BuildContext context) => GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProgramDetailPage()),
    );
  },
  child: Container(
    padding: const EdgeInsets.all(12),
    height: 125,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5,

          offset: Offset(4, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // * Program Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://media.istockphoto.com/id/2198836359/photo/i-want-to-ask-a-question.jpg?s=612x612&w=0&k=20&c=pJdlDj-mRkZlDWJwf6jHd2f37EeGnzjEr1yeYPpeyhE=',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),

        horizontalSpaces(12),

        // * Program Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Introduction to UI/UX Design",
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                "Alex Uzbek, B.Cs.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "Monday, 13 July 2026",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Text("Excelerate"),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
