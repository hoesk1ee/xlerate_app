import 'package:flutter/material.dart';

class CreateFeedbackFormScreen extends StatefulWidget {
  const CreateFeedbackFormScreen({super.key});

  @override
  State<CreateFeedbackFormScreen> createState() =>
      _CreateFeedbackFormScreenState();
}

class _CreateFeedbackFormScreenState extends State<CreateFeedbackFormScreen> {
  //Dynamic text fields
  final List<TextEditingController> _linearControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> _openEndedControllers = [
    TextEditingController(),
  ];

  // Interactive checklist
  final List<Map<String, dynamic>> _checklistQuestions = [
    {'title': 'Is the interface easy to navigate?', 'isChecked': true},
    {'title': 'Is the design clean?', 'isChecked': false},
    {'title': 'Can users easily find courses?', 'isChecked': false},
    {'title': 'Is the platform mobile friendly?', 'isChecked': false},
    {
      'title': 'Is content engaging and easy to understand?',
      'isChecked': false,
    },
  ];

  @override
  void dispose() {
    for (var controller in _linearControllers) {
      controller.dispose();
    }
    for (var controller in _openEndedControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Auto generate "First", "Second", "Third" labels
  String _getOrdinal(int index) {
    const ordinals = [
      'First',
      'Second',
      'Third',
      'Fourth',
      'Fifth',
      'Sixth',
      'Seventh',
      'Eighth',
      'Ninth',
      'Tenth',
    ];
    if (index < ordinals.length) {
      return '${ordinals[index]} question';
    }
    return 'Question ${index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey.shade400,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        title: const Text(
          "New Feedback Form",
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        titleSpacing: 12,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Let's Create feedback questions\nfor [Program Name].",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2D3142),
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Linear Scale Questions
            _buildSectionHeader(
              'Linear scale questions (1 = Poor, 5 = Excellent)',
            ),
            const SizedBox(height: 12),
            ...List.generate(
              _linearControllers.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildQuestionField(
                  _getOrdinal(index),
                  index == 0
                      ? 'How clearly did the mentor explain the\nfoundational UI/UX concepts...'
                      : index == 1
                      ? 'How relevant was the workshop content\nto your current learning goals...'
                      : 'Type your question here...',
                  _linearControllers[index],
                ),
              ),
            ),
            _buildAddAnotherLink(
              onTap: () {
                setState(() {
                  _linearControllers.add(TextEditingController());
                });
              },
            ),

            // Open-ended Questions
            _buildSectionHeader('Open-ended questions'),
            const SizedBox(height: 12),
            ...List.generate(
              _openEndedControllers.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildQuestionField(
                  _getOrdinal(index),
                  index == 0
                      ? 'What part of the workshop did you enjoy\nthe most, and what can we improve...'
                      : 'Type your question here...',
                  _openEndedControllers[index],
                ),
              ),
            ),
            _buildAddAnotherLink(
              onTap: () {
                setState(() {
                  _openEndedControllers.add(TextEditingController());
                });
              },
            ),

            // Checklist Questions
            _buildSectionHeader('Checklist questions'),
            const SizedBox(height: 12),
            ...List.generate(
              _checklistQuestions.length,
              (index) => _buildCheckboxItem(index),
            ),
            _buildAddAnotherLink(
              onTap: () {
                setState(() {
                  _checklistQuestions.add({
                    'title': 'New checklist option...',
                    'isChecked': false,
                  });
                });
              },
            ),
            const SizedBox(height: 12),

            // SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B4EFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // TODO:Save logic
                },
                child: const Text(
                  "Save & Link to Program",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF4A4A4A),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.arrow_drop_up, color: Colors.grey.shade400, size: 22),
      ],
    );
  }

  Widget _buildQuestionField(
    String label,
    String hintText,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
              height: 1.5,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Color(0xFF6B4EFF),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddAnotherLink({required VoidCallback onTap}) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: Text(
            'Add another question?',
            style: TextStyle(
              color: Color(0xFF2D81D7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(int index) {
    final item = _checklistQuestions[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Checkbox(
              value: item['isChecked'],
              activeColor: const Color(0xFF6B4EFF),
              side: BorderSide(color: Colors.grey.shade400, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              onChanged: (bool? value) {
                setState(() {
                  _checklistQuestions[index]['isChecked'] = value ?? false;
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item['title'],
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF2D3142),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
