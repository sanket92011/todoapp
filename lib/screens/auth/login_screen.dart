import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/screens/auth/sign_up_screen.dart';
import 'package:todoapp/widgets/custom_button.dart';
import 'package:todoapp/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text(
            e
                .toString()
                .replaceFirst('[firebase_auth/email-already-in-use]', '')
                .replaceFirst('[firebase_auth/invalid-email]', '')
                .replaceFirst(
                    '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired',
                    'Email or Password is incorrect'),
          ),
          actions: [
            TextButton(
              child: const Text("Dismiss"),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Text(
                  "TaskTide",
                  style: GoogleFonts.aboreto(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                isLoading ? "Logging in..." : "Login",
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                showText: true,
                hintText: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                showText: false,
                hintText: "Password",
                controller: passwordController,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                    child: Text(
                      "  Sign up",
                      style: GoogleFonts.montserrat(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      onTap: () {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter email and password"),
                            ),
                          );
                        }
                        isLoading ? null : loginUser();
                      },
                      // Disable button when loading
                      text: "Login",
                    ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
