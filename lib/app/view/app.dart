import 'package:bloc_todos/home/view/view.dart';
import 'package:bloc_todos/l10n/l10n.dart';
import 'package:bloc_todos/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repo/todos_repo.dart';

class App extends StatelessWidget {
  const App({required this.todosRepo, super.key});
  final TodosRepo todosRepo;

  @override
  Widget build(BuildContext context) {
    //provides the repository to all children
    return RepositoryProvider.value(
      value: todosRepo,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TodosTheme.light,
      darkTheme: TodosTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
