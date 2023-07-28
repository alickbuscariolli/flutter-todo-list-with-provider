import 'package:flutter/material.dart';

class AddTodoIconWidget extends StatelessWidget {
  final void Function() goToAddTodo;

  const AddTodoIconWidget(this.goToAddTodo, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: goToAddTodo,
      icon: const Icon(
        Icons.add,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
