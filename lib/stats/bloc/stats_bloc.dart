import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repo/todos_repo.dart';

part 'stats_event.dart';
part 'stats_state.dart';

//displays statistics about the active and completed todos.

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({
    required TodosRepo todosRepo,
  })  : _todosRepo = todosRepo,
        super(const StatsState()) {
    on<StatsSubscriptionReq>(_onStatsSubscriptionReq);
  }
  final TodosRepo _todosRepo;

  Future<void> _onStatsSubscriptionReq(
    StatsSubscriptionReq event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));

    emit.forEach<List<Todo>>(
      _todosRepo.getTodos(),
      onData: (todos) => state.copyWith(
        status: StatsStatus.success,
        completedTodosAmount: todos.where((e) => e.isCompleted).length,
        activeTodosAmount: todos.where((e) => !e.isCompleted).length,
      ),
      onError: (_, __) => state.copyWith(status: StatsStatus.fail),
    );
  }
}
