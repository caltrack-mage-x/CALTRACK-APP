import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import for TapGestureRecognizer
import 'login_screen.dart'; // Import your login_screen.dart file

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFAFFD8), // Left color
              Color(0xFFCDDBB5), // Right color
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Sign-in',
                  style: TextStyle(
                    fontSize: 46, // Font size for Sign-in
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                // Circle with specified width and height
                Center(
                  child: Container(
                    width: 100, // Set width
                    height: 100, // Set height
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.green[700],
                        size: 60, // Set icon size
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildInputField(icon: Icons.person, hintText: 'Username'),
                const SizedBox(height: 16),
                _buildInputField(icon: Icons.email, hintText: 'Email'),
                const SizedBox(height: 16),
                _buildInputField(icon: Icons.lock, hintText: 'Password', isPassword: true),
                const SizedBox(height: 16),
                _buildInputField(icon: Icons.lock, hintText: 'Confirm password', isPassword: true),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Create account',
                      style: TextStyle(color: Colors.white), // Set text color to white
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32), // Set button border radius
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(color: Colors.black54),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to the login section
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginSection()), // Replace with your actual login widget
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF46704B), // Outline color
          width: 2, // Outline width
        ),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green[700]),
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
