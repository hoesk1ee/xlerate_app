import 'package:flutter/material.dart';
import '../../../models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: const Color(0xFFE8F0FE),
          backgroundImage: user.imageUrl != null && user.imageUrl!.isNotEmpty
              ? NetworkImage(user.imageUrl!)
              : null,
          child: user.imageUrl == null || user.imageUrl!.isEmpty
              ? const Icon(
            Icons.person,
            size: 50,
            color: Colors.blue,
          )
              : null,
        ),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            user.role,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 15),

        Text(
          user.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          user.email,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 20),

        Divider(
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}