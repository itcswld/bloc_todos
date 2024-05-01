import 'package:todos_api/todos_api.dart';

/// {@template todos_repo}
// handles `todo` related requests
/// {@endtemplate}
class TodosRepo {
  /// {@macro todos_repo}
  const TodosRepo({required TodosApi api}) : _api = api;

  final TodosApi _api;

  //provides a [Stream] of all todos
  Stream<List<Todo>> getTodos() => _api.getTodos();
  Future<void> saveTodo(Todo todo) => _api.saveTodo(todo);
  Future<void> delTodo(String id) => _api.delTodo(id);
  Future<int> clearCompleted() => _api.clearCompleted();
  Future<int> completeAll({required bool isCompleted}) => _api.completeAll(
        isCompleted: isCompleted,
      );
}
