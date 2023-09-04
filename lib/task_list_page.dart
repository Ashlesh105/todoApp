import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/sqlite_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login/update_task.dart';

import 'package:login/add_new_task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Map<String,dynamic>> allTasks = [];
  bool isLoading = true;

  void refreshTasks() async {
    final data = await SQLHelper.getAllTasks();
    setState(() {
      allTasks = data;
      isLoading = false; // Check if Tasks is empty here
    });
    setState(() {
      if(allTasks.isEmpty) isLoading =true;
    });
  }


  @override
  void initState() {
    refreshTasks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('To do App',style: TextStyle(color: Colors.black,fontSize: 33,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black,onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddNewTask()));
      },child: const Icon(Icons.add),
      ),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(),
      ):ListView.builder(itemCount: allTasks.length, itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdatendDeleteTask(originalTaskName: allTasks[index]['taskName'], originalTaskDesc: allTasks[index]['taskDesc'], id: allTasks[index]['id'])));

          },
          child: TaskCard(taskName: allTasks[index]['taskName'], taskDesc: allTasks[index]['taskDesc'], id: allTasks[index]['id']),
        );
      },)
    );
  }
}

class TaskCard extends StatefulWidget {
  final String taskName, taskDesc;
  final int id;
  const TaskCard({super.key, required this.taskName, required this.taskDesc, required this.id});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  displayToastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.amber);
    Navigator.pop(context);
  }

  Future<void> deleteTask(int id) async{
    await SQLHelper.deleteTask(id);
    displayToastMessage('You deleted a task');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 0,
        color: Colors.black,
        child: Slidable(actionPane:  const SlidableDrawerActionPane(),
        secondaryActions: [
           IconSlideAction(caption: 'Delete',
           color: Colors.redAccent,
           icon: Icons.delete,
           onTap: (){
             setState(() {
               deleteTask(widget.id);
             });
           },)
        ], child: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.all(8),
                child: Text(widget.taskName,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),),
                const SizedBox(
                  height: 6,
                ),
                Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Text(widget.taskDesc,style: const TextStyle(fontSize: 12,color: Colors.white),),)
              ],
            ),
          ),),
      ),
    );
  }
}
