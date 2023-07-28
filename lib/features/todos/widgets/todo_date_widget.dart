import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/extensions/date_extension.dart';
import 'package:todo_list_provider/shared/texts/text_widget.dart';

import '../../../shared/models/todo_model.dart';

class TodoDateWidget extends StatelessWidget {
  final TodoModel todo;

  const TodoDateWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: TextWidget(todo.date.formatDate),
    );
  }
}
