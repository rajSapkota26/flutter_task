import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:map_task/feature/todo/todo.dart';
import 'package:map_task/feature/todo/todo_provider.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  late TodoProvider viewModel;

  @override
  void initState() {
    // initiate view model
    viewModel = ref.read(todoProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // call view model fetch data
      viewModel.fetchTodos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),

      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(todoProvider);

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }
          final List<Todo> todos = state.todos;
          if (todos.isEmpty) {
            return const Center(
              child: Text('No data found'),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final Todo todo = todos[index];
              return ListTile(
                title: Text(todo.todo),
                subtitle: Text("Complete:${todo.completed}"),
                leading: const Icon(
                  Icons.numbers,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
