import 'package:flutter/material.dart';
import 'package:todos_repo/todos_repo.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    required this.todo,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
    super.key,
  });

  final Todo todo;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('todoListTile_dismissible_${todo.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          todo.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: !todo.isCompleted
              ? null
              : TextStyle(
                  color: captionColor,
                  decoration: TextDecoration.lineThrough,
                ),
        ),
        subtitle: Text(
          todo.desc,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Checkbox(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          value: todo.isCompleted,
          onChanged: onToggleCompleted == null ? null : (v) => onToggleCompleted!(v!),
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}
