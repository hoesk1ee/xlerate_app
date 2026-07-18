import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';

final List<Map<String, String>> announcements = [
  {
    'title': 'Survey reminder',
    'desc': 'Submit your feedback for us before 13 July 2026!',
    'photoUrl':
        'https://contentsnare.com/wp-content/uploads/2023/02/survey-reminder-email-1-1024x693.jpg',
    'priority': "Urgent",
  },
  {
    'title': 'Program has been moved!',
    'desc': 'Submit your feedback for us before 13 July 2026!',
    'photoUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKpVI5SW1Yx7Tb2jUGusMaEkYs7WyeZ3kQxSmZrxhbtg&s=10',
    'priority': "Urgent",
  },
  {
    'title': 'New program added!',
    'desc': 'Submit your feedback for us before 13 July 2026!',
    'photoUrl':
        'https://media.istockphoto.com/id/2198836359/photo/i-want-to-ask-a-question.jpg?s=612x612&w=0&k=20&c=pJdlDj-mRkZlDWJwf6jHd2f37EeGnzjEr1yeYPpeyhE=',
    'priority': "Urgent",
  },
];

Widget announcementBanner(
  BuildContext context, {
  required int currentIndex,
  required Function(int) onPageChanged,
}) => Padding(
  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Stack(
        children: [
          CarouselSlider(
            items: announcements.map((item) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(item["photoUrl"]!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        item['desc']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 175,
              autoPlay: true,
              viewportFraction: 0.9,
              disableCenter: true,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                onPageChanged(index);
              },
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: announcements.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(
                      currentIndex == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),

      verticalSpaces(8),

      GestureDetector(
        onTap: () {
          // ! TODO : Navigate to Announcement List Screen
        },
        child: Text(
          "See Announcement ->",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    ],
  ),
);
