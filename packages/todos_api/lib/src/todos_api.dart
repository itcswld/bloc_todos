import 'package:todos_api/todos_api.dart';

/// {@template todos_api}
/// api providing access to todos
/// {@endtemplate}
/// [abstract class] provides its methods to be @override by other [class] which extends the [abstract class]
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  Future<void> saveTodo(Todo todo);

  //[Stream] real-time updates
  Stream<List<Todo>> getTodos();

  Future<void> delTodo(String id);

  Future<int> clearCompleted();

  Future<int> completeAll({required bool isCompleted});

  Future<void> close();
}

class TodoNotFoundException implements Exception {}
