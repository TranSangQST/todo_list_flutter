import 'package:flutter/material.dart';
import 'package:todo_list_flutter/TodoData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _todoInput = "";
  List<TodoData> _todoList = [];

  var txtTodoController = TextEditingController();

  void addTodo() {
    int len = _todoList.length;
    print('len: $len');
    final todo1 = TodoData(description: '$_todoInput');
    for (int i = 0; i < _todoList.length; i++) {
      String todoItem = _todoList[i].toString();
      print("todo $i: $todoItem");
    }
    setState(() {
      _todoInput = "";
    });

    txtTodoController.text = "";

    setState(() {
      _todoList.add(todo1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'TODO: $_todoInput',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              controller: txtTodoController,
              onChanged: (text) {
                setState(() {
                  _todoInput = text;
                });
              },
            ),
            Expanded(
              //        <-- Use Expanded
              child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const Icon(Icons.list),
                        trailing: const Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text(_todoList[index].toString()));
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        tooltip: 'Increment',
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class TodoList extends StatelessWidget {
//   const TodoList({super.key, List<TodoData> todoDatas: []});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 5,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//               leading: const Icon(Icons.list),
//               trailing: const Text(
//                 "GFG",
//                 style: TextStyle(color: Colors.green, fontSize: 15),
//               ),
//               title: Text("List item $index"));
//         });
//   }
// }
