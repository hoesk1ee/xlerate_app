import 'package:flutter/material.dart';
import '../../data/program_data.dart';
import 'create_program_screen.dart';

class ProgramListScreen extends StatefulWidget {
  final bool isAdmin;

  const ProgramListScreen({
    super.key,
    this.isAdmin = true,
  }); // Default to true for testing

  @override
  State<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen>
    with SingleTickerProviderStateMixin {
  List<Program> _filteredPrograms = [];
  String _searchKeyword = '';
  String _selectedCategory = 'All';

  // Excelerate Brand Gradient (Orange to Magenta)
  final LinearGradient _brandGradient = const LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFE91E63)], // Orange to Pink/Magenta
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  final List<String> _categories = [
    'All',
    'Tech',
    'Database',
    'SQL',
    'Design',
    'Data',
    'Business',
    'Marketing',
    'Nature',
    'Economy',
    'Misc',
  ];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _applyFilters();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      _filteredPrograms = globalPrograms.where((program) {
        final matchesKeyword = program.title.toLowerCase().contains(
          _searchKeyword.toLowerCase(),
        );
        final programTags = program.tag
            .toLowerCase()
            .split(',')
            .map((e) => e.trim())
            .toList();
        final matchesCategory =
            _selectedCategory == 'All' ||
            programTags.contains(_selectedCategory.toLowerCase());

        return matchesKeyword && matchesCategory;
      }).toList();
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB), // Very clean, light background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFBFB),
        elevation: 0,

        title: ShaderMask(
          shaderCallback: (bounds) => _brandGradient.createShader(bounds),
          child: const Text(
            'Program List',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Colors.black87),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateProgramScreen(),
                  ),
                );
                if (result == true) {
                  _applyFilters();
                }
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Animated Search Bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  _searchKeyword = value;
                  _applyFilters();
                },
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search programs...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFFF6B35),
                  ), // Brand Orange
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFE91E63),
                      width: 1.5,
                    ), // Brand Pink
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _categories
                    .map((category) => _buildAnimatedFilterChip(category))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Find any programs you like',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: globalPrograms.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 60,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.isAdmin
                                ? 'No programs found.\nClick the "+" icon to add one.'
                                : 'No programs available right now.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : _filteredPrograms.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filteredPrograms.length,
                      itemBuilder: (context, index) {
                        // Staggered Animation Logic
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _animationController,
                                curve: Interval(
                                  (index / _filteredPrograms.length) * 0.5,
                                  1.0,
                                  curve: Curves.easeOutQuart,
                                ),
                              ),
                            );

                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, 50 * (1 - animation.value)),
                              child: Opacity(
                                opacity: animation.value,
                                child: child,
                              ),
                            );
                          },
                          child: _buildProgramCard(_filteredPrograms[index]),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No programs match your search.',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedFilterChip(String label) {
    final isSelected = _selectedCategory == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
          _applyFilters();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          // Applies gradient if selected, white if not
          gradient: isSelected ? _brandGradient : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFFFF6B35).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  IconData _getLocationIcon(String type) {
    if (type == 'Virtual') return Icons.videocam_outlined;
    if (type == 'Hybrid') return Icons.devices_outlined;
    return Icons.location_on_outlined;
  }

  Widget _buildProgramCard(Program program) {
    final dateText = program.endDate != null
        ? '${program.startDate} - ${program.endDate}'
        : '${program.startDate} at ${program.time}';

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening details for ${program.title}...'),
            backgroundColor: const Color(0xFFE91E63),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(
          bottom: 14,
        ), // Tighter vertical list spacing
        // 1. OUTLINE GRADIENT WRAPPER
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: _brandGradient, // The Brand Gradient Border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(1.5), // This acts as the border thickness
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              14.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: program.imageFile != null
                          ? Image.file(program.imageFile!, fit: BoxFit.cover)
                          : Image.network(
                              program.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                            ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.0),
                            Colors.black.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (bounds) =>
                                _brandGradient.createShader(bounds),
                            child: Text(
                              program.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                                height: 1.1,
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: program.isFree ? null : _brandGradient,
                            color: program.isFree ? Colors.green.shade50 : null,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: program.isFree
                                  ? Colors.green.shade200
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            program.isFree
                                ? 'FREE'
                                : '\$${program.fee.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: program.isFree
                                  ? Colors.green.shade700
                                  : Colors.white,
                              fontSize: 11, // Tighter badge text
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (program.speaker != null &&
                            program.speaker!.isNotEmpty)
                          Expanded(
                            child: Row(
                              children: [
                                const Text(
                                  '🧑‍💼',
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    program.speaker!,
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          const SizedBox(), // Empty space if no speaker
                        Row(
                          children: [
                            if (program.offersCertificate) ...[
                              const Icon(
                                Icons.workspace_premium,
                                size: 16,
                                color: Color(0xFFD4AF37),
                              ),
                              const SizedBox(width: 4),
                            ],
                            if (program.offersBadge)
                              const Icon(
                                Icons.shield,
                                size: 16,
                                color: Color(0xFF4169E1),
                              ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Left Side: Location Icon/Text, Bullet, Date Icon/Text
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                _getLocationIcon(program.locationType),
                                size: 11,
                                color: const Color(0xFFFF6B35),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                program.locationType,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '•',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 11,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  dateText,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              _brandGradient.createShader(bounds),
                          child: Text(
                            program.host,
                            style: const TextStyle(
                              color: Colors.white, // Mask requires white text
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
