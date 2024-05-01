import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repo/todos_repo.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc({
    required TodosRepo todosRepo,
    required Todo? initTodo,
  })  : _todosRepo = todosRepo,
        super(EditState(
          initTodo: initTodo,
          title: initTodo?.title ?? '',
          desc: initTodo?.desc ?? '',
        )) {
    //Event
    on<EditTitleChanged>(_onEditTitleChanged);
    on<EditDescChanged>(_onEditDescChanged);
    on<EditSubmitted>(_onEditSubmitted);
  }

  final TodosRepo _todosRepo;

  void _onEditTitleChanged(EditTitleChanged event, Emitter<EditState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onEditDescChanged(EditDescChanged event, Emitter<EditState> emit) {
    emit(state.copyWith(desc: event.desc));
  }

  Future<void> _onEditSubmitted(EditSubmitted event, Emitter<EditState> emit) async {
    emit(state.copyWith(status: EditStatus.loading));
    final todo = (state.initTodo == null
        ? Todo(title: state.title).copyWith(
            desc: state.desc,
          )
        : Todo(title: '').copyWith(
            id: state.initTodo!.id,
            title: state.title,
            desc: state.desc,
          ));
    print('\n---edit_bloc changed: $todo');
    try {
      //update the TodosRepository
      print('\n---edit_bloc: $todo');
      await _todosRepo.saveTodo(todo);
      emit(state.copyWith(status: EditStatus.success));
      /*
TodosRepo notifies TodosBloc and StatsBloc.>>
TodosBloc and StatsBloc notify the UI which update with the new state.
       */
    } catch (e) {
      emit(state.copyWith(status: EditStatus.fail));
    }
  }
}
