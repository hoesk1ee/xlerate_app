// file: presentation/pages/main/main_page.dart
import 'package:flutter/material.dart';
import 'package:xlerate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:xlerate/presentation/pages/productivity_page.dart';
import 'package:xlerate/presentation/pages/program_list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _screenIndex = 0;

  final List<Widget> _screens = [
    const DashboardPage(),
    const ProgramListPage(),
    const ProductivityPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: IndexedStack(
        index: _screenIndex,
        children: _screens,
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.08,
                ),
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 0),
              _buildNavItem(Icons.list_alt_rounded, 1),
              _buildNavItem(Icons.calendar_month_rounded, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _screenIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _screenIndex = index;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? Colors.blueAccent : Colors.grey.shade400,
        ),
      ),
    );
  }
}
