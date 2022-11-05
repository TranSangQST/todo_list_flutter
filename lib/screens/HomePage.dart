import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../components/TodoView.dart';
import 'package:todo_list_flutter/ClassData/TodoData.dart';
import '../utils/CustomPropertiesForGroupedListView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;

  // state for add new tasks form
  String _todoDataTitle = "";
  String _todoDataDescription = "";
  DateTime? _todoDataDate;

  final _todoDataTitleController = TextEditingController();
  final _todoDataDescriptionController = TextEditingController();
  final _searchTodoDataController = TextEditingController();

  //
  List<TodoData> _todoList = [];

  // state for search form
  String _searchTodoData = "";

  //
  int _currentTabIndex = 0;

  // Refer: https://github.com/projectsforchannel/Todo-Project
  setupTodo() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('todo');
    if (stringTodo != null) {
      List todoList = jsonDecode(stringTodo!);
      // print("Todo in local: ");
      for (var todo in todoList) {
        // print("todo: $todo");
        setState(() {
          _todoList.add(TodoData.fromJson(todo));
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setupTodo();
  }

  void addTodo() {
    if (_todoDataTitle == "") {
      // saveTodo();
      return;
    }

    TodoData newTodoData = TodoData(
        title: _todoDataTitle,
        description: _todoDataDescription,
        status: true,
        dateTime: _todoDataDate);

    _todoDataTitleController.text = "";
    _todoDataDescriptionController.text = "";

    setState(() {
      _todoDataTitle = "";
      _todoDataDescription = "";
      _todoDataDate = null;
      _todoList.add(newTodoData);
    });

    saveTodo();
  }

  // Refer: https://github.com/projectsforchannel/Todo-Project
  void saveTodo() {
    List todoListJson = _todoList.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(todoListJson));
  }

  void handleRemoveTodo(TodoData todoData) {
    setState(() {
      todoData.status = false;
    });
    saveTodo();
  }

  List<TodoData> getTodoListForEachTab(
      List<TodoData> todoList, tabType, searchTodoData) {
    List<TodoData> todoListForEachTab = [];

    switch (tabType) {
      case 0:
        {
          todoListForEachTab = todoList;
        }
        break;
      case 1:
        {
          DateTime today = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0);
          DateTime tomorrow = today.add(Duration(days: 1));

          // print("today: ${today.toString()}");
          // print("tomorrow: ${tomorrow.toString()}");

          todoListForEachTab = todoList.where((element) {
            DateTime? dateTime = element.dateTime;
            if (dateTime != null) {
              return dateTime.isBefore(tomorrow);
            }
            return false;
          }).toList();
          // .where((element) {
          //   return element.dateTime.isBefore(DateTime.now());
          // }).toList();
        }
        break;
      case 2:
        {
          todoListForEachTab =
              todoList.where((element) => element.dateTime != null).toList();
        }
        break;

      default:
        {
          todoListForEachTab = todoList;
        }
        break;
    }

    return todoListForEachTab.where((element) {
      return element.title.contains(searchTodoData) ||
          element.description.contains(searchTodoData);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateFormat formatterDateTime = DateFormat('dd/MM/yyyy hh:mm:ss');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
          //
          Container(
              child: Column(
        children: <Widget>[
          // Search form
          ExpansionTile(
            title: const Text(
              "Search...",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Search'),
                          controller: _searchTodoDataController,
                          keyboardType: TextInputType.multiline,
                          onChanged: (text) {
                            setState(() {
                              _searchTodoData = text;
                            });
                          },
                        ),
                      ),
                      _searchTodoData != ""
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(20),
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  210, 210, 210, 1)),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _searchTodoData = "";
                                          });
                                          _searchTodoDataController.text = "";
                                        },
                                        child: const Icon(
                                          Icons.clear_rounded,
                                        )))
                              ],
                            )
                          : const Divider(
                              height: 0,
                              thickness: 0,
                            )
                    ]),
              ),
            ],
          ),

          // Add new task (Todo) form
          ExpansionTile(
            title: const Text(
              "Add new Task...",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.6))),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18),
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Task title'),
                                      controller: _todoDataTitleController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      onChanged: (text) {
                                        setState(() {
                                          _todoDataTitle = text;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18),
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Task description'),
                                      controller:
                                          _todoDataDescriptionController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      onChanged: (text) {
                                        setState(() {
                                          _todoDataDescription = text;
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Text(
                                    _todoDataDate != null
                                        ? formatterDateTime
                                            .format(_todoDataDate!)
                                        : "",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                _todoDataDate != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 2,
                                                  color: Color.fromRGBO(
                                                      210, 210, 210, 1)),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _todoDataDate = null;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.clear_rounded,
                                            )),
                                      )
                                    : const Divider(
                                        height: 0,
                                        thickness: 0,
                                      )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Ref: https://pub.dev/packages/flutter_datetime_picker/example
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 2,
                                                color: Color.fromRGBO(
                                                    210, 210, 210, 1)),
                                          ),
                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(2010, 3, 5),
                                                maxTime: DateTime(2050, 6, 7),
                                                theme: const DatePickerTheme(
                                                    headerColor: Colors.orange,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    itemStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                    doneStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                              // print('confirm date $date');

                                              final DateTime newDate;
                                              DateTime? currentTodoDate =
                                                  _todoDataDate;
                                              if (currentTodoDate != null) {
                                                newDate = DateTime(
                                                    date.year,
                                                    date.month,
                                                    date.day,
                                                    currentTodoDate.hour,
                                                    currentTodoDate.minute,
                                                    currentTodoDate.second);
                                              } else {
                                                newDate = DateTime(
                                                  date.year,
                                                  date.month,
                                                  date.day,
                                                );
                                              }

                                              // print('newDate: $newDate');

                                              setState(() {
                                                _todoDataDate = newDate;
                                              });
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en);
                                          },
                                          child: const Icon(
                                            Icons.calendar_today,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 2,
                                                color: Color.fromRGBO(
                                                    210, 210, 210, 1)),
                                          ),
                                          onPressed: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                onConfirm: (date) {
                                              // print('confirm time $date');

                                              final DateTime newDate;
                                              DateTime? currentTodoDate =
                                                  _todoDataDate;
                                              if (currentTodoDate != null) {
                                                newDate = DateTime(
                                                    currentTodoDate.year,
                                                    currentTodoDate.month,
                                                    currentTodoDate.day,
                                                    date.hour,
                                                    date.minute,
                                                    date.second);
                                              } else {
                                                newDate = DateTime(date.hour,
                                                    date.minute, date.second);
                                              }

                                              // print('newDate: $newDate');

                                              setState(() {
                                                _todoDataDate = newDate;
                                              });
                                            }, currentTime: DateTime.now());
                                          },
                                          child: const Icon(
                                            Icons.watch_later_sharp,
                                          )),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(
                                                210, 210, 210, 1)),
                                      ),
                                      onPressed: addTodo,
                                      child: const Icon(
                                        Icons.add,
                                      )),
                                ),
                              ],
                            )
                          ])),
                ],
              )
            ],
          ),

          // List of tasks (Todo)
          Expanded(
              child: GroupedListView<dynamic, String>(
            elements: getTodoListForEachTab(
                _todoList, _currentTabIndex, _searchTodoData),
            itemBuilder: (c, element) {
              return TodoView(
                todoData: element,
                handleRemoveTodo: handleRemoveTodo,
              );
            },
            groupComparator: (value1, value2) =>
                CustomPropertiesForGroupedListView.groupComparator(
                    value1, value2, _currentTabIndex),
            order: GroupedListOrder.DESC,
            itemComparator: (value1, value2) =>
                CustomPropertiesForGroupedListView.itemComparator(
                    value1, value2, _currentTabIndex),
            groupBy: (element) => CustomPropertiesForGroupedListView.groupBy(
                element, formatter, _currentTabIndex),
            groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)))),
                  child: Text(
                    value,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
          ))
        ],
      )),

      // Tab
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox_rounded),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today_rounded),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upcoming_rounded),
            label: 'Up coming',
          ),
        ],
        currentIndex: _currentTabIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }
}
