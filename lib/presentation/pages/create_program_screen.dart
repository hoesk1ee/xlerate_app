import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/program_data.dart';
import 'create_feedback_form_screen.dart';

class CreateProgramScreen extends StatefulWidget {
  const CreateProgramScreen({super.key});

  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _speakerController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _eligibilityController = TextEditingController();
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();

  // Event Details
  File? _selectedImage;
  bool _createFeedback = true;
  bool _isMultiDay = false;
  bool _isFree = true;
  bool _offersCertificate = false;
  bool _offersBadge = false;
  String _locationType = 'In-Person';

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _selectedTime;
  DateTime? _deadlineDate;

  // Event Tags
  final List<String> _selectedTags = [];
  final List<String> _suggestedTags = [
    'Tech',
    'Database',
    'SQL',
    'Design',
    'AI',
    'Business',
    'Marketing',
    'Nature',
    'Economy',
  ];

  final List<String> _selectedSkills = [];
  final List<String> _suggestedSkills = [
    'Critical Thinking',
    'Creative Thinking',
    'Productivity',
  ];

  // Date Picker
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_deadlineDate != null && _deadlineDate!.isAfter(_startDate!)) {
          _deadlineDate = null;
        }
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
        }
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    if (_startDate == null) {
      _showErrorSnackBar('Please select a Start Date first.');
      return;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate!,
      firstDate: _startDate!,
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  Future<void> _selectDeadline(BuildContext context) async {
    if (_startDate == null) {
      _showErrorSnackBar('Please select an Event Start Date first.');
      return;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().isBefore(_startDate!)
          ? DateTime.now()
          : _startDate!,
      firstDate: DateTime.now(),
      lastDate: _startDate!,
    );
    if (picked != null) setState(() => _deadlineDate = picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}';
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Program',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey, // Wraps everything in validation logic
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? Center(
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Colors.grey.shade400,
                            size: 50,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 24),

              // Program Info
              _buildSectionCard(
                title: 'EVENT DETAILS',
                children: [
                  _buildValidatedInputField(
                    label: 'Event name *',
                    hint: 'e.g. Mastering Database',
                    controller: _titleController,
                    isRequired: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildValidatedInputField(
                          label: 'Held by *',
                          hint: 'Excelerate',
                          controller: _hostController,
                          isRequired: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildValidatedInputField(
                          label: 'Guest/Speaker',
                          hint: 'e.g. Alex Uzbek',
                          controller: _speakerController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Program Date or Duration
              _buildSectionCard(
                title: 'LOGISTICS',
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Event Duration',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          const Text('Single', style: TextStyle(fontSize: 12)),
                          Switch(
                            value: _isMultiDay,
                            activeThumbColor: const Color(0xFF5E5CE6),
                            onChanged: (val) => setState(() {
                              _isMultiDay = val;
                              if (!val) {
                                _endDate = null;
                              } // Clear end date if switched back to single
                            }),
                          ),
                          const Text(
                            'Multi-Day',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInteractiveField(
                          label: 'Start Date *',
                          text: _formatDate(_startDate),
                          icon: Icons.calendar_today,
                          onTap: () => _selectStartDate(context),
                        ),
                      ),
                      if (_isMultiDay) ...[
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInteractiveField(
                            label: 'End Date *',
                            text: _formatDate(_endDate),
                            icon: Icons.date_range,
                            onTap: () => _selectEndDate(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Program Location
                  Row(
                    children: [
                      _buildFilterChip(
                        'In-Person',
                        _locationType == 'In-Person',
                        () => setState(() => _locationType = 'In-Person'),
                      ),
                      _buildFilterChip(
                        'Virtual',
                        _locationType == 'Virtual',
                        () => setState(() => _locationType = 'Virtual'),
                      ),
                      _buildFilterChip(
                        'Hybrid',
                        _locationType == 'Hybrid',
                        () => setState(() => _locationType = 'Hybrid'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildValidatedInputField(
                          label: 'Location Details *',
                          hint: _locationType == 'Virtual'
                              ? 'Zoom/Meet Link'
                              : 'Groove St., Andreas',
                          controller: _locationController,
                          isRequired: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: _buildValidatedInputField(
                          label: 'Available Seats',
                          hint: '40',
                          controller: _seatsController,
                          isNumber: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInteractiveField(
                    label: 'Start Time *',
                    text: _selectedTime == null
                        ? 'Set Time'
                        : _selectedTime!.format(context),
                    icon: Icons.access_time,
                    onTap: () => _selectTime(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Audience & Fees
              _buildSectionCard(
                title: 'AUDIENCE & PRICING',
                children: [
                  _buildValidatedInputField(
                    label: 'Eligibility / Target Audience',
                    hint: 'e.g. 8th to 10th Graders Only',
                    controller: _eligibilityController,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Participation Fee',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          const Text('Paid', style: TextStyle(fontSize: 12)),
                          Switch(
                            value: _isFree,
                            activeThumbColor: Colors.green,
                            onChanged: (val) => setState(() {
                              _isFree = val;
                              if (val) _feeController.clear();
                            }),
                          ),
                          const Text(
                            'Free',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (!_isFree) ...[
                    const SizedBox(height: 8),
                    _buildValidatedInputField(
                      label: 'Price (\$)',
                      hint: '0.00',
                      controller: _feeController,
                      isNumber: true,
                      isRequired: true,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),

              // Program Description
              _buildSectionCard(
                title: 'ADDITIONAL INFO',
                children: [
                  _buildValidatedInputField(
                    label: 'Event Descriptions *',
                    hint: 'Write a brief description...',
                    maxLines: 4,
                    controller: _descriptionController,
                    isRequired: true,
                  ),
                  const SizedBox(height: 16),

                  // Event URL
                  _buildLabeledInputField(
                    label: 'Event URL',
                    hint: 'Enter a link for more info...',
                    controller: _urlController,
                  ),
                  const SizedBox(height: 16),

                  // Tags
                  _buildListManager(
                    label: 'Event Tags',
                    hint: 'Type or Select tags...',
                    controller: _tagController,
                    selectedList: _selectedTags,
                    suggestedList: _suggestedTags,
                  ),
                  const SizedBox(height: 16),

                  // Skills
                  _buildListManager(
                    label: 'Skillset',
                    hint: 'Add skills...',
                    controller: _skillController,
                    selectedList: _selectedSkills,
                    suggestedList: _suggestedSkills,
                    chipColor: Colors.teal,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Rewards Offered',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _offersCertificate,
                        activeColor: const Color(0xFF5E5CE6),
                        onChanged: (val) =>
                            setState(() => _offersCertificate = val!),
                      ),
                      const Text('Certificate'),
                      const SizedBox(width: 20),
                      Checkbox(
                        value: _offersBadge,
                        activeColor: const Color(0xFF5E5CE6),
                        onChanged: (val) => setState(() => _offersBadge = val!),
                      ),
                      const Text('Digital Badge'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Additional Info
              _buildSectionCard(
                title: 'ADMINISTRATION',
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildInteractiveField(
                          label: 'Register Deadline *',
                          text: _formatDate(_deadlineDate),
                          icon: Icons.event_busy,
                          onTap: () => _selectDeadline(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Create Feedback Form?',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _buildRadioButton('Yes', true),
                                const SizedBox(width: 16),
                                _buildRadioButton('No', false),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5E5CE6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Publish Program',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Submit Logic
  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      _showErrorSnackBar('Please fill out all required fields.');
      return;
    }

    if (_startDate == null ||
        _deadlineDate == null ||
        _selectedTime == null ||
        (_isMultiDay && _endDate == null)) {
      _showErrorSnackBar('Please ensure all Dates and Times are selected.');
      return;
    }

    // Program Data
    final newProgram = Program(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      host: _hostController.text.trim(),
      speaker: _speakerController.text.trim(),
      startDate: _formatDate(_startDate),
      endDate: _isMultiDay ? _formatDate(_endDate) : null,
      time: _selectedTime!.format(context),
      locationType: _locationType,
      location: _locationController.text.trim(),
      tag: _selectedTags.isNotEmpty ? _selectedTags.join(', ') : 'Misc',
      skills: List.from(_selectedSkills),
      eligibility: _eligibilityController.text.trim().isEmpty
          ? 'Open to all'
          : _eligibilityController.text.trim(),
      isFree: _isFree,
      fee: _isFree ? 0.0 : double.tryParse(_feeController.text) ?? 0.0,
      offersCertificate: _offersCertificate,
      offersBadge: _offersBadge,
      imageUrl: 'https://picsum.photos/200',
      imageFile: _selectedImage,
    );

    globalPrograms.insert(0, newProgram);

    //Show Success Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Program Published Successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate to CreateFeedbackFormScreen if selected Yes.
    if (_createFeedback) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateFeedbackFormScreen(),
        ),
      );
    } else {
      Navigator.pop(context, true);
    }
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: 1.2,
            ),
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildValidatedInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    bool isRequired = false,
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        TextFormField(
          // Swapped to TextFormField for Validation
          controller: controller,
          maxLines: maxLines,
          keyboardType: isNumber
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          validator: isRequired
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF5E5CE6)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveField({
    required String label,
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: text.contains('Select') || text.contains('Set')
                        ? Colors.grey.shade400
                        : Colors.black87,
                    fontSize: 14,
                  ),
                ),
                Icon(icon, color: Colors.grey.shade400, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF5E5CE6).withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF5E5CE6) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF5E5CE6) : Colors.grey.shade600,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildListManager({
    required String label,
    required String hint,
    required TextEditingController controller,
    required List<String> selectedList,
    required List<String> suggestedList,
    Color chipColor = const Color(0xFF5E5CE6),
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: IconButton(
              icon: Icon(Icons.add_circle, color: chipColor),
              onPressed: () {
                if (controller.text.trim().isNotEmpty &&
                    !selectedList.contains(controller.text.trim())) {
                  setState(() {
                    selectedList.add(controller.text.trim());
                    controller.clear();
                  });
                }
              },
            ),
          ),
        ),
        if (selectedList.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedList
                .map(
                  (item) => Chip(
                    label: Text(
                      item,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    backgroundColor: chipColor,
                    deleteIcon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                    onDeleted: () => setState(() => selectedList.remove(item)),
                  ),
                )
                .toList(),
          ),
        ],
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: suggestedList.map((item) {
              final isSelected = selectedList.contains(item);
              return GestureDetector(
                onTap: () => setState(() {
                  isSelected
                      ? selectedList.remove(item)
                      : selectedList.add(item);
                }),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? chipColor.withValues(alpha: 0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? chipColor : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: isSelected ? chipColor : Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButton(String label, bool value) {
    return GestureDetector(
      onTap: () => setState(() => _createFeedback = value),
      child: Row(
        children: [
          Icon(
            _createFeedback == value
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: _createFeedback == value
                ? const Color(0xFF5E5CE6)
                : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
