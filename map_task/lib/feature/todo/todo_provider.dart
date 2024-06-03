import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/sqlite_repo.dart';
import '../../network/api_service.dart';
import 'todo.dart';
import '../../utils/custom_exception/http_response_exception.dart';

final todoProvider = ChangeNotifierProvider<TodoProvider>((ref) {
  return TodoProvider(ref.read(sqlRepoProvider), ref.read(apiServiceProvider));
});

class TodoProvider extends ChangeNotifier {
  final ApiService apiService;
  final SqliteRepo sqliteRepo;

  TodoProvider(this.sqliteRepo, this.apiService);

  bool isLoading = false;
  String error = '';
  List<Todo> todos = [];

  Future<void> fetchTodos() async {
    try {
      isLoading = true;
      List<Todo> data = await sqliteRepo.fetchTodosFromDB();
      List<Todo> todoData = [];
      log("Length data${data.length}");

      if (data.isEmpty) {
        todoData = await apiService.fetchTodos(10, 0);
      } else {
        todos.addAll(data);
        isLoading = false;
        notifyListeners();
        int length = data.length;
        todoData = await apiService.fetchTodos(10, length);
      }

      if (todoData.isNotEmpty) {
        await sqliteRepo.insertTodoList(todoData);
        List<Todo> data = await sqliteRepo.fetchTodosFromDB();
        todos.addAll(data);
        notifyListeners();
      }
      isLoading = false;
      notifyListeners();
    } on SessionExpiredException {
      error = "SessionExpiredException";
      //session expired
    } on CustomException {
      //custom defined exception
      error = "CustomException";
    } catch (e) {
      //exception
      error = "$e";
    }
  }
}
