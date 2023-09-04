import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/sqlite_helper.dart';

class UpdatendDeleteTask extends StatefulWidget {
  final int id;
  final String originalTaskName;
  final String originalTaskDesc;
  const UpdatendDeleteTask({super.key,  required this.id, required this.originalTaskName, required this.originalTaskDesc});

  @override
  State<UpdatendDeleteTask> createState() => _UpdatendDeleteTaskState();
}

class _UpdatendDeleteTaskState extends State<UpdatendDeleteTask> {
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
  Future<void> updateTask(String taskName,String taskDesc) async{
    await SQLHelper.updateTask(widget.id, taskName, taskDesc);
    displayToastMessage('Task updated');
  }
  Future<void> deleteTask() async{
    await SQLHelper.deleteTask(widget.id);
    displayToastMessage('Task deleted');
  }
  @override
  Widget build(BuildContext context) {
    taskNameController.text =widget.originalTaskName;
    taskDescController.text = widget.originalTaskDesc;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Update Task', style: TextStyle(color: Colors.black)),
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
                          borderSide: BorderSide(color: Colors.black, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1)),
                      errorStyle: TextStyle(color: Colors.red,fontSize: 15)
                  ),
                  controller: taskNameController,
                  validator: (value){
                    if(value==null || value.isEmpty){
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
                          borderSide: BorderSide(color: Colors.black, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1)),
                      errorStyle: TextStyle(color: Colors.red,fontSize: 15)
                  ),
                  controller: taskDescController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter the task description';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: const EdgeInsets.all(8),
                  child:  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),onPressed: (){
                    setState(() {
                      taskName = taskNameController.text;
                      taskDesc = taskDescController.text;
                      updateTask(taskName, taskDesc);
                      clearText();
                    });
                  }, child: const Text('update Task')),),
                  Padding(padding: const EdgeInsets.all(8),
                  child:  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),onPressed: (){
                    setState(() {
                     deleteTask();
                      clearText();
                    });
                  }, child: const Text('delete Task')),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
