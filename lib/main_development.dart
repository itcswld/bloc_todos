import 'package:bloc_todos/bootstrap.dart';
import 'package:flutter/widgets.dart';
import 'package:local_storage/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todoApi = LocalStorage(pref: await SharedPreferences.getInstance());

  await bootstrap(api: todoApi);
}
