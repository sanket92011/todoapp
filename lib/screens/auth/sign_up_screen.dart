import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/screens/auth/login_screen.dart';
import 'package:todoapp/screens/task_pages/task_page.dart';
import 'package:todoapp/widgets/custom_button.dart';
import 'package:todoapp/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  Future<void> signUpUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final userUid = userCredential.user?.uid;

      await FirebaseFirestore.instance.collection('userName').add({
        'userName': nameController.text.trim(),
        'userUid': userUid,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TaskPage(),
        ),
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
                "Sign up",
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                showText: true,
                hintText: "Name",
                controller: nameController,
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
                    "Already have an account?",
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                    child: Text(
                      "  Login",
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
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: const Text("Please fill in all fields."),
                              actions: [
                                TextButton(
                                  child: const Text("Dismiss"),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          signUpUser();
                        }
                      },
                      text: "Sign-up",
                    ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
