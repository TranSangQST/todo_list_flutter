import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_list_flutter/ClassData/TodoData.dart';

class TodoView extends StatefulWidget {
  TodoData todoData;

  Function handleRemoveTodo;
  TodoView({super.key, required this.todoData, required this.handleRemoveTodo});

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  String formatDate(DateFormat formatter, DateTime? dateTime) {
    if (dateTime != null) {
      return formatter.format(dateTime);
    } else {
      return "";
    }
  }

  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy: hh:mm:ss');

    if (widget.todoData.status) {
      return Card(
          elevation: 8.0,
          child: SizedBox(
              child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            leading: Checkbox(
              checkColor: Colors.white,
              value: !widget.todoData.status,
              onChanged: (bool? val) {
                widget.handleRemoveTodo(widget.todoData);
              },
            ),
            title: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(widget.todoData.title),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.todoData.description,
                      style:
                          const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      formatDate(formatter, widget.todoData.getDateTime()),
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
