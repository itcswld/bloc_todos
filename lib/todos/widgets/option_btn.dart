import 'package:bloc_todos/l10n/l10n.dart';
import 'package:bloc_todos/todos/bloc/todos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
 exposes two options for manipulating todos
    toggleAll
    clearCompleted
 */
@visibleForTesting
enum TodosOptions { toggleAll, clearCompleted }

class OptionsBtn extends StatelessWidget {
  const OptionsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final todos = context.select((TodosBloc bloc) => bloc.state.todos);
    final hasTodos = todos.isNotEmpty;
    final completedTodosAmount = todos.where((e) => e.isCompleted).length;

    return PopupMenuButton<TodosOptions>(
      icon: const Icon(Icons.more_vert_rounded),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: l10n.todosOverviewOptionsTooltip,
      onSelected: (v) {
        switch (v) {
          case TodosOptions.toggleAll:
            context.read<TodosBloc>().add(const TodosToggleAllReq());
          case TodosOptions.clearCompleted:
            context.read<TodosBloc>().add(const TodosClearCompletedReq());
        }
      },
      itemBuilder: (_) {
        return [
          PopupMenuItem(
            value: TodosOptions.toggleAll,
            enabled: hasTodos,
            child: Text(completedTodosAmount == todos.length
                ? l10n.todosOptionsMarkAllIncomplete
                : l10n.todosOptionsMarkAllComplete),
          ),
          PopupMenuItem(
            value: TodosOptions.clearCompleted,
            enabled: hasTodos && completedTodosAmount > 0,
            child: Text(l10n.todosOptionsClearCompleted),
          ),
        ];
      },
    );
  }
}
