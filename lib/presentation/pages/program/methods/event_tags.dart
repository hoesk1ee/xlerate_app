import 'package:flutter/material.dart';

Container eventTags(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Text(label),
  );
}
