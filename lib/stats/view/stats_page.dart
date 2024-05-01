import 'package:bloc_todos/l10n/l10n.dart';
import 'package:bloc_todos/stats/bloc/stats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repo/todos_repo.dart';

/*
├── StatsPage
│   └── BlocProvider<StatsBloc>
│       └── StatsView
│           ├── context.watch<StatsBloc>
│           └── Column
 */
class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StatsBloc(
        todosRepo: context.read<TodosRepo>(),
      )..add(const StatsSubscriptionReq()),
      child: const StatsView(),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<StatsBloc>().state;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statsViewAppBarTitle),
      ),
      body: Column(
        children: [
          ListTile(
            key: const Key('statsView_completedTodos_ListTile'),
            leading: const Icon(Icons.check_rounded),
            title: Text(l10n.statsViewCompletedTodoListTileTitle),
            trailing: Text(
              '${state.completedTodosAmount}',
              style: textTheme.headlineSmall,
            ),
          ),
          ListTile(
            key: const Key('statsView_activeTodos_ListTile'),
            leading: const Icon(Icons.radio_button_unchecked_rounded),
            title: Text(l10n.statsViewActiveTodoListTileTitle),
            trailing: Text(
              '${state.activeTodosAmount}',
              style: textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
