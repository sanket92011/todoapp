import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/widgets/task_text_fields.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});

  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var currentDate = DateTime.now();

  Widget build(BuildContext context) {
    Future<void> sendTask() async {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('todo').add({
        'task': taskController.text.trim(),
        'userUid': userUid,
        'time': currentDate.day,
        'month': currentDate.month,
        'year': currentDate.year,
        'description': descriptionController.text.trim(),
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (taskController.text.isEmpty) {
            ScaffoldMessenger.maybeOf(context)!.showSnackBar(
              const SnackBar(
                content: Text("Task cannot be empty"),
              ),
            );
          } else {
            sendTask();
            Navigator.pop(context);
            ScaffoldMessenger.maybeOf(context)!.showSnackBar(
              const SnackBar(
                content: Text("Task Added"),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add new Task",
              style: GoogleFonts.montserrat(
                  fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            TaskTextFields(
              controller: taskController,
              icon: Icons.task,
              hintText: 'Task here',
            ),
            const SizedBox(height: 30),
            TaskTextFields(
              controller: descriptionController,
              icon: Icons.description,
              hintText: 'Description here',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
