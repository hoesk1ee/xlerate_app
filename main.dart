import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscure = true;
  final nameController = TextEditingController(text: 'Budi');
  final dobController = TextEditingController(text: '24 June 2001');
  final emailController = TextEditingController(text: 'example@mail.com');
  final passwordController = TextEditingController(text: 'password');

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration _buildDecoration(String label, String hint, {Widget? suffix}) {
    return InputDecoration(
      labelText: label.isEmpty? null: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Color(0xFFB8C1CF), fontWeight: FontWeight.w600),
      hintStyle: const TextStyle(color: Color(0xFFB8C1CF), fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFB8C1CF), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFB8C1CF), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
      ),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [const SizedBox(height: 20),

              // Title
              const Text(
                "Register\nfor the best experience.",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF344054),
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 28),

              // Avatar
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE6EAF0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 34, color: Color(0xFF9AA5B5)),
                ),
              ),

              const SizedBox(height: 30),

              // Name
              const Text("Name", style: TextStyle(color: Color(0xFFC1CAD8), fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                controller: nameController,
                decoration: _buildDecoration("", "Your name"),
              ),

              const SizedBox(height: 14),

              // Birth of Date
              const Text("Birth of Date", style: TextStyle(color: Color(0xFFC1CAD8), fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                controller: dobController,
                decoration: _buildDecoration("", "DD Month YYYY",
                    suffix: const Icon(Icons.calendar_month_outlined, color: Color(0xFFAAB3C2))),
              ),

              const SizedBox(height: 14),

              // Email
              const Text("Email", style: TextStyle(color: Color(0xFFC1CAD8), fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                controller: emailController,
                decoration: _buildDecoration("", "email@example.com"),
              ),

              const SizedBox(height: 14),

              // Password
              const Text("Password", style: TextStyle(color: Color(0xFFC1CAD8), fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                controller: passwordController,
                obscureText: obscure,
                decoration: _buildDecoration("", "Enter password",
                  suffix: IconButton(
                    icon: Icon(
                      obscure? Icons.visibility_off_outlined: Icons.visibility_outlined,
                      color: const Color(0xFFAAB3C2),
                    ),
                    onPressed: () => setState(() => obscure =!obscure),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Note
              const Text(
                "*and others if needed.\nbased on database design later",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFC5CFDB),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 14),

              // Register button
              SizedBox(
                height: 62,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F63F6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                    shadowColor: const Color(0xFF6F63F6),
                  ),
                  child: const Text(
                    "Register Now",
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Login link
              Center(
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 18, color: Color(0xFF374151)),
                      children:  [TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Login here",
                        style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w500),
                      )],
                  ),
                ),
              ),

              const SizedBox(height: 20)],
          ),
        ),
      ),
    );
  }
}