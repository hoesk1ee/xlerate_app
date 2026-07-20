import 'package:flutter/material.dart';
import 'package:xlerate/presentation/misc/methods.dart';
import 'package:xlerate/presentation/pages/program/methods/apply_button.dart';
import 'package:xlerate/presentation/pages/program/methods/attendies.dart';
import 'package:xlerate/presentation/pages/program/methods/event_header.dart';
import 'package:xlerate/presentation/pages/program/methods/event_title.dart';
import 'package:xlerate/presentation/pages/program/methods/feedback_button.dart';
import 'package:xlerate/presentation/pages/program/widgets/description_section.dart';

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
          attendies(),

          // * Description Section
          DescriptionSection(),

          verticalSpaces(16),

          // * Feedback Button
          feedbackButton(
            isEventEnded: false,
            onPressed: () {
              // ! TODO : Implement feedback page features
            },
          ),

          verticalSpaces(100),
        ],
      ),
      bottomNavigationBar: applyButton(),
    );
  }
}
