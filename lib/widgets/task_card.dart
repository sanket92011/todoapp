import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/widgets/custom_button.dart';
import 'package:todoapp/widgets/task_text_fields.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskTitle,
    required this.taskDescription,
    required this.createdOn,
    required this.id,
  });

  final String taskTitle;
  final String taskDescription;
  final String createdOn;
  final DocumentSnapshot id;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    TextEditingController editingTaskController =
        TextEditingController(text: widget.taskTitle);
    TextEditingController editingDescriptionController =
        TextEditingController(text: widget.taskDescription);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Dismissible(
        key: Key(widget.id.id),
        onDismissed: (direction) async {
          if (direction == DismissDirection.endToStart ||
              direction == DismissDirection.startToEnd) {
            await FirebaseFirestore.instance
                .collection('todo')
                .doc(widget.id.id)
                .delete();
            setState(() {});
          }
        },
        child: Card(
          color: const Color(0XFFf1e48a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Task:               ",
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.taskTitle,
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          showModalBottomSheet(
                            enableDrag: true,
                            showDragHandle: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            scrollControlDisabledMaxHeightRatio: 0.7,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(
                                          "Edit Task",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(height: 20),
                                        TaskTextFields(
                                          controller: editingTaskController,
                                          icon: Icons.task,
                                          hintText: "Update Task",
                                        ),
                                        const SizedBox(height: 20),
                                        TaskTextFields(
                                          controller:
                                              editingDescriptionController,
                                          icon: Icons.task,
                                          hintText: "Update Description",
                                        ),
                                        const Spacer(),
                                        CustomButton(
                                          text: 'Update',
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('todo')
                                                .doc(widget.id.id)
                                                .update({
                                              'task': editingTaskController.text
                                                  .trim(),
                                              'description':
                                                  editingDescriptionController
                                                      .text
                                                      .trim()
                                            });
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Description:  ",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.taskDescription,
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.createdOn,
                    style: GoogleFonts.montserrat(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
