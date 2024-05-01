part of 'edit_bloc.dart';

/*
EditTitleChanged
EditDescChanged
EditSubmitted
*/

sealed class EditEvent extends Equatable {
  const EditEvent();
  @override
  List<Object?> get props => [];
}

final class EditTitleChanged extends EditEvent {
  const EditTitleChanged(this.title);
  final String title;

  @override
  List<Object> get props => [title];
}

final class EditDescChanged extends EditEvent {
  const EditDescChanged(this.desc);
  final String desc;
  @override
  List<Object> get props => [desc];
}

final class EditSubmitted extends EditEvent {
  const EditSubmitted();
}
