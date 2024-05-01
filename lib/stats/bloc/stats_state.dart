part of 'stats_bloc.dart';

//keeps track of summary information and the current StatsStatus.
enum StatsStatus { init, loading, success, fail }

final class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.init,
    this.completedTodosAmount = 0,
    this.activeTodosAmount = 0,
  });
  final StatsStatus status;
  final int completedTodosAmount;
  final int activeTodosAmount;

  @override
  List<Object> get props => [status, completedTodosAmount, activeTodosAmount];

  StatsState copyWith({
    StatsStatus? status,
    int? completedTodosAmount,
    int? activeTodosAmount,
  }) =>
      StatsState(
        status: status ?? this.status,
        completedTodosAmount: completedTodosAmount ?? this.completedTodosAmount,
        activeTodosAmount: activeTodosAmount ?? this.activeTodosAmount,
      );
}
