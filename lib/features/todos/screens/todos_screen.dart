import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/features/todos/controllers/todos_controller.dart';
import 'package:todo_list_provider/features/todos/widgets/add_todo_icon_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/loading_error_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/todo_checkbox_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/todo_date_widget.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/features/add_todo/screens/add_todo_screen.dart';
import 'package:todo_list_provider/shared/texts/text_widget.dart';

import '../widgets/todo_title_and_description_widget.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loadTodosAndDoneTodos();
    });
    super.initState();
  }

  Future<void> loadTodosAndDoneTodos() async {
    isLoading = true;
    error = null;

    final String? errorLoadingTodos =
        await context.read<TodosController>().loadTodos();

    if (context.mounted) {
      final String? errorLoadingDoneTodos =
          await context.read<TodosController>().loadDoneTodos();

      if (errorLoadingTodos != null || errorLoadingDoneTodos != null) {
        setState(() {
          error = errorLoadingTodos ?? errorLoadingDoneTodos;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void _goToAddTodo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddTodoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoCtrl = context.watch<TodosController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas - Flutter Dicas'),
        actions: [AddTodoIconWidget(_goToAddTodo)],
      ),
      body: isLoading || error != null
          ? LoadingErrorWidget(
              isLoading: isLoading,
              loadTodosAndDoneTodos: loadTodosAndDoneTodos,
            )
          : todoCtrl.todos.isEmpty
              ? const Center(
                  child: TextWidget('Você ainda não possui nenhuma tarefa'),
                )
              : ListView.builder(
                  itemCount: todoCtrl.todos.length,
                  itemBuilder: (_, int index) {
                    final TodoModel todo = todoCtrl.todos[index];

                    return Column(
                      children: [
                        Row(
                          children: [
                            TodoCheckboxWidget(todo),
                            const SizedBox(width: 12),
                            TodoTitleAndDescriptionWidget(todo),
                            TodoDateWidget(todo),
                          ],
                        ),
                        const SizedBox(height: 32),
                      ],
                    );
                  },
                ),
    );
  }
}
