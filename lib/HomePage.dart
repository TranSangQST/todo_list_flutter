import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'TodoView.dart';
import 'package:todo_list_flutter/TodoData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  String _todoDataTitle = "";
  String _todoDataDescription = "";
  DateTime? _todoDataDate;
  // DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<TodoData> _todoList = [];

  int _currentTabIndex = 0;

  final _todoDataTitleController = TextEditingController();
  final _todoDataDescriptionController = TextEditingController();

  // var _
  //todoDataTitleController = TextEditingController();

  setupTodo() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('todo');
    if (stringTodo != null) {
      List todoList = jsonDecode(stringTodo!);
      print("Todo in local: ");
      for (var todo in todoList) {
        print("todo: $todo");
        setState(() {
          _todoList.add(TodoData.fromJson(todo));
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupTodo();
  }

  void addTodo() {
    if (_todoDataTitle == "") {
      saveTodo();
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
    // setState(() {});
  }

  void saveTodo() {
    List todoListJson = _todoList.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(todoListJson));
    int x = 1;
  }

  void handleRemoveTodo(TodoData todoData) {
    print("Remove Click");

    setState(() {
      todoData.status = false;
    });

    saveTodo();
  }

  int groupComparator(String value1, String value2, int tabType) {
    switch (tabType) {
      case 0:
        {
          return 1;
        }

      case 1:
      case 2:
        {
          return value1 == "Overdue" ? 1 : value2.compareTo(value1);
        }
      default:
        {
          return 1;
        }
    }
  }

  int itemComparator(dynamic value1, dynamic value2, int tabType) {
    switch (tabType) {
      case 0:
        {
          return 1;
        }

      case 1:
      case 2:
        {
          return value2.dateTime.difference(value1.dateTime).inSeconds;
        }
      default:
        {
          return 1;
        }
    }
  }

  String groupBy(dynamic element, DateFormat formatter, int tabType) {
    switch (tabType) {
      case 0:
        {
          return "";
        }

      case 1:
      case 2:
        {
          DateTime today = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0);
          DateTime tomorrow = today.add(Duration(days: 1));

          print("today: ${today.toString()}");
          print("tomorrow: ${tomorrow.toString()}");

          if (element.dateTime.isBefore(today)) {
            return "Overdue";
          } else {
            if (element.dateTime.isBefore(tomorrow)) {
              return formatter.format(element.dateTime) + " (Today) ";
            } else {
              return formatter.format(element.dateTime);
            }
          }
        }
      default:
        {
          return "";
        }
    }
  }

  List<TodoData> getTodoListForEachTab(List<TodoData> todoList, tabType) {
    switch (tabType) {
      case 0:
        {
          return todoList;
        }
        break;
      case 1:
        {
          DateTime today = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0);
          DateTime tomorrow = today.add(Duration(days: 1));

          print("today: ${today.toString()}");
          print("tomorrow: ${tomorrow.toString()}");

          return todoList.where((element) {
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
      case 2:
        {
          return todoList.where((element) => element.dateTime != null).toList();
        }
        break;

      default:
        {
          return todoList;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('-----------------------------------------------------');
    print('todolist: ');
    for (int i = 0; i < _todoList.length; i++) {
      print('${_todoList[i].toString()} -> Date: ${_todoList[i].dateTime}');
    }

    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateFormat formatterDateTime = DateFormat('dd/MM/yyyy hh:mm:ss');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          ExpansionTile(
            title: const Text(
              "Add new Task...",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                          children: <Widget>[
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
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
                                    padding: const EdgeInsets.only(left: 10),
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
                                  padding: const EdgeInsets.all(16.0),
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
                              children: <Widget>[
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
                                              print('confirm date $date');

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

                                              print('newDate: $newDate');

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
                                              print('confirm time $date');

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

                                              print('newDate: $newDate');

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
          Expanded(
            child: GroupedListView<dynamic, String>(
              elements: getTodoListForEachTab(_todoList, _currentTabIndex),
              itemBuilder: (c, element) {
                return TodoView(
                  todoData: element,
                  handleRemoveTodo: handleRemoveTodo,
                );
              },

              groupComparator: (value1, value2) =>
                  groupComparator(value1, value2, _currentTabIndex),
// value1 == "Overdue" ? 1 : value2.compareTo(value1),
              order: GroupedListOrder.DESC,
              itemComparator: (value1, value2) =>
                  itemComparator(value1, value2, _currentTabIndex),
// value2.dateTime.difference(value1.dateTime).inSeconds,

              groupBy: (element) =>
                  groupBy(element, formatter, _currentTabIndex),
// groupBy: (element) => "",
              groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.2)))),
                    child: Text(
                      value,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
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

// //
// final List<TodoData> _todoList = [
//   TodoData(title: "t0", description: "d0", status: true),
//   TodoData(
//       title: "t1",
//       description: "d1",
//       status: true,
//       dateTime: DateTime(2022, 11, 1, 1, 1, 1)),
//   TodoData(
//       title: "t1",
//       description: "d1",
//       status: true,
//       dateTime: DateTime(2022, 11, 1, 2, 2, 2)),
//   TodoData(
//       title: "t1",
//       description: "d1",
//       status: true,
//       dateTime: DateTime(2022, 11, 1, 4, 4, 4)),
//   TodoData(
//       title: "t2",
//       description: "d2",
//       status: true,
//       dateTime: DateTime(2022, 11, 2, 1, 1, 1)),
//   TodoData(
//       title: "t2",
//       description: "d2",
//       status: true,
//       dateTime: DateTime(2022, 11, 2, 2, 2, 2)),
//   TodoData(
//       title: "t2",
//       description: "d2",
//       status: true,
//       dateTime: DateTime(2022, 11, 2, 4, 4, 4)),
//   TodoData(
//       title: "t3",
//       description: "d3",
//       status: true,
//       dateTime: DateTime(2022, 11, 3, 1, 1, 1)),
//   TodoData(
//       title: "t3",
//       description: "d3",
//       status: true,
//       dateTime: DateTime(2022, 11, 3, 2, 2, 2)),
//   TodoData(
//       title: "t3",
//       description: "d3",
//       status: true,
//       dateTime: DateTime(2022, 11, 3, 4, 4, 4)),
//   TodoData(
//       title: "t4",
//       description: "d4",
//       status: true,
//       dateTime: DateTime(2022, 11, 4, 1, 1, 1)),
//   TodoData(
//       title: "t4",
//       description: "d4",
//       status: true,
//       dateTime: DateTime(2022, 11, 4, 2, 2, 2)),
//   TodoData(
//       title: "t4",
//       description: "d4",
//       status: true,
//       dateTime: DateTime(2022, 11, 4, 4, 4, 4)),
//   TodoData(
//       title: "t5",
//       description: "d5",
//       status: true,
//       dateTime: DateTime(2022, 11, 5, 1, 1, 1)),
//   TodoData(
//       title: "t5",
//       description: "d5",
//       status: true,
//       dateTime: DateTime(2022, 11, 5, 2, 2, 2)),
//   TodoData(
//       title: "t5",
//       description: "d5",
//       status: true,
//       dateTime: DateTime(2022, 11, 5, 12, 12, 12)),
//   TodoData(
//       title: "t5",
//       description: "d5",
//       status: true,
//       dateTime: DateTime(2022, 11, 5, 4, 4, 4)),
//   TodoData(
//       title: "t6",
//       description: "d6",
//       status: true,
//       dateTime: DateTime(2022, 11, 6, 1, 1, 1)),
//   TodoData(
//       title: "t6",
//       description: "d6",
//       status: true,
//       dateTime: DateTime(2022, 11, 6, 2, 2, 2)),
//   TodoData(
//       title: "t6",
//       description: "d6",
//       status: true,
//       dateTime: DateTime(2022, 11, 6, 4, 4, 4)),
//   TodoData(
//       title: "t7",
//       description: "d7",
//       status: true,
//       dateTime: DateTime(2022, 11, 7, 1, 1, 1)),
//   TodoData(
//       title: "t7",
//       description: "d7",
//       status: true,
//       dateTime: DateTime(2022, 11, 7, 2, 2, 2)),
//   TodoData(
//       title: "t7",
//       description: "d7",
//       status: true,
//       dateTime: DateTime(2022, 11, 7, 4, 4, 4)),
// ];