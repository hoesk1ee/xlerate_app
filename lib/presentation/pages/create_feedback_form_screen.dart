import 'package:flutter/material.dart';
import 'package:xlerate/data/program_data.dart';

class FormQuestion {
  final String id; // Unique ID
  final QuestionType type;
  final TextEditingController titleController;
  final List<TextEditingController> optionsControllers;
  bool isRequired;

  FormQuestion({required this.type})
    : id = UniqueKey().toString(),
      titleController = TextEditingController(),

      // Start with 2 blank options if it's a choice-based question
      optionsControllers =
          (type == QuestionType.multipleChoice ||
              type == QuestionType.checkboxes ||
              type == QuestionType.dropdown)
          ? [TextEditingController(), TextEditingController()]
          : [],
      isRequired = false;

  void dispose() {
    titleController.dispose();
    for (var controller in optionsControllers) {
      controller.dispose();
    }
  }
}

// MAIN SCREEN

class CreateFeedbackFormScreen extends StatefulWidget {
  const CreateFeedbackFormScreen({super.key});

  @override
  State<CreateFeedbackFormScreen> createState() =>
      _CreateFeedbackFormScreenState();
}

class _CreateFeedbackFormScreenState extends State<CreateFeedbackFormScreen> {
  final TextEditingController _formTitleController = TextEditingController(
    text: "New Feedback Form",
  );
  final TextEditingController _formDescController = TextEditingController();

  final List<FormQuestion> _questions = [];

  @override
  void dispose() {
    _formTitleController.dispose();
    _formDescController.dispose();
    for (var q in _questions) {
      q.dispose();
    }
    super.dispose();
  }

  // --- ACTIONS ---

  void _addQuestion(QuestionType type) {
    setState(() {
      _questions.add(FormQuestion(type: type));
    });
    Navigator.pop(context);
  }

  void _showAddQuestionMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add a Question",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildMenuOption(
                      Icons.star,
                      "Star Rating",
                      QuestionType.starRating,
                    ),
                    _buildMenuOption(
                      Icons.emoji_emotions,
                      "Emoji Rating",
                      QuestionType.emojiRating,
                    ),
                    _buildMenuOption(
                      Icons.linear_scale,
                      "Linear Scale",
                      QuestionType.linearScale,
                    ),
                    _buildMenuOption(
                      Icons.thumbs_up_down,
                      "Yes/No",
                      QuestionType.yesNo,
                    ),
                    _buildMenuOption(
                      Icons.radio_button_checked,
                      "Multiple Choice",
                      QuestionType.multipleChoice,
                    ),
                    _buildMenuOption(
                      Icons.check_box,
                      "Checkboxes",
                      QuestionType.checkboxes,
                    ),
                    _buildMenuOption(
                      Icons.arrow_drop_down_circle,
                      "Dropdown",
                      QuestionType.dropdown,
                    ),
                    _buildMenuOption(
                      Icons.short_text,
                      "Short Answer",
                      QuestionType.shortText,
                    ),
                    _buildMenuOption(
                      Icons.notes,
                      "Paragraph",
                      QuestionType.longText,
                    ),
                    _buildMenuOption(
                      Icons.calendar_today,
                      "Date",
                      QuestionType.date,
                    ),
                    _buildMenuOption(
                      Icons.upload_file,
                      "File Upload",
                      QuestionType.fileUpload,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        title: const Text(
          "Build Form",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          TextButton(
            onPressed: () {
              // --- VALIDATION CHECKS ---
              if (_formDescController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please provide a form description."),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                return; // Stop the save process
              }

              if (_questions.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please add at least one question."),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                return;
              }

              bool hasEmptyTitles = _questions.any(
                (q) => q.titleController.text.trim().isEmpty,
              );
              if (hasEmptyTitles) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "All questions must have a title before publishing.",
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                return;
              }
              bool hasInvalidOptions = _questions.any((q) {
                if (q.type == QuestionType.multipleChoice ||
                    q.type == QuestionType.checkboxes ||
                    q.type == QuestionType.dropdown) {
                  // Fails if there are 0 options, OR if any existing option is blank
                  if (q.optionsControllers.isEmpty) return true;
                  return q.optionsControllers.any(
                    (controller) => controller.text.trim().isEmpty,
                  );
                }
                return false;
              });

              if (hasInvalidOptions) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please fill all the answer options.",
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                return;
              }

              // If all validation passes, compile the questions!
              List<SavedQuestion> compiledQuestions = _questions.map((q) {
                return SavedQuestion(
                  title: q.titleController.text.trim(),
                  type: q.type,
                  isRequired: q.isRequired,
                  options: q.optionsControllers
                      .map((c) => c.text.trim())
                      .toList(),
                );
              }).toList();

              // Final Form
              SavedFeedbackForm newForm = SavedFeedbackForm(
                id: UniqueKey().toString(),
                title: _formTitleController.text.trim().isNotEmpty
                    ? _formTitleController.text.trim()
                    : "Untitled Form",
                description: _formDescController.text.trim(),
                questions: compiledQuestions,
              );

              // Attach the form to our mock database
              globalPrograms[0].feedbackForm = newForm;

              // Success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Form published successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text(
              "Save & Publish",
              style: TextStyle(
                color: Color(0xFF6B4EFF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // Button for adding questions
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddQuestionMenu,
        backgroundColor: const Color(0xFF6B4EFF),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add Question",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: ReorderableListView.builder(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 100,
        ),
        itemCount: _questions.length + 1, // +1 for the Header Card
        onReorderItem: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex == 0 || newIndex == 0) return;
            final item = _questions.removeAt(oldIndex - 1);
            _questions.insert(newIndex - 1, item);
          });
        },
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildFormHeader(key: const ValueKey('header'));
          }

          //Dynamic questions
          final questionIndex = index - 1;
          final question = _questions[questionIndex];
          return _buildQuestionCard(
            question,
            questionIndex,
            key: ValueKey(question.id),
          );
        },
      ),
    );
  }

  // UI BUILDER

  // Made the duplicate question button functional
  void _duplicateQuestion(int index, FormQuestion source) {
    setState(() {
      // 1. Create a new question of the same type
      FormQuestion newQuestion = FormQuestion(type: source.type);

      // 2. Copy the title and append "(Copy)"
      newQuestion.titleController.text =
          "${source.titleController.text} (Copy)";

      // 3. Copy required status
      newQuestion.isRequired = source.isRequired;

      // 4. Copy options if it's a multiple choice/dropdown/checkbox question,etc...
      if (source.optionsControllers.isNotEmpty) {
        newQuestion.optionsControllers.clear();
        for (var optionController in source.optionsControllers) {
          newQuestion.optionsControllers.add(
            TextEditingController(text: optionController.text),
          );
        }
      }

      // 5. Insert it directly below the original question
      _questions.insert(index + 1, newQuestion);
    });
  }

  Widget _buildMenuOption(IconData icon, String label, QuestionType type) {
    return InkWell(
      onTap: () => _addQuestion(type),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF6B4EFF), size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormHeader({required Key key}) {
    return Card(
      key: key,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: const Border(
            top: BorderSide(color: Color(0xFF6B4EFF), width: 8),
          ), //
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _formTitleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: "Form Title",
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _formDescController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "Form description...",
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
    FormQuestion question,
    int index, {
    required Key key,
  }) {
    return Card(
      key: key,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Drag Handle
            Center(
              child: Icon(Icons.drag_indicator, color: Colors.grey.shade300),
            ),
            const SizedBox(height: 8),

            // Question Title
            TextField(
              controller: question.titleController,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: "Question Title",
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Dynamic Body
            _buildQuestionBody(question),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 1. DELETE BUTTON (Left)
                InkWell(
                  onTap: () {
                    setState(() {
                      question.dispose(); // Free up memory
                      _questions.remove(question); // Remove from list
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.delete_outline,
                      size: 22,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // 2. COPY BUTTON (Right)
                InkWell(
                  onTap: () => _duplicateQuestion(index, question),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.content_copy,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Container(width: 1, height: 24, color: Colors.grey.shade300),
                const SizedBox(width: 16),

                const Text(
                  "Required",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Switch(
                  value: question.isRequired,
                  activeThumbColor: const Color(0xFF6B4EFF),
                  onChanged: (val) {
                    setState(() {
                      question.isRequired = val;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionBody(FormQuestion question) {
    switch (question.type) {
      case QuestionType.yesNo:
        return const Text(
          "Yes/No UI goes here",
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        );
      case QuestionType.emojiRating:
        return const Text(
          "Emoji Rating UI goes here",
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        );
      case QuestionType.linearScale:
        return const Text(
          "Linear Scale UI goes here",
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        );
      case QuestionType.shortText:
        return const Text(
          "Short answer text",
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        );
      case QuestionType.longText:
        return const Text(
          "Long answer text",
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        );
      case QuestionType.starRating:
        return Row(
          children: List.generate(
            5,
            (index) =>
                const Icon(Icons.star_border, color: Colors.grey, size: 32),
          ),
        );
      case QuestionType.date:
        return Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.grey),
            const SizedBox(width: 8),
            const Text(
              "Month, Day, Year",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        );
      case QuestionType.fileUpload:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "Users will upload a file here",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      case QuestionType.multipleChoice:
      case QuestionType.checkboxes:
      case QuestionType.dropdown:

        // Groups all choice-based questions
        return Column(
          children: [
            ...List.generate(question.optionsControllers.length, (i) {
              IconData leadingIcon =
                  question.type == QuestionType.multipleChoice
                  ? Icons.radio_button_unchecked
                  : question.type == QuestionType.checkboxes
                  ? Icons.check_box_outline_blank
                  : Icons.format_list_numbered;
              return Row(
                children: [
                  Icon(leadingIcon, color: Colors.grey, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: question.optionsControllers[i],
                      decoration: InputDecoration(
                        hintText: "Option ${i + 1}",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                    onPressed: () {
                      setState(() {
                        question.optionsControllers[i].dispose();
                        question.optionsControllers.removeAt(i);
                      });
                    },
                  ),
                ],
              );
            }),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  setState(
                    () => question.optionsControllers.add(
                      TextEditingController(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 16),
                label: const Text("Add option"),
              ),
            ),
          ],
        );
    }
  }
}
