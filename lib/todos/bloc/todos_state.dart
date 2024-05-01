part of 'todos_bloc.dart';

enum TodosStatus { init, loading, success, fail }

class TodosState extends Equatable {
  const TodosState({
    this.status = TodosStatus.init,
    this.todos = const [],
    this.filter = TodosFilter.all,
    this.lastDelTodo,
  });

  final TodosStatus status;
  final List<Todo> todos;
  final TodosFilter filter;
  final Todo? lastDelTodo;

  Iterable<Todo> get filteredTodos => filter.applyAll(todos);

  TodosState copyWith({
    TodosStatus Function()? status,
    List<Todo> Function()? todos,
    TodosFilter Function()? filter,
    Todo? Function()? lastDelTodo,
  }) =>
      TodosState(
        status: status != null ? status() : this.status,
        todos: todos != null ? todos() : this.todos,
        filter: filter != null ? filter() : this.filter,
        lastDelTodo: lastDelTodo != null ? lastDelTodo() : this.lastDelTodo,
      );

  @override
  List<Object?> get props => [status, todos, filter, lastDelTodo];
}
