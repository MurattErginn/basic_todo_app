import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/constants/colors.dart';
import 'package:untitled/constants/font_sizes.dart';
import 'package:untitled/pages/todo_editing.dart';

import 'package:untitled/tools/datetime_functions.dart';
import 'package:untitled/widgets/date_picker_timeline.dart';
import 'package:untitled/widgets/special_appbar.dart';
import 'package:untitled/widgets/todo_item.dart';
import 'package:untitled/models/todo.dart';

import '../constants/priority_level.dart';
import '../widgets/data_manager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  static _HomeState? of(BuildContext context) {
    return context.findAncestorStateOfType<_HomeState>();
  }
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int todoListState = 0; // 0 -> All, 1 -> Daily, 2 -> Priority, 3 -> On Day
  List<ToDo> _foundToDo = [];
  DateTime? _selectedDate;

  late TabController _tabController;

  bool isDateTabSelected = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    DataManager.getTodoList().then((todoList) {
      setState(() {
        _foundToDo = todoList;
      });
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    DataManager.saveTodoList(_foundToDo);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.tdPurple,
        child: const Icon(
          Icons.add,
          color: AppColors.tdTextLight,
          size: largeSize + 15,
        ),
        onPressed: () async {
          final newTodo = await Navigator.pushNamed(context, '/todoAdd');
          if (newTodo != null && newTodo is ToDo) {
            _addNewTodo(newTodo);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: AppColors.tdBGColor,
      appBar: SpecialAppBar(
        onStartIconPress: toggleDatePicker,
        onEndIconPress: () => toggleDatePicker(resetDate: true),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchBox(),
                const SizedBox(height: 10),
                if (isDateTabSelected)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DatePickerTimeline(
                      onDateSelected: updateSelectedDate,
                    ),
                  ),
                const SizedBox(height: 10),
                buildCustomTabBar(),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TabBarView(
                controller: _tabController,
                children: [
                  isDateTabSelected ? buildOnDayTodosList() : buildDailyTodosList(),
                  buildPrioTodosList(),
                  buildCompletedTodosList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCustomTabBar() {
    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ButtonsTabBar(
          controller: _tabController,
          contentCenter: true,
          width: 130,
          backgroundColor: AppColors.tdBlue,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            color: AppColors.tdPurple,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(
              text: isDateTabSelected ? 'All' : 'Daily',
            ),
            const Tab(
              text: 'Priority',
            ),
            const Tab(
              text: 'Completed',
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.tdGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.tdFGColor,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColors.tdTextDark),
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) async {
    await DataManager.deleteTodoById(id);
    setState(()  {
      _foundToDo.removeWhere((item) => item.id == id);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = ToDo.todoList();
    } else {
      results = ToDo.todoList()
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  void _addNewTodo(ToDo todo) async {
    await DataManager.addNewTodo(todo);
    setState(() {
      _foundToDo.add(todo);
    });
  }

  Widget buildCompletedTodosList() {
    List<ToDo> completedTodos;

    if (isDateTabSelected && _selectedDate != null) {
      completedTodos = _foundToDo
          .where((todo) =>
              todo.isDone &&
              todo.date.year == _selectedDate!.year &&
              todo.date.month == _selectedDate!.month &&
              todo.date.day == _selectedDate!.day)
          .toList();
    } else {
      completedTodos = _foundToDo.where((todo) => todo.isDone).toList();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: completedTodos.length,
      itemBuilder: (BuildContext context, int index) {
        return ToDoItem(
          todo: completedTodos[index],
          onToDoChanged: _handleToDoChange,
          onDeleteItem: _deleteToDoItem,
          onEditItem: () async {
            final updatedTodo = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoEditing(todo: completedTodos[index]),
              ),
            );
            if (updatedTodo != null && updatedTodo is ToDo) {
              _updateTodoList(updatedTodo);
            }
          },
        );
      },
    );
  }

  Widget buildDailyTodosList() {
    Map<String, List<ToDo>> dailyTodos = {};

    for (ToDo todo in _foundToDo) {
      String formattedDate =
          DateTimeFunctions.dateTimeToStr(todo.date, dateFormat: 'MMMMd');
      if (!dailyTodos.containsKey(formattedDate)) {
        dailyTodos[formattedDate] = [];
      }
      dailyTodos[formattedDate]!.add(todo);
    }

    List<String> sortedDays = dailyTodos.keys.toList()
      ..sort((a, b) =>
          DateFormat('MMMMd').parse(a).compareTo(DateFormat('MMMMd').parse(b)));

    return ListView.builder(
      shrinkWrap: true, // with this, I'm able to see the end of the list.
      itemCount: sortedDays.length,
      itemBuilder: (context, index) {
        String dayOfWeek = sortedDays[index];
        List<ToDo> todos = dailyTodos[dayOfWeek]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                _capitalizeFirstLetter(dayOfWeek),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tdTextDark,
                ),
              ),
            ),
            for (ToDo todo in todos)
              ToDoItem(
                todo: todo,
                onToDoChanged: _handleToDoChange,
                onDeleteItem: _deleteToDoItem,
                onEditItem: () async {
                  final updatedTodo = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodoEditing(todo: todo),
                    ),
                  );

                  if (updatedTodo != null && updatedTodo is ToDo) {
                    _updateTodoList(updatedTodo);
                  }
                },
              ),
          ],
        );
      },
    );
  }

  Widget buildPrioTodosList() {
    List<ToDo> filteredTodos = _foundToDo;

    if (_selectedDate != null && isDateTabSelected) {
      filteredTodos = filteredTodos
          .where((todo) =>
              todo.date.year == _selectedDate!.year &&
              todo.date.month == _selectedDate!.month &&
              todo.date.day == _selectedDate!.day)
          .toList();
    }

    List<ToDo> highPriorityTodos = [];
    List<ToDo> mediumPriorityTodos = [];
    List<ToDo> lowPriorityTodos = [];

    for (ToDo todoo in filteredTodos) {
      switch (todoo.priority) {
        case prioLevelHigh:
          highPriorityTodos.add(todoo);
          break;
        case prioLevelMedium:
          mediumPriorityTodos.add(todoo);
          break;
        case prioLevelLow:
          lowPriorityTodos.add(todoo);
          break;
      }
    }

    return ListView(
      shrinkWrap: true,
      children: [
        _buildPrioritySection('High Priority', highPriorityTodos),
        _buildPrioritySection('Medium Priority', mediumPriorityTodos),
        _buildPrioritySection('Low Priority', lowPriorityTodos),
      ],
    );
  }

  Widget buildOnDayTodosList() {
    if (_selectedDate == null) {
      return const Center(
        child: Text(
          "No date selected",
          style: TextStyle(fontSize: 16, color: AppColors.tdTextDark),
        ),
      );
    }

    List<ToDo> todosOnSelectedDay = _foundToDo.where((todo) {
      return todo.date.year == _selectedDate!.year &&
          todo.date.month == _selectedDate!.month &&
          todo.date.day == _selectedDate!.day;
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: todosOnSelectedDay.length,
      itemBuilder: (context, index) {
        return ToDoItem(
          todo: todosOnSelectedDay[index],
          onToDoChanged: _handleToDoChange,
          onDeleteItem: _deleteToDoItem,
          onEditItem: () async {
            final updatedTodo = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoEditing(todo: todosOnSelectedDay[index]),
              ),
            );

            if (updatedTodo != null && updatedTodo is ToDo) {
              _updateTodoList(updatedTodo);
            }
          },
        );
      },
    );
  }

  Widget _buildPrioritySection(String title, List<ToDo> todos) {
    return todos.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.tdTextDark,
                  ),
                ),
              ),
              for (ToDo todoo in todos)
                ToDoItem(
                  todo: todoo,
                  onToDoChanged: _handleToDoChange,
                  onDeleteItem: _deleteToDoItem,
                  onEditItem: () async {
                    final updatedTodo = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoEditing(todo: todoo),
                      ),
                    );

                    if (updatedTodo != null && updatedTodo is ToDo) {
                      _updateTodoList(updatedTodo);
                    }
                  },
                ),
            ],
          );
  }

  String _capitalizeFirstLetter(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }

  void updateSelectedDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      todoListState = 3;
    });
  }

  void toggleDatePicker({bool resetDate = false}) {
    setState(() {
      isDateTabSelected = !isDateTabSelected;
      if (resetDate) {
        _selectedDate = null;
      }
    });
  }

  void _updateTodoList(ToDo updatedTodo) {
    setState(() {
      final index = _foundToDo.indexWhere((todo) => todo.id == updatedTodo.id);
      if (index != -1) {
        _foundToDo[index] = updatedTodo;
      }
    });
  }
}
