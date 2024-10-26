import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/screens/auth/sign_up_screen.dart';
import 'package:todoapp/widgets/custom_button.dart';
import 'package:todoapp/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    Future<void> loginUser() async {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
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
              isLoading == true ? "Logging in...." : "Login",
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
            CustomButton(
              onTap: () {
                loginUser();
              },
              text: "Login",
            ),
            const Spacer(),
          ],
        ),
      )),
    );
  }
}
