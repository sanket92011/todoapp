import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/screens/auth/login_screen.dart';
import 'package:todoapp/screens/globals.dart';
import 'package:todoapp/widgets/custom_button.dart';
import 'package:todoapp/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> signUpUser() async {
      try {
        print('object');

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        final userName =
            await FirebaseFirestore.instance.collection('userName').add({
          'userName': nameController.text.trim(),
          'userUid': userUid,
        });
      } catch (e) {
        e.toString();
      }
    }

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
              hintText: "Name",
              controller: nameController,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              hintText: "Email",
              controller: emailController,
            ),
            const SizedBox(height: 30),
            CustomTextField(
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
                          builder: (context) => LoginScreen(),
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
            CustomButton(
              onTap: () {
                signUpUser();
              },
              text: "Sign-up",
            ),
            const Spacer(),
          ],
        ),
      )),
    );
  }
}
