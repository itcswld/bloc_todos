import 'package:bloc/bloc.dart';
import 'package:bloc_todos/todos/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repo/todos_repo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required TodosRepo todosRepo})
      : _todosRepo = todosRepo,
        super(const TodosState()) {
    on<TodosSubscriptionReq>(_onSubscriptionReq);
    on<TodosDeleted>(_onDeleted);
    on<TodosUndoDelReq>(_onUndoDelReq);
    on<TodosClearCompletedReq>(_onClearCompletedReq);
    on<TodosCompletionToggled>(_onCompletionToggled);
    on<TodosToggleAllReq>(_onTodosToggleAllReq);
    on<TodosFilterChanged>(_onFilterChanged);
  }
  final TodosRepo _todosRepo;

  Future<void> _onSubscriptionReq(
    TodosSubscriptionReq event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: () => TodosStatus.loading));
    //creates a subscription on the todos stream from the TodosRepos
    await emit.forEach(
      _todosRepo.getTodos(),
      onData: (todos) => state.copyWith(
        status: () => TodosStatus.success,
        todos: () => todos,
      ),
      onError: (_, __) => state.copyWith(status: () => TodosStatus.fail),
    );
  }

  Future<void> _onDeleted(TodosDeleted event, Emitter<TodosState> emit) async {
    emit(state.copyWith(lastDelTodo: () => event.todo));
    await _todosRepo.delTodo(event.todo.id);
  }

  Future<void> _onUndoDelReq(
    TodosUndoDelReq event,
    Emitter<TodosState> emit,
  ) async {
    assert(state.lastDelTodo != null, 'Last deleted todo cant be null.');
    final todo = state.lastDelTodo!;
    emit(state.copyWith(lastDelTodo: () => null));
    await _todosRepo.saveTodo(todo);
  }

  Future<void> _onClearCompletedReq(
    TodosClearCompletedReq event,
    Emitter<TodosState> emit,
  ) async {
    await _todosRepo.clearCompleted();
  }

  Future<void> _onCompletionToggled(
    TodosCompletionToggled event,
    Emitter<TodosState> emit,
  ) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _todosRepo.saveTodo(newTodo);
  }

  Future<void> _onTodosToggleAllReq(
    TodosToggleAllReq event,
    Emitter<TodosState> emit,
  ) async {
    final completed = state.todos.every((e) => e.isCompleted);
    await _todosRepo.completeAll(isCompleted: !completed);
  }

  Future<void> _onFilterChanged(
    TodosFilterChanged event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }
}
