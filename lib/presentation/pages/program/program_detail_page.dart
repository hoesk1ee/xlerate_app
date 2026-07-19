import 'package:flutter/material.dart';
import 'package:xlerate/presentation/pages/program/methods/event_header.dart';
import 'package:xlerate/presentation/pages/program/methods/event_title.dart';

class ProgramDetailPage extends StatelessWidget {
  const ProgramDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // * Event Header
          eventHeader(context),

          // * Event Title
          eventTitle(),

          // * Attendies
          // attendies(),

          // * Description Selector
          // descriptionSelector(),

          // * Description Content
          // descriptionContent(),

          // * Feedback Button
          // feedbackButton(),

          // * Apply Button
          // applyButton(),
        ],
      ),
    );
  }
}
