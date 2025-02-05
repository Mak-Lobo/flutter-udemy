import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly_stateful/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _width, _height;
  String? _newTask;
  Box? _taskBox;
  late List tasks;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _height * 0.1,
        title: const Text(
          'Taskly!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  // tasks list
  Widget _tasks() {
    tasks = _taskBox!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var _task = Task.fromMapData(tasks[_index]);
        return ListTile(
          title: Text(
            _task.task,
            style: TextStyle(
              decoration: _task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text(_task.timeStamp.toString()),
          trailing: _task.isDone
              ? const Icon(
                  Icons.check_box_outlined,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.red,
                ),
          onTap: () {
            _task.isDone = !_task.isDone;
            _taskBox!.putAt(_index, _task.toMapData());
            setState(() {});
          },
          onLongPress: () {
            _taskBox!.deleteAt(_index);
            setState(() {});
          },
        );
      },
    );
  }

  // viewing the tasks
  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('taskly'),
      builder: (BuildContext context, AsyncSnapshot<Box> _snapshot) {
        if (_snapshot.hasData) {
          _taskBox = _snapshot.data;
          if (_taskBox!.values.isNotEmpty) {
            return _tasks();
          } else {
            return const Center(
              child: Text('No tasks available.'),
            );
          }
        } else {
          return const Center(
            child: Text('Error opening tasks.'),
          );
        }
      },
    );
  }

  // add task button
  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _taskPopup,
      child: const Icon(Icons.add),
    );
  }

  void _taskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            decoration: const InputDecoration(
              hintText: 'Enter new task',
            ),
            onChanged: (_taskEntry) {
              setState(() {
                _newTask = _taskEntry;
                print('Input value: $_taskEntry');
              });
            },
            onSubmitted: (_taskEntry) {
              if (_taskEntry.isNotEmpty) {
                var _inputTask = Task(
                  task: _taskEntry,
                  timeStamp: DateTime.now(),
                  isDone: false,
                );
                _taskBox!.add(_inputTask.toMapData());
                setState(() {
                  _newTask = null;
                  Navigator.pop(_context);
                });
              }
            },
          ),
        );
      },
    );
  }
}
