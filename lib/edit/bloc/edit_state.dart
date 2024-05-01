part of 'edit_bloc.dart';

enum EditStatus { init, loading, success, fail }

extension IsLoadingOrSuccess on EditStatus {
  bool get isLoadingOrSuccess => [
        EditStatus.loading,
        EditStatus.success,
      ].contains(this);
}

final class EditState extends Equatable {
  const EditState({
    this.status = EditStatus.init,
    this.initTodo,
    this.title = '',
    this.desc = '',
  });

  final EditStatus status;
  final Todo? initTodo;
  final String title;
  final String desc;

  bool get isNewTodo => initTodo == null;

  EditState copyWith({
    EditStatus? status,
    Todo? initTodo,
    String? title,
    String? desc,
  }) =>
      EditState(
        status: status ?? this.status,
        initTodo: initTodo ?? this.initTodo,
        title: title ?? this.title,
        desc: desc ?? this.desc,
      );

  @override
  List<Object?> get props => [status, initTodo, title, desc];
}
