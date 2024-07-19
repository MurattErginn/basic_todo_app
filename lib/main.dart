import 'package:flutter/material.dart';
import 'package:untitled/widgets/data_manager.dart';
import 'package:untitled/pages/home.dart';
import 'package:untitled/pages/todo_adding.dart';
import 'models/todo.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if there are no todos and add default todos
  List<ToDo> todos = await DataManager.getTodoList();
  if (todos.isEmpty) {
    await DataManager.addDefaultTodos();
  }

  runApp(MaterialApp(
   home: const Home(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/home': (context) => const Home(),
      '/todoAdd': (context) => const TodoAdding(),
      //'/todoEdit': (context) => const TodoEditing(),
    },
  ));
}

