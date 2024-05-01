import 'package:todos_repo/todos_repo.dart';

enum TodosFilter { all, activeOnly, completedOnly }

extension TodosFilterX on TodosFilter {
  bool apply(Todo todo) {
    switch (this) {
      case TodosFilter.all:
        return true;
      case TodosFilter.activeOnly:
        return !todo.isCompleted;
      case TodosFilter.completedOnly:
        return todo.isCompleted;
    }
  }

  //分页，可以确保只有适合用户屏幕渲染时，才执行对应逻辑去加载数据
  //where = sql's in
  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}
