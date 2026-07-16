import 'package:flutter/material.dart';
import 'package:xlerate/presentation/pages/dashboard/methods/announcement_banner.dart';
import 'package:xlerate/presentation/pages/dashboard/methods/dashboard_header.dart';
import 'package:xlerate/presentation/pages/dashboard/methods/program_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // * Header
            dashboardHeader(),

            // * Announcement Banner
            announcementBanner(
              context,
              currentIndex: _currentIndex,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),

            // * Programs List
            programList(),
          ],
        ),
      ),
    );
  }
}
