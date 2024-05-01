import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get counterAppBarTitle => 'Flutter Todos';

  @override
  String get todosViewAppBarTitle => 'Flutter Todos';

  @override
  String get todosViewErrSnackBar => 'Error';

  @override
  String todosViewTodoDelSnackBarTxt(Object todoTitle) {
    return 'Todo \"$todoTitle\" deleted.';
  }

  @override
  String get todosOverviewEmptyText => 'No todos found with the selected filters.';

  @override
  String get todosOverviewOptionsTooltip => 'Options';

  @override
  String get todoViewUndoDelButtonLabel => 'Undo';

  @override
  String get todosOptionsMarkAllComplete => 'Mark all as completed';

  @override
  String get todosOptionsMarkAllIncomplete => 'Mark all as incomplete';

  @override
  String get todosOptionsClearCompleted => 'Clear completed';

  @override
  String get filterBtnTooltip => 'Filter';

  @override
  String get todosFilterAll => 'All';

  @override
  String get todosFilterActiveOnly => 'Active only';

  @override
  String get todosFilterCompletedOnly => 'Completed only';

  @override
  String get statsViewAppBarTitle => 'Stats';

  @override
  String get statsViewCompletedTodoListTileTitle => 'Completed todos';

  @override
  String get statsViewActiveTodoListTileTitle => 'Active todos';

  @override
  String get editViewAppBarTitleEdit => 'Edit Todo';

  @override
  String get editViewAppBarTitleAdd => 'Add Todo';

  @override
  String get editTodoSaveButtonTooltip => 'Save changes';

  @override
  String get editViewTitleLabel => 'Title';

  @override
  String get editViewDescLabel => 'Description';
}
