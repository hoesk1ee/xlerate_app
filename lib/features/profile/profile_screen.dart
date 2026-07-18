import 'package:flutter/material.dart';
import 'package:learners_app/models/user_model.dart';
import 'package:learners_app/features/profile/widgets/activity.dart';
import 'package:learners_app/features/profile/widgets/badge_card.dart';
import 'package:learners_app/features/profile/widgets/logout_button.dart';
import 'package:learners_app/features/profile/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Declaring as const for better performance with mock data
    const user = UserModel(
      id: "1",
      name: "User Name",
      email: "user@example.com",
      role: "Learner",
      imageUrl: null,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigate to Edit Profile Screen
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(user: user),

            const SizedBox(height: 30),

            const Text(
              "Activity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ActivityCard(
                  number: "12",
                  title: "Events Attended",
                  icon: Icons.event,
                ),
                ActivityCard(
                  number: "9",
                  title: "Completed Courses",
                  icon: Icons.school,
                ),
                ActivityCard(
                  number: "27",
                  title: "Tasks Completed",
                  icon: Icons.task_alt,
                ),
                ActivityCard(
                  number: "4",
                  title: "Certificates",
                  icon: Icons.workspace_premium,
                ),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Badges & Certificates",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to badges screen
                  },
                  child: const Text("View All"),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Row(
              children: [
                Expanded(
                  child: BadgeCard(
                    title: "UI/UX Design",
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: BadgeCard(
                    title: "Mastering Database",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
