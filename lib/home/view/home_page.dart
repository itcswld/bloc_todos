import 'package:bloc_todos/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../edit/view/view.dart';
import '../../stats/view/view.dart';
import '../../todos/view/view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //BlocProvider<HomeCubit>
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //context.select<HomeCubit, HomeTab>
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [TodosPage(), StatsPage()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('add'),
        onPressed: () => Navigator.of(context).push(EditPage.route()),
        child: const Icon(Icons.add),
      ),
      //HomeTabButton(s)
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //context.read<HomeCubit>
            _TabIconBtn(
              selectedTab: selectedTab,
              tab: HomeTab.todos,
              icon: const Icon(Icons.list_rounded),
            ),
            _TabIconBtn(
              selectedTab: selectedTab,
              tab: HomeTab.stats,
              icon: const Icon(Icons.show_chart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabIconBtn extends StatelessWidget {
  const _TabIconBtn({
    required this.selectedTab,
    required this.tab,
    required this.icon,
  });

  final HomeTab selectedTab;
  final HomeTab tab;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(tab),
      color: selectedTab != tab ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
      iconSize: 32,
    );
  }
}
