import 'package:bloc_todos/l10n/l10n.dart';
import 'package:bloc_todos/todos/bloc/todos_bloc.dart';
import 'package:bloc_todos/todos/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*
todos_overview_filter_button.dart exposes three filter options:
    all
    activeOnly
    completedOnly
 */

class FilterBtn extends StatelessWidget {
  const FilterBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final filter = context.select((TodosBloc bloc) => bloc.state.filter);
    return PopupMenuButton(
      icon: const Icon(Icons.filter_list_rounded),
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      initialValue: filter,
      tooltip: l10n.filterBtnTooltip,
      onSelected: (v) {
        context.read<TodosBloc>().add(TodosFilterChanged(v));
      },
      itemBuilder: (_) {
        return [
          PopupMenuItem(value: TodosFilter.all, child: Text(l10n.todosFilterAll)),
          PopupMenuItem(value: TodosFilter.activeOnly, child: Text(l10n.todosFilterActiveOnly)),
          PopupMenuItem(value: TodosFilter.completedOnly, child: Text(l10n.todosFilterCompletedOnly)),
        ];
      },
    );
  }
}
