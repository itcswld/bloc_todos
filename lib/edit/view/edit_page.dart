import 'package:bloc_todos/edit/bloc/edit_bloc.dart';
import 'package:bloc_todos/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repo/todos_repo.dart';
/*
├── BlocProvider<EditTodosBloc>
│   └── EditTodosPage
│       └── BlocListener<EditTodosBloc>
│           └── EditTodosView
│               ├── TitleField
│               ├── DescriptionField
│               └── Floating Action Button
 */

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  static Route<void> route({Todo? initTodo}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) {
            return EditBloc(
              todosRepo: context.read<TodosRepo>(),
              initTodo: initTodo,
            );
          },
          child: const EditPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditBloc, EditState>(
      listenWhen: (previous, current) => previous.status != current.status && current.status == EditStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditView(),
    );
  }
}

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = context.select((EditBloc bloc) => bloc.state.status);
    final isNewTodo = context.select((EditBloc bloc) => bloc.state.isNewTodo);

    return Scaffold(
      appBar: AppBar(
        title: Text(isNewTodo ? l10n.editViewAppBarTitleAdd : l10n.editViewAppBarTitleEdit),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.editTodoSaveButtonTooltip,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<EditBloc>().add(
                  const EditSubmitted(),
                ),
        child: status.isLoadingOrSuccess ? const CupertinoActivityIndicator() : Icon(Icons.check_rounded),
      ),
      body: const CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _TitleField(),
                _DescField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<EditBloc>().state;
    final title = state.initTodo?.title ?? '';

    return TextFormField(
      key: const Key('editView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: l10n.editViewTitleLabel,
        hintText: title,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (v) {
        context.read<EditBloc>().add(EditTitleChanged(v));
      },
    );
  }
}

class _DescField extends StatelessWidget {
  const _DescField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<EditBloc>().state;
    final desc = state.initTodo?.desc ?? '';

    return TextFormField(
      key: const Key('editView_desc_textFormField'),
      initialValue: state.desc,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: l10n.editViewDescLabel,
        hintText: desc,
      ),
      maxLength: 30,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (v) {
        context.read<EditBloc>().add(EditDescChanged(v));
      },
    );
  }
}
