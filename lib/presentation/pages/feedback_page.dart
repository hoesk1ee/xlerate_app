import 'package:flutter/material.dart';
import 'package:xlerate/data/program_data.dart';
import 'package:file_picker/file_picker.dart';

class FeedbackPage extends StatefulWidget {
  final SavedFeedbackForm form;
  const FeedbackPage({super.key, required this.form});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final Map<String, dynamic> _answers = {};
  final List<String> _ratingEmojis = ['😡', '😕', '😐', '🙂', '🤩'];

  // Brand Colors
  final Color _brandOrange = const Color(0xFFFF6B00);
  final Color _brandPink = const Color(0xFFF03737);

  bool _showErrors = false;
  bool _isSubmitting = false;

  void _handleSubmit() async {
    // Validate: Check if every question has an answer
    bool allAnswered = widget.form.questions.asMap().keys.every((index) {
      final val = _answers[index.toString()];
      if (val == null) return false;
      if (val is String && val.trim().isEmpty) return false;
      if (val is List && val.isEmpty) return false;
      return true;
    });

    if (!allAnswered) {
      //Trigger friendly errors
      setState(() => _showErrors = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const Row(
            children: [
              Icon(Icons.sentiment_dissatisfied, color: Colors.orangeAccent),
              SizedBox(width: 10),
              Text("Oops! Looks like you missed a few questions."),
            ],
          ),
        ),
      );
      return;
    }

    setState(() {
      _showErrors = false;
      _isSubmitting = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    // Success state
    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text("Thank you! Your feedback helps us grow. 🚀"),
            ],
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      // Branded Aura Background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _brandOrange.withAlpha(
                35,
              ),
              Colors.grey.shade50,
              _brandPink.withAlpha(25),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          // SafeAreato prevent the card from jumping up under the device notch/status bar
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shadowColor: _brandOrange.withAlpha(30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BRANDED HEADER
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 600),
                      builder: (context, val, child) => Opacity(
                        opacity: val,
                        child: child,
                      ),
                      child: Center(
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [_brandOrange, _brandPink],
                          ).createShader(bounds),
                          child: Text(
                            widget.form.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    if (widget.form.description.isNotEmpty)
                      Center(
                        child: Text(
                          widget.form.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),

                    const SizedBox(height: 40),

                    // DYNAMIC QUESTIONS
                    ...widget.form.questions.asMap().entries.map(
                      (entry) {
                        return TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          // Stagger the animation based on index
                          duration: Duration(
                            milliseconds: 400 + (entry.key * 150),
                          ),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 30 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: _buildDynamicQuestion(
                            entry.value,
                            entry.key.toString(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // SUBMIT BUTTON
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: _isSubmitting ? 60 : double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: _isSubmitting
                              ? null
                              : LinearGradient(
                                  colors: [_brandOrange, _brandPink],
                                ),
                          color: _isSubmitting ? Colors.grey.shade200 : null,
                          borderRadius: BorderRadius.circular(
                            _isSubmitting ? 30 : 14,
                          ),
                          boxShadow: _isSubmitting
                              ? []
                              : [
                                  BoxShadow(
                                    color: _brandOrange.withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: _isSubmitting ? null : _handleSubmit,
                          child: _isSubmitting
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: _brandOrange,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  "Send Feedback",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicQuestion(SavedQuestion question, String qId) {
    // Check if needed to show an error for this specific question
    bool hasAnswer =
        _answers[qId] != null &&
        (_answers[qId] is String ? _answers[qId].trim().isNotEmpty : true) &&
        (_answers[qId] is List ? _answers[qId].isNotEmpty : true);

    bool showHighlight = _showErrors && !hasAnswer;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: showHighlight
            ? _brandOrange.withValues(alpha: .05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: showHighlight
              ? _brandOrange.withValues(alpha: .5)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  question.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          // Friendly Error Message
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, size: 16, color: _brandOrange),
                  const SizedBox(width: 6),
                  Text(
                    "We'd love your thoughts here! 🥺",
                    style: TextStyle(
                      fontSize: 13,
                      color: _brandOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: showHighlight
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),

          const SizedBox(height: 16),
          _buildQuestionInput(question, qId),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(SavedQuestion question, String qId) {
    // EMOJI RATING
    if (question.type == QuestionType.emojiRating) {
      int currentRating = _answers[qId] ?? -1;

      // The Red-to-Green color scale for each emoji
      final List<Color> sentimentColors = [
        Colors.red.shade500, // 😡
        Colors.orange.shade500, // 😕
        Colors.amber.shade500, // 😐
        Colors.lightGreen.shade500, // 🙂
        Colors.green.shade600, // 🤩
      ];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          bool isSelected = currentRating == index;
          Color activeColor = sentimentColors[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                _answers[qId] = index;
                if (_showErrors) _showErrors = false;
              });
            },
            child: AnimatedScale(
              scale: isSelected ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.elasticOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? activeColor : Colors.grey.shade200,
                    width: isSelected ? 2 : 1,
                  ),
                  color: isSelected
                      ? activeColor.withValues(alpha: 0.15)
                      : Colors.white,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: activeColor.withValues(alpha: .3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  _ratingEmojis[index],
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
          );
        }),
      );
    } else if (question.type == QuestionType.starRating) {
      int currentStars = _answers[qId] ?? 0;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          bool isFilled = index < currentStars;
          return IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                key: ValueKey(isFilled),
                color: isFilled ? Colors.amber : Colors.grey.shade400,
                size: 40,
              ),
            ),
            onPressed: () {
              setState(() {
                _answers[qId] = index + 1;
                if (_showErrors) _showErrors = false;
              });
            },
          );
        }),
      );
    }
    // MULTIPLE CHOICE
    else if (question.type == QuestionType.multipleChoice) {
      String? selectedOption = _answers[qId] as String?;
      return RadioGroup<String>(
        groupValue: selectedOption,
        onChanged: (String? val) {
          setState(() {
            _answers[qId] = val;
            if (_showErrors) _showErrors = false;
          });
        },
        child: Column(
          children: question.options.map((opt) {
            String optionText = opt.toString();
            bool isSelected = selectedOption == optionText;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? _brandOrange.withAlpha(12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? _brandOrange : Colors.transparent,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  setState(() {
                    _answers[qId] = optionText;
                    if (_showErrors) _showErrors = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: optionText,
                        activeColor: _brandOrange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          optionText,
                          style: TextStyle(
                            fontSize: 15,
                            color: isSelected ? _brandOrange : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else if (question.type == QuestionType.checkboxes) {
      List<String> selected = _answers[qId] ?? [];
      return Column(
        children: question.options.map((opt) {
          bool isChecked = selected.contains(opt);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isChecked
                  ? _brandOrange.withValues(alpha: .05)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isChecked ? _brandOrange : Colors.transparent,
              ),
            ),
            child: CheckboxListTile(
              title: Text(
                opt,
                style: TextStyle(
                  fontSize: 15,
                  color: isChecked ? _brandOrange : Colors.black87,
                  fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              value: isChecked,
              activeColor: _brandOrange,
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.trailing,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onChanged: (val) {
                setState(() {
                  val == true ? selected.add(opt) : selected.remove(opt);
                  _answers[qId] = selected;
                  if (_showErrors) _showErrors = false;
                });
              },
            ),
          );
        }).toList(),
      );
    }
    // LINEAR SCALE
    else if (question.type == QuestionType.linearScale) {
      double currentScale = _answers[qId] ?? 3.0;
      double normalizedValue = (currentScale - 1) / 4;
      Color dynamicColor =
          Color.lerp(
            Colors.red.shade500,
            Colors.green.shade600,
            normalizedValue,
          ) ??
          Colors.green;

      return Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: dynamicColor,
              inactiveTrackColor: dynamicColor.withValues(alpha: .2),
              thumbColor: dynamicColor,
              overlayColor: dynamicColor.withValues(alpha: .2),
              valueIndicatorColor: dynamicColor,
              trackHeight: 6,
            ),
            child: Slider(
              value: currentScale,
              min: 1,
              max: 5,
              divisions: 4,
              label: currentScale.round().toString(),
              onChanged: (val) {
                setState(() {
                  _answers[qId] = val;
                  if (_showErrors) _showErrors = false;
                });
              },
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1 (Low)",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "5 (High)",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      );
    } else if (question.type == QuestionType.longText ||
        question.type == QuestionType.shortText) {
      return TextField(
        maxLines: question.type == QuestionType.longText ? 4 : 1,
        decoration: InputDecoration(
          hintText: "Write your thoughts here...",
          hintStyle: TextStyle(color: Colors.grey.shade400),
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _brandOrange, width: 2),
          ),
        ),
        onChanged: (val) {
          _answers[qId] = val;
          if (_showErrors && val.isNotEmpty) {
            setState(() => _showErrors = false);
          }
        },
      );
    } // YES / NO
    else if (question.type == QuestionType.yesNo) {
      String? selectedAnswer = _answers[qId] as String?;

      return Row(
        children: [
          // --- YES BUTTON ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    _answers[qId] = "Yes";
                    if (_showErrors) _showErrors = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: selectedAnswer == "Yes"
                        ? Colors
                              .green
                              .shade600 // Vibrant green when selected
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedAnswer == "Yes"
                          ? Colors.green.shade600
                          : Colors.grey.shade300,
                      width: selectedAnswer == "Yes" ? 2 : 1,
                    ),
                    boxShadow: selectedAnswer == "Yes"
                        ? [
                            BoxShadow(
                              color: Colors.green.withAlpha(50),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedAnswer == "Yes"
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // --- NO BUTTON ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    _answers[qId] = "No";
                    if (_showErrors) _showErrors = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: selectedAnswer == "No"
                        ? Colors.red.shade500
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedAnswer == "No"
                          ? Colors.red.shade500
                          : Colors.grey.shade300,
                      width: selectedAnswer == "No" ? 2 : 1,
                    ),
                    boxShadow: selectedAnswer == "No"
                        ? [
                            BoxShadow(
                              color: Colors.red.withAlpha(50),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "No",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedAnswer == "No"
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    // DROPDOWN
    else if (question.type == QuestionType.dropdown) {
      String? selectedOption = _answers[qId] as String?;
      return DropdownButtonFormField<String>(
        value: selectedOption,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _brandOrange, width: 2),
          ),
        ),
        hint: Text(
          "Select an option",
          style: TextStyle(color: Colors.grey.shade400),
        ),
        items: question.options.map((opt) {
          return DropdownMenuItem<String>(
            value: opt,
            child: Text(opt, style: const TextStyle(fontSize: 15)),
          );
        }).toList(),
        onChanged: (val) {
          setState(() {
            _answers[qId] = val;
            if (_showErrors) _showErrors = false;
          });
        },
      );
    }
    // DATE PICKER
    else if (question.type == QuestionType.date) {
      DateTime? selectedDate = _answers[qId] as DateTime?;
      String dateText = selectedDate == null
          ? "Select Date"
          : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                // Brands the calendar with your Excelerate Orange
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: _brandOrange,
                    onPrimary: Colors.white,
                    onSurface: Colors.black87,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            setState(() {
              _answers[qId] = picked;
              if (_showErrors) _showErrors = false;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateText,
                style: TextStyle(
                  fontSize: 16,
                  color: selectedDate == null
                      ? Colors.grey.shade400
                      : Colors.black87,
                ),
              ),
              Icon(Icons.calendar_today, color: _brandOrange, size: 20),
            ],
          ),
        ),
      );
    }
    // FILE UPLOAD
    else if (question.type == QuestionType.fileUpload) {
      String? uploadedFileName = _answers[qId] as String?;
      bool isUploading = uploadedFileName == "Uploading...";

      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          // Launch the native file picker
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.any, // Lets them pick PDFs, images, docs, etc.
          );

          if (result != null) {
            PlatformFile file = result.files.first;

            // Show a quick loading
            setState(() {
              _answers[qId] = "Uploading...";
              if (_showErrors) _showErrors = false;
            });

            // A tiny delay so the UI spinner shows briefly
            await Future.delayed(const Duration(milliseconds: 500));

            if (mounted) {
              setState(() {
                _answers[qId] = file.name;
              });
            }
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(
              color: uploadedFileName != null && !isUploading
                  ? _brandOrange
                  : Colors.grey.shade300,
              width: uploadedFileName != null && !isUploading ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: uploadedFileName != null && !isUploading
                ? _brandOrange.withAlpha(15)
                : Colors.white,
          ),
          child: Center(
            child: Column(
              children: [
                if (isUploading)
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      color: _brandOrange,
                      strokeWidth: 3,
                    ),
                  )
                else
                  Icon(
                    uploadedFileName != null
                        ? Icons.check_circle
                        : Icons.cloud_upload_outlined,
                    size: 40,
                    color: uploadedFileName != null
                        ? Colors.green
                        : _brandOrange,
                  ),
                const SizedBox(height: 12),
                Text(
                  isUploading
                      ? "Reading file..."
                      : (uploadedFileName != null
                            ? "Attached: $uploadedFileName"
                            : "Tap to browse files"),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: uploadedFileName != null && !isUploading
                        ? Colors.black87
                        : Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow
                      .ellipsis, // Prevents giant file names from breaking the UI
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
