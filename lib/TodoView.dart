import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_list_flutter/TodoData.dart';

class TodoView extends StatefulWidget {
  TodoData todoData;

  // TodoView({Key key, this.todo}) : super(key: key);
  TodoView({super.key, required this.todoData});

  @override
  // _TodoViewState createState() => _TodoViewState(todo: this.todo);
  _TodoViewState createState() => _TodoViewState(todoData: this.todoData);
}

class _TodoViewState extends State<TodoView> {
  TodoData todoData;
  _TodoViewState({required this.todoData});

  String formatDate(DateFormat formatter, DateTime? dateTime) {
    if (dateTime != null) {
      return formatter.format(dateTime);
    } else {
      return "";
    }
  }

  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy: hh:mm:ss');

    if (todoData.status) {
      return Card(
          elevation: 8.0,
          child: SizedBox(
              child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            leading: Checkbox(
              checkColor: Colors.white,
              value: todoData.status,
              onChanged: (bool? val) {
                setState(() {
                  todoData.status = !todoData.status;
                });
              },
            ),
            title: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10), //apply padding to some sides only
                    child: Text(todoData.title),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10), //apply padding to some sides only
                    child: Text(
                      todoData.description,
                      style:
                          const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10), //apply padding to some sides only
                    child: Text(
                      formatDate(formatter, todoData.getDateTime()),
                      style:
                          const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                    ),
                  ),
                ],
              ),
            ),
          )));
    } else {
      return const Divider(
        height: 0,
        thickness: 0,
      );
    }
  }
}
