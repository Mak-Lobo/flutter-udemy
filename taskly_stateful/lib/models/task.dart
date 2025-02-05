class Task {
  String task;
  DateTime timeStamp;
  bool isDone;

  Task({
    required this.task,
    required this.timeStamp,
    required this.isDone,
  });

  Map toMapData () {
    return {
      'task': task,
      'timeStamp': timeStamp,
      'isDone': isDone,
    };
  }

  factory Task.fromMapData(Map taskData) {
    return Task(
      task: taskData['task'],
      timeStamp: taskData['timeStamp'],
      isDone: taskData['isDone'],
    );
  }
}