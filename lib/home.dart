import 'dart:ui';

import 'package:final_proj_todo/function.dart';
import 'package:final_proj_todo/profile.dart';
import 'package:final_proj_todo/splash_screen.dart';
import 'package:final_proj_todo/task_management.dart';
import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final TaskProvider _taskProvider = TaskProvider();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _taskProvider.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask() async {
    final title = await _showTaskDialog(currentTitle: '1');
    if (title != null) {
      await _taskProvider.addTask(Task(title: title));
      _loadTasks();
    }
  }

  void _editTask(int index) async {
    final title = await _showTaskDialog(currentTitle: _tasks[index].title);
    if (title != null) {
      await _taskProvider.editTask(
          index, Task(title: title, isCompleted: _tasks[index].isCompleted));
      _loadTasks();
    }
  }

  Future<String?> _showTaskDialog({required String currentTitle}) async {
    String? title;
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[200],
          title: Text(currentTitle == "1" ? 'Add Task' : 'Edit Task'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
            decoration: const InputDecoration(hintText: 'Task Title'),
            controller: currentTitle == "1"
                ? null
                : TextEditingController(text: currentTitle),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(title);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) async {
    await _taskProvider.deleteTask(index);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 248, 248, 247)),
         actions: [
          Row(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: _addTask,
              ),
               IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  if (_tasks.isNotEmpty) {
                    _deleteTask(0);
                  }
                },
              ),],
              ),],
        title: const Text(
          "PROJECT MANAGEMENT MODULE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
        elevation: 10,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 248, 243, 243),
        child: ListView(
          children: [
            ListTile(
              title: const Text("Personal Details"),
              textColor: Colors.black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: const Text("Logout"),
              textColor: Colors.black,
              onTap: () {
                storingDatatoPreff(false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Splash_screen()),
                );
              },
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_tasks[index].title),
                onTap: () => _editTask(index),
              );
            },
          ),
        ],
      ),
    );
  }
  
  void storingDatatoPreff(bool bool) {}
}
