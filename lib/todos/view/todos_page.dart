import 'package:bloc_todos/l10n/l10n.dart';
import 'package:bloc_todos/todos/bloc/todos_bloc.dart';
import 'package:bloc_todos/todos/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repo/todos_repo.dart';

import '../../edit/view/view.dart';

/*
├── TodosPage
│   └── BlocProvider<TodosBloc>
│       └── TodosView
│           ├── BlocListener<TodosBloc>
│           └── BlocListener<TodosBloc>
│               └── BlocBuilder<TodosBloc>
│                   └── ListView
 */
class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(todosRepo: context.read<TodosRepo>())
        ..add(
          const TodosSubscriptionReq(),
        ),
      child: const TodosView(),
    );
  }
}

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todosViewAppBarTitle),
        //dropdowns for filtering and manipulating
        actions: const [
          FilterBtn(),
          OptionsBtn(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          //listens for errors--TodosStatus.fail
          BlocListener<TodosBloc, TodosState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status == TodosStatus.fail) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(l10n.todosViewErrSnackBar)),
                  );
              }
            },
          ),
          //listens for deletions --lastDelTodo
          BlocListener<TodosBloc, TodosState>(
            listenWhen: (previous, current) =>
                previous.lastDelTodo != current.lastDelTodo && current.lastDelTodo != null,
            listener: (context, state) {
              final lastDelTodo = state.lastDelTodo;
              final msg = ScaffoldMessenger.of(context);
              msg
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      l10n.todosViewTodoDelSnackBarTxt(lastDelTodo!.title),
                    ),
                    action: SnackBarAction(
                      label: l10n.todoViewUndoDelButtonLabel,
                      onPressed: () {
                        msg.hideCurrentSnackBar();
                        context.read<TodosBloc>().add(const TodosUndoDelReq());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodosStatus.loading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state.status == TodosStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }
            return CupertinoScrollbar(
                child: ListView(
              children: state.filteredTodos
                  .map((e) => TodoListTile(
                        todo: e,
                        onToggleCompleted: (isCompleted) {
                          context.read<TodosBloc>().add(
                                TodosCompletionToggled(todo: e, isCompleted: isCompleted),
                              );
                        },
                        onDismissed: (_) {
                          context.read<TodosBloc>().add(TodosDeleted(e));
                        },
                        onTap: () => Navigator.of(context).push(EditPage.route(initTodo: e)),
                      ))
                  .toList(),
            ));
          },
        ),
      ),
    );
  }
}
