import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/screens/globals.dart';
import 'package:todoapp/screens/task_pages/add_task.dart';
import 'package:todoapp/widgets/task_card.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  var id;
  var name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks",
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTask(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('todo')
                    .where('userUid', isEqualTo: userUid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return const Text("No task");
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        {
                          final String task =
                              snapshot.data!.docs[index].data()['task'] ?? "";
                          final taskDescription = snapshot.data!.docs[index]
                                  .data()['description'] ??
                              "";
                          name = snapshot.data!.docs[index].data()['userName'];
                          print(name);
                          final createdOn =
                              snapshot.data!.docs[index].data()['time'] ?? "";
                          final month =
                              snapshot.data!.docs[index].data()['month'] ?? "";
                          final year =
                              snapshot.data!.docs[index].data()['year'] ?? "";
                          id = snapshot.data!.docs[index];
                          return TaskCard(
                            taskTitle: task,
                            taskDescription: taskDescription.isEmpty
                                ? "__"
                                : taskDescription,
                            createdOn: "$createdOn/$month/$year",
                            id: id,
                          );
                        }
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
