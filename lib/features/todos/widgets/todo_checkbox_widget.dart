import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/features/todos/controllers/todos_controller.dart';
import 'package:todo_list_provider/shared/mixins/snack_bar_mixin.dart';

import '../../../shared/models/todo_model.dart';

class TodoCheckboxWidget extends StatelessWidget with SnackBarMixin {
  final TodoModel todo;
  const TodoCheckboxWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    final todoCtrl = context.watch<TodosController>();
    return Checkbox(
      value: todoCtrl.isTodoChecked(todo.id),
      onChanged: (bool? changed) async {
        final String? error = await todoCtrl.checkTodo(todo.id);

        if (error != null && context.mounted) {
          showSnackBar(error, context: context, isError: true);
        }
      },
    );
  }
}
