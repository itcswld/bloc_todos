//data layer
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_api/todos_api.dart';

/// {@template local_storage}
/// implements of the TodosApi
/// {@endtemplate}
class LocalStorage extends TodosApi {
  /// {@macro local_storage}
  LocalStorage({
    required SharedPreferences pref,
  }) : _pref = pref {
    _init();
  }
  //simple data storage
  final SharedPreferences _pref;
  //real-time updates
  final _streamCtrl = BehaviorSubject<List<Todo>>.seeded(const []);

  ///for storing the todos locally
  @visibleForTesting
  static const kCollectionKey = '_collection_key_';
  String? _getVal(String key) => _pref.getString(kCollectionKey);
  Future<void> _setVal(String key, String value) => _pref.setString(key, value);

  void _init() {
    final todosJson = _getVal(kCollectionKey);
    if (todosJson != null) {
      final todos = List<Map<dynamic, dynamic>>.from(json.decode(todosJson) as List)
          .map((e) => Todo.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      _streamCtrl.add(todos);
    } else {
      _streamCtrl.add(const []);
    }
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = [..._streamCtrl.value];
    final i = todos.indexWhere((e) => e.id == todo.id);
    //if id already exists, it will be replaced.
    if (i >= 0) {
      todos[i] = todo;
    } else {
      todos.add(todo);
    }
    //upd
    _streamCtrl.add(todos);
    //save
    await _setVal(kCollectionKey, json.encode(todos));
  }

  //[Stream] subscribe
  @override
  Stream<List<Todo>> getTodos() => _streamCtrl.asBroadcastStream();

  @override
  Future<void> delTodo(String id) async {
    final todos = [..._streamCtrl.value];
    final i = todos.indexWhere((e) => e.id == id);
    if (i == -1) {
      throw TodoNotFoundException();
    } else {
      todos.removeAt(i);
      //upd
      _streamCtrl.add(todos);
      await _setVal(kCollectionKey, json.encode(todos));
    }
  }

  @override
  Future<int> clearCompleted() async {
    final todos = [..._streamCtrl.value];
    final completedAmount = todos.where((e) => e.isCompleted).length;
    todos.removeWhere((e) => e.isCompleted);
    //upd
    _streamCtrl.add(todos);
    await _setVal(kCollectionKey, json.encode(todos));
    return completedAmount;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final todos = [..._streamCtrl.value];
    final undoneAmount = todos.where((e) => e.isCompleted != isCompleted).length;
    final newTodos = [
      for (final todo in todos) todo.copyWith(isCompleted: isCompleted),
    ];
    _streamCtrl.add(newTodos);
    await _setVal(kCollectionKey, json.encode(newTodos));
    return undoneAmount;
  }

  @override
  Future<void> close() {
    return _streamCtrl.close();
  }
}
