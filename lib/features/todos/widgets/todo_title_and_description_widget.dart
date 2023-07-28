import 'package:flutter/material.dart';

import '../../../shared/models/todo_model.dart';
import '../../../shared/texts/text_widget.dart';

class TodoTitleAndDescriptionWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoTitleAndDescriptionWidget(
    this.todo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            todo.title,
            fontSize: 24,
          ),
          TextWidget(
            todo.description,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
