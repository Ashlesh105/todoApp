import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/sqlite_helper.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var taskName = "";
  var taskDesc = "";

  final taskNameController = TextEditingController();
  final taskDescController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    taskDescController.dispose();
    taskNameController.dispose();
  }

  clearText() {
    taskNameController.clear();
    taskDescController.clear();
  }

  displayToastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.amber);
    Navigator.pop(context);
  }

  //method to addTask
  Future<void> addNewTask(String taskName, String taskDesc) async {
    await SQLHelper.addNewTask(taskName, taskDesc);
    displayToastMessage('New task added..');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Add New Task', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.black,
                  autofocus: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      labelText: 'Task Name',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 15)),
                  controller: taskNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the task name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLines: 10,
                  cursorColor: Colors.black,
                  autofocus: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      labelText: 'Task Description',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 15)),
                  controller: taskDescController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the task description';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    setState(() {
                      taskName = taskNameController.text;
                      taskDesc = taskDescController.text;
                      addNewTask(taskName, taskDesc);
                      clearText();
                    });
                  },
                  child: const Text(
                    'Add Task',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
