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

    if (error != null) {
      return error;
    }

    todos
      ..clear()
      ..addAll(loadedTodos!);

    sortTodosByDate();

    return null;
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

  Future<void> addTodo(TodoModel todo) async {
    todos.add(todo);
    await saveTodos();
    sortTodosByDate();
  }

  Future<String?> saveTodos() async {
    return _todosLocalStorage.setTodos(todos);
  }

  bool isTodoChecked(String id) {
    return doneTodos.indexWhere((checkedTodoId) => checkedTodoId == id) != -1;
  }

  void checkTodo(String id) async {
    if (!isTodoChecked(id)) {
      doneTodos.add(id);
    } else {
      doneTodos.removeWhere((checkedTodoId) => checkedTodoId == id);
    }

    await _todosLocalStorage.setDoneTodos(doneTodos);

    notifyListeners();
  }

  void sortTodosByDate() {
    todos.sort((todoA, todoB) => todoA.date.compareTo(todoB.date));
    notifyListeners();
  }
}
