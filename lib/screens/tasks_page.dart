import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/tasks.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String? content;
  Box? _box;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("My Tasks", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _tasksWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2D3142),
        onPressed: _displayTaskPop,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _tasksWidget() {
    return FutureBuilder(
      future: Hive.openBox("tasks"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _box = snapshot.data;
          List tasks = _box!.values.toList();
          return tasks.isEmpty ? const Center(child: Text("No tasks yet!")) : _todoList(tasks);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _todoList(List tasks) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = Task.fromMap(tasks[index]);
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: ListTile(
            title: Text(task.todo, style: TextStyle(decoration: task.done ? TextDecoration.lineThrough : null)),
            trailing: Checkbox(
              value: task.done,
              activeColor: const Color(0xFF6CBE7C),
              onChanged: (val) {
                task.done = val!;
                _box!.putAt(index, task.toMap());
                setState(() {});
              },
            ),
            onLongPress: () {
              _box!.deleteAt(index);
              setState(() {});
            },
          ),
        );
      },
    );
  }

  void _displayTaskPop() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Task"),
        content: TextField(onChanged: (val) => content = val),
        actions: [
          TextButton(
            onPressed: () {
              if (content != null && content!.isNotEmpty) {
                _box!.add(Task(todo: content!, timeStamp: DateTime.now(), done: false).toMap());
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}