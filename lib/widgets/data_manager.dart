import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/models/todo.dart';

class DataManager {
  static const String _todoListKey = 'todo_list';

  static Future<List<ToDo>> getTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList(_todoListKey);
    
    if(jsonStringList == null) {
      print('json string is null');
      return [];
    }
    
    return jsonStringList.map((jsonString) => ToDo.fromJson(json.decode(jsonString))).toList();
  }

  static Future<void> saveTodoList(List<ToDo> todoList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList = todoList.map((todo) => json.encode(todo.toJson())).toList();
    prefs.setStringList(_todoListKey, jsonStringList);
  }

  static Future<void> addNewTodo(ToDo newTodo) async {
    List<ToDo> todos = await getTodoList();
    todos.add(newTodo);
    await saveTodoList(todos);
  }

  static Future<void> deleteTodoById(String id) async {
    List<ToDo> todos = await getTodoList();
    todos.removeWhere((todo) => todo.id == id);
    await saveTodoList(todos);
  }

  static Future<void> addDefaultTodos() async {
    List<ToDo> defaultTodos = ToDo.todoList();
    List<String> defaultTodosJson = defaultTodos.map((todo) => json.encode(todo.toJson())).toList();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_todoListKey, defaultTodosJson);
  }
}



