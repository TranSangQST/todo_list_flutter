import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import 'TodoView.dart';
import 'package:todo_list_flutter/TodoData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _todoDataTitle = "";
  String _todoDataDescription = "";
  DateTime _todoDataDate = new DateTime(new DateTime.now().year,
      new DateTime.now().month, new DateTime.now().day);

  List<TodoData> _todoList = [
    new TodoData(
        title: "t1",
        description: "d1",
        status: true,
        dateTime: new DateTime(2022, 11, 1, 1, 1, 1)),
    new TodoData(
        title: "t1",
        description: "d1",
        status: true,
        dateTime: new DateTime(2022, 11, 1, 2, 2, 2)),
    new TodoData(
        title: "t1",
        description: "d1",
        status: true,
        dateTime: new DateTime(2022, 11, 1, 4, 4, 4)),
    new TodoData(
        title: "t2",
        description: "d2",
        status: true,
        dateTime: new DateTime(2022, 11, 2, 1, 1, 1)),
    new TodoData(
        title: "t2",
        description: "d2",
        status: true,
        dateTime: new DateTime(2022, 11, 2, 2, 2, 2)),
    new TodoData(
        title: "t2",
        description: "d2",
        status: true,
        dateTime: new DateTime(2022, 11, 2, 4, 4, 4)),
    new TodoData(
        title: "t3",
        description: "d3",
        status: true,
        dateTime: new DateTime(2022, 11, 3, 1, 1, 1)),
    new TodoData(
        title: "t3",
        description: "d3",
        status: true,
        dateTime: new DateTime(2022, 11, 3, 2, 2, 2)),
    new TodoData(
        title: "t3",
        description: "d3",
        status: true,
        dateTime: new DateTime(2022, 11, 3, 4, 4, 4)),
    new TodoData(
        title: "t4",
        description: "d4",
        status: true,
        dateTime: new DateTime(2022, 11, 4, 1, 1, 1)),
    new TodoData(
        title: "t4",
        description: "d4",
        status: true,
        dateTime: new DateTime(2022, 11, 4, 2, 2, 2)),
    new TodoData(
        title: "t4",
        description: "d4",
        status: true,
        dateTime: new DateTime(2022, 11, 4, 4, 4, 4)),
    new TodoData(
        title: "t5",
        description: "d5",
        status: true,
        dateTime: new DateTime(2022, 11, 5, 1, 1, 1)),
    new TodoData(
        title: "t5",
        description: "d5",
        status: true,
        dateTime: new DateTime(2022, 11, 5, 2, 2, 2)),
    new TodoData(
        title: "t5",
        description: "d5",
        status: true,
        dateTime: new DateTime(2022, 11, 5, 4, 4, 4)),
    new TodoData(
        title: "t6",
        description: "d6",
        status: true,
        dateTime: new DateTime(2022, 11, 6, 1, 1, 1)),
    new TodoData(
        title: "t6",
        description: "d6",
        status: true,
        dateTime: new DateTime(2022, 11, 6, 2, 2, 2)),
    new TodoData(
        title: "t6",
        description: "d6",
        status: true,
        dateTime: new DateTime(2022, 11, 6, 4, 4, 4)),
    new TodoData(
        title: "t7",
        description: "d7",
        status: true,
        dateTime: new DateTime(2022, 11, 7, 1, 1, 1)),
    new TodoData(
        title: "t7",
        description: "d7",
        status: true,
        dateTime: new DateTime(2022, 11, 7, 2, 2, 2)),
    new TodoData(
        title: "t7",
        description: "d7",
        status: true,
        dateTime: new DateTime(2022, 11, 7, 4, 4, 4)),
  ];

  int _currentTabIndex = 1;

  var _todoDataTitleController = TextEditingController();
  var _todoDataDescriptionController = TextEditingController();
  // var _todoDataTitleController = TextEditingController();

  void addTodo() {
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
      _todoDataDate = new DateTime(new DateTime.now().year,
          new DateTime.now().month, new DateTime.now().day);
      _todoList.add(newTodoData);
    });

    // setState(() {});
  }

  void handleRemoveTodo(TodoData todoData, int index) {}

  @override
  Widget build(BuildContext context) {
    print('-----------------------------------------------------');
    print('_todoList: $_todoList');

    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Task title'),
              controller: _todoDataTitleController,
              onChanged: (text) {
                setState(() {
                  _todoDataTitle = text;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Task description'),
              controller: _todoDataDescriptionController,
              onChanged: (text) {
                setState(() {
                  _todoDataDescription = text;
                });
              },
            ),
            Text(_todoDataDate.toString()),
            TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2010, 3, 5),
                      maxTime: DateTime(2050, 6, 7),
                      theme: const DatePickerTheme(
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onConfirm: (date) {
                    print('confirm date $date');

                    DateTime newDate = new DateTime(
                        date.year,
                        date.month,
                        date.day,
                        _todoDataDate.hour,
                        _todoDataDate.minute,
                        _todoDataDate.second);

                    print('newDate: $newDate');

                    setState(() {
                      _todoDataDate = newDate;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Text(
                  'Date',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  DatePicker.showTimePicker(context, showTitleActions: true,
                      onConfirm: (date) {
                    print('confirm time $date');

                    DateTime newDate = new DateTime(
                        _todoDataDate.year,
                        _todoDataDate.month,
                        _todoDataDate.day,
                        date.hour,
                        date.minute,
                        date.second);

                    print('newDate: $newDate');

                    setState(() {
                      _todoDataDate = newDate;
                    });
                  }, currentTime: DateTime.now());
                },
                child: const Text(
                  'show time picker',
                  style: TextStyle(color: Colors.blue),
                )),
            Expanded(
              //        <-- Use Expanded
              child: GroupedListView<dynamic, String>(
                elements: _todoList,
                groupComparator: (value1, value2) =>
                    value1 == "Overdue" ? 1 : value2.compareTo(value1),
                order: GroupedListOrder.DESC,
                itemComparator: (value1, value2) =>
                    value2.dateTime.difference(value1.dateTime).inSeconds,

                // groupBy: (element) => element.dateTime.isBefore(DateTime.now())
                //     ? "Overdue"
                //     : formatter.format(element.dateTime),
                groupBy: (element) => "",
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
                itemBuilder: (c, element) {
                  return TodoView(
                    todoData: element,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        tooltip: 'Increment',
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
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
        // onTap: _onItemTapped,
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}


                  //      ListView.builder(
                  //   itemCount: _todoList.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     TodoData todoData = _todoList[index];
                  //     if (todoData.status)
                  //       return TodoView(
                  //         todoData: todoData,
                  //         index: index,
                  //         handleRemoveTodo: handleRemoveTodo,
                  //       );
                  //     else
                  //       return const Divider(
                  //         height: 0,
                  //         thickness: 0,
                  //       );
                  //   },
                  // ) 


// void handleRemoveTodo(TodoData todoData, int index) {
//   todoData.status = false;
//   String str = todoData.toString();
//   print('Remove $str');
//   TodoData newTodo = todoData.clone();
//   newTodo.status = false;
//   String str2 = newTodo.toString();
//   print('new todo $str2');
//   // int index = _todoList.indexOf(todoData);
//   // print("idx: $idx");
//   print("index: $index");

//   setState(() {
//     _todoList.removeAt(index);
//   });
// }

// new TodoData(title: "t1", description: "d1", status: true, dateTime: new DateTime(2022, 11, 1, 1, 1, 1)),
// new TodoData(title: "t1", description: "d1", status: true, dateTime: new DateTime(2022, 11, 1, 2, 2, 2)),
// new TodoData(title: "t1", description: "d1", status: true, dateTime: new DateTime(2022, 11, 1, 4, 4, 4)),

// new TodoData(title: "t2", description: "d2", status: true, dateTime: new DateTime(2022, 11, 2, 1, 1, 1)),
// new TodoData(title: "t2", description: "d2", status: true, dateTime: new DateTime(2022, 11, 2, 2, 2, 2)),
// new TodoData(title: "t2", description: "d2", status: true, dateTime: new DateTime(2022, 11, 2, 4, 4, 4)),

// new TodoData(title: "t3", description: "d3", status: true, dateTime: new DateTime(2022, 11, 3, 1, 1, 1)),
// new TodoData(title: "t3", description: "d3", status: true, dateTime: new DateTime(2022, 11, 3, 2, 2, 2)),
// new TodoData(title: "t3", description: "d3", status: true, dateTime: new DateTime(2022, 11, 3, 4, 4, 4)),

// new TodoData(title: "t4", description: "d4", status: true, dateTime: new DateTime(2022, 11, 4, 1, 1, 1)),
// new TodoData(title: "t4", description: "d4", status: true, dateTime: new DateTime(2022, 11, 4, 2, 2, 2)),
// new TodoData(title: "t4", description: "d4", status: true, dateTime: new DateTime(2022, 11, 4, 4, 4, 4)),

// new TodoData(title: "t5", description: "d5", status: true, dateTime: new DateTime(2022, 11, 5, 1, 1, 1)),
// new TodoData(title: "t5", description: "d5", status: true, dateTime: new DateTime(2022, 11, 5, 2, 2, 2)),
// new TodoData(title: "t5", description: "d5", status: true, dateTime: new DateTime(2022, 11, 5, 4, 4, 4)),

// new TodoData(title: "t6", description: "d6", status: true, dateTime: new DateTime(2022, 11, 6, 1, 1, 1)),
// new TodoData(title: "t6", description: "d6", status: true, dateTime: new DateTime(2022, 11, 6, 2, 2, 2)),
// new TodoData(title: "t6", description: "d6", status: true, dateTime: new DateTime(2022, 11, 6, 4, 4, 4)),

// new TodoData(title: "t7", description: "d7", status: true, dateTime: new DateTime(2022, 11, 7, 1, 1, 1)),
// new TodoData(title: "t7", description: "d7", status: true, dateTime: new DateTime(2022, 11, 7, 2, 2, 2)),
// new TodoData(title: "t7", description: "d7", status: true, dateTime: new DateTime(2022, 11, 7, 4, 4, 4)),

