import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/features/add_todo/widgets/date_text_input_widget.dart';
import 'package:todo_list_provider/features/add_todo/widgets/description_text_input_widget.dart';
import 'package:todo_list_provider/features/add_todo/widgets/title_text_input_widget.dart';
import 'package:todo_list_provider/features/todos/controllers/todos_controller.dart';
import 'package:todo_list_provider/shared/mixins/snack_bar_mixin.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/texts/text_widget.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> with SnackBarMixin {
  final _formKey = GlobalKey<FormState>();

  final _titleTEC = TextEditingController();
  final _titleFN = FocusNode();

  final _descriptionTEC = TextEditingController();
  final _descriptionFN = FocusNode();

  final _todoDateTEC = TextEditingController();
  final _todoDateFN = FocusNode();

  late DateTime todoDate;

  @override
  void dispose() {
    _titleTEC.dispose();
    _titleFN.dispose();

    _descriptionTEC.dispose();
    _descriptionFN.dispose();

    _formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> _addTodo() async {
    if (_formKey.currentState!.validate()) {
      final todoCtrl = Provider.of<TodosController>(context, listen: false);
      final String? error = await todoCtrl.addTodo(
        TodoModel(
          title: _titleTEC.text,
          description: _descriptionTEC.text,
          cDate: todoDate,
        ),
      );

      if (context.mounted) {
        if (error != null) {
          showSnackBar(error, context: context, isError: true);
        } else {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Adicionar Tarefa'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TitleTextInputWidget(
                  titleTEC: _titleTEC,
                  titleFN: _titleFN,
                  descriptionFN: _descriptionFN,
                ),
                const SizedBox(height: 16),
                DescriptionTextInputWidget(
                  descriptionTEC: _descriptionTEC,
                  descriptionFN: _descriptionFN,
                ),
                const SizedBox(height: 16),
                DateTextInputWidget(
                  todoDateTEC: _todoDateTEC,
                  todoDateFN: _todoDateFN,
                  addTodo: _addTodo,
                  setDate: (DateTime date) => {
                    todoDate = date,
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Adicionar Tarefa'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
