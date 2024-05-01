//Domain layer -- handles `todo` related requests
//helps abstract data acquisition from the rest of the application,
//to change where/how data is being stored
// without affecting other parts of the app.

export 'package:todos_api/todos_api.dart' show Todo;

export 'src/todos_repo.dart';
