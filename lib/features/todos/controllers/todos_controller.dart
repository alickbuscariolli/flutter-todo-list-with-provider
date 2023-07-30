import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/services/todos_local_storage_service.dart';

class TodosController extends ChangeNotifier {
  final TodosLocalStorageService _todosLocalStorage;

  TodosController(this._todosLocalStorage);

  final List<TodoModel> todos = [];

  final List<String> doneTodos = [];

  Future<String?> loadTodos() async {
    final (String? error, List<TodoModel>? loadedTodos) =
        await _todosLocalStorage.getTodos();

    if (error == null) {
      todos
        ..clear()
        ..addAll(loadedTodos!);

      sortTodosByDate();
    }

    return error;
  }

  void sortTodosByDate() {
    todos.sort((todoA, todoB) => todoA.date.compareTo(todoB.date));
    notifyListeners();
  }

  Future<String?> loadDoneTodos() async {
    final (String? error, List<String>? loadedDoneTodos) =
        await _todosLocalStorage.getDoneTodos();

    if (error != null) {
      return error;
    }

    doneTodos
      ..clear()
      ..addAll(loadedDoneTodos!);

    return null;
  }

  Future<String?> addTodo(TodoModel todo) async {
    todos.add(todo);
    final String? error = await saveTodos();

    if (error == null) {
      sortTodosByDate();
    }

    return error;
  }

  Future<String?> saveTodos() async {
    return _todosLocalStorage.setTodos(todos);
  }

  bool isTodoChecked(String id) {
    return doneTodos.indexWhere((checkedTodoId) => checkedTodoId == id) != -1;
  }

  Future<String?> checkTodo(String id) async {
    final String? error = await _todosLocalStorage.setDoneTodos(doneTodos);

    if (error == null) {
      if (!isTodoChecked(id)) {
        doneTodos.add(id);
      } else {
        doneTodos.removeWhere((checkedTodoId) => checkedTodoId == id);
      }

      notifyListeners();
    }

    return error;
  }
}
