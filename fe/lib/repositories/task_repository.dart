import 'package:addio_celibato/models/task.dart';
import 'package:addio_celibato/models/task_create.dart';

import '../models/tasks.dart';
import '../network/rest_client.dart';

class TaskRepository {
  final RestClient restClient;

  TaskRepository({required this.restClient});

  Future<TasksDto> getAll() => restClient.getAllTasks();

  Future<TaskDto> sendTask(int id) => restClient.sendTask(id);

  Future<int> save(TaskCreateDto taskDto) => restClient.saveTask(taskDto);
}
