import 'package:flutter/material.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final TextEditingController titleController = TextEditingController(
    text: "Survey Reminder",
  );

  final TextEditingController messageController = TextEditingController(
    text: "Submit your feedback for us till 13 July 2026",
  );

  String priority = "Urgent";
  bool sendNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            children: [
              //---------------- App Bar ----------------//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleButton(Icons.arrow_back_ios_new),

                  const Text(
                    "New Announcement",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff364152),
                    ),
                  ),

                  _circleButton(Icons.add),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //---------------- Image ----------------//
                      Container(
                        height: 170,
                        width: double.infinity,

                        decoration: BoxDecoration(
                          color: const Color(0xffE8ECF3),
                          borderRadius: BorderRadius.circular(4),
                        ),

                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      //---------------- Title ----------------//
                      const Text(
                        "Announcement Title",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 5),

                      TextField(
                        controller: titleController,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      //---------------- Message ----------------//
                      const Text(
                        "Message",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 5),

                      TextField(
                        controller: messageController,
                        maxLines: 3,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 15),

                      //---------------- Priority ----------------//
                      const Text(
                        "Announcement Priority",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          ChoiceChip(
                            label: const Text("Urgent"),
                            selected: priority == "Urgent",

                            onSelected: (value) {
                              setState(() {
                                priority = "Urgent";
                              });
                            },
                          ),

                          const SizedBox(width: 10),

                          ChoiceChip(
                            label: const Text("Normal"),
                            selected: priority == "Normal",

                            onSelected: (value) {
                              setState(() {
                                priority = "Normal";
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      //---------------- Notification ----------------//
                      const Text(
                        "Send Notification to learners?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                "Send notification",
                                style: TextStyle(fontSize: 13),
                              ),
                              value: true,
                              groupValue: sendNotification,
                              onChanged: (value) {
                                setState(() {
                                  sendNotification = value!;
                                });
                              },
                            ),
                          ),

                          Expanded(
                            child: RadioListTile<bool>(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                "Don't send",
                                style: TextStyle(fontSize: 13),
                              ),
                              value: false,
                              groupValue: sendNotification,
                              onChanged: (value) {
                                setState(() {
                                  sendNotification = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //---------------- Button ----------------//
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff635BFF),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Announcement Created!",
                        ),
                      ),
                    );
                  },

                  child: const Text(
                    "Create Announcement",
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
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      height: 42,
      width: 42,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Icon(
        icon,
        size: 18,
        color: Colors.grey,
      ),
    );
  }
}
