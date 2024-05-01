part of 'todos_bloc.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

//startup event. bloc subscribes to the stream of todos from the TodosRepo.
final class TodosSubscriptionReq extends TodosEvent {
  const TodosSubscriptionReq();
}

//deletes a 'Todo
class TodosDeleted extends TodosEvent {
  const TodosDeleted(this.todo);
  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

//undoes a `todo deletion
class TodosUndoDelReq extends TodosEvent {
  const TodosUndoDelReq();
}

//deletes all completed
class TodosClearCompletedReq extends TodosEvent {
  const TodosClearCompletedReq();
}

//toggles a `todo’s completed status.
final class TodosCompletionToggled extends TodosEvent {
  const TodosCompletionToggled({
    required this.todo,
    required this.isCompleted,
  });
  final Todo todo;
  final bool isCompleted;

  @override
  List<Object?> get props => [todo, isCompleted];
}

//toggles completion
class TodosToggleAllReq extends TodosEvent {
  const TodosToggleAllReq();
}

//changes the view by applying a filter
class TodosFilterChanged extends TodosEvent {
  const TodosFilterChanged(this.filter);
  final TodosFilter filter;
  @override
  List<Object?> get props => [filter];
}
