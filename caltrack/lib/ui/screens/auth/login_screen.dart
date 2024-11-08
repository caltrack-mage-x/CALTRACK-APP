import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // For TapGestureRecognizer

import 'signin_screen.dart'; // Import the SignIn.dart file

class LoginSection extends StatelessWidget {
  const LoginSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFAB7DB),
              Color(0xFFFAFFD8),
            ],
          ),
        ),
        child: Stack(
          children: [
            const BackgroundImage(),
            const Positioned(
              top: 320,
              left: 130,
              child: HeaderSection(),
            ),
            const Positioned(
              top: 430, // Kolom email
              left: 50,
              child: EmailInput(),
            ),
            const Positioned(
              top: 480, // Posisi kolom password
              left: 50,
              child: PasswordInput(),
            ),
            const Positioned(
              top: 535, // Posisi untuk "Forgot Password"
              right: 50,
              child: ForgotPasswordText(),
            ),
            const Positioned(
              top: 580, // Posisi tombol Login
              left: 50,
              child: LoginButton(), // Menambahkan tombol Login
            ),
            const Positioned(
              top: 820, // Posisi untuk teks Sign In
              left: 0, // Align to center
              right: 0, // Align to center
              child: Center(
                child: SignInText(), // Menambahkan teks Sign In
              ),
            ),
            // Add other positioned widgets here as needed
          ],
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        'assets/LoginBackground.png',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'CalTrack',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Powered by Gemini™',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        ClipRect(
          child: Align(
            alignment: Alignment.centerRight,
            widthFactor: 0.7,
            child: Image.asset(
              'assets/Wortel.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFEA6175)),
      ),
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.email,
              color: Color(0xFFEA6175),
            ),
          ),
          Text(
            'Email',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFEA6175)),
      ),
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.lock,
              color: Color(0xFFEA6175),
            ),
          ),
          Text(
            'Password',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Forgot Password?',
      style: const TextStyle(
        color: Color(0xFF4F4F4F), // Mengubah warna menjadi #4F4F4F
        fontSize: 14, // Ukuran font untuk teks
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 48, // Ubah tinggi menjadi 48 agar sesuai dengan ukuran tombol
      decoration: BoxDecoration(
        color: const Color(0xFFED7486),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16, // Ukuran font untuk teks tombol
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SignInText extends StatelessWidget {
  const SignInText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Didn’t have an account? ',
        style: const TextStyle(
          color: Color(0xFF4F4F4F), // Warna teks #4F4F4F
          fontSize: 14, // Ukuran font untuk teks
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Sign in',
            style: const TextStyle(
              color: Color(0xFF4F4F4F), // Warna teks #4F4F4F
              fontSize: 14, // Ukuran font untuk teks
              fontWeight: FontWeight.bold, // Bold text for "Sign in"
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to the SignIn page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()), // Navigate to SignInPage
                );
              },
          ),
        ],
      ),
    );
  }
}
