import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedEmoji = -1;

  final List<String> feedbackOptions = [
    "The interface easy to navigate.",
    "I can design clearly.",
    "Users are easy to discover.",
    "The platform matched reliably.",
    "The content is engaging and easy to understand.",
  ];

  late List<bool> selectedOptions;

  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedOptions = List.generate(feedbackOptions.length, (_) => false);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Widget buildEmojiButton(String emoji, int index) {
    bool isSelected = selectedEmoji == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEmoji = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
          ),
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Center(
                  child: Text(
                    "Share your feedback",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    "Rate your experience",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildEmojiButton("😡", 0),
                    buildEmojiButton("😕", 1),
                    buildEmojiButton("😐", 2),
                    buildEmojiButton("🙂", 3),
                    buildEmojiButton("😄", 4),
                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  "What did we do well?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),

                ...List.generate(
                  feedbackOptions.length,
                      (index) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(feedbackOptions[index]),
                    value: selectedOptions[index],
                    activeColor: Colors.deepPurple,
                    onChanged: (value) {
                      setState(() {
                        selectedOptions[index] = value!;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Your Comment (Optional)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: commentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Write your feedback here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Feedback submitted!"),
                        ),
                      );
                    },
                    child: const Text(
                      "Send Feedback",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
