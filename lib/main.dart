import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new ToDoList(title: 'ToDo List'),
    );
  }
}

class ToDoList extends StatefulWidget {
  ToDoList({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  ToDoListState createState() => new ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  List<String> items = [];

  void addNewItem(String task){
    setState(() => items.add(task));
  }

  Widget buildToDoList() {
    return new ListView.builder(
      itemBuilder: (context, index){
        if (index < items.length){
          return buildToDoItem(items[index], index);
        }
      }
    );
  }

  Widget buildToDoItem(String todoitem, int index){
    return new ListTile(
      title: new Text(todoitem),
      onTap: () => promptRemoveItem(index),
      );
  }

  void pushAddTodoScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Add a new Task")
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted:(val) {
                addNewItem(val);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: 'Enter item...',
                contentPadding: const EdgeInsets.all(16.0)
              )
            )
          );
        }
      )
    );
  }

  void removeItem(int index){
    setState(() => items.removeAt(index));
  }

  void promptRemoveItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Mark "${items[index]}" as done?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('MARK AS DONE'),
              onPressed: () {
                removeItem(index);
                Navigator.of(context).pop();
              },
            )
          ]
        );
      }
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: buildToDoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: pushAddTodoScreen,
        tooltip: 'Add Task',
        child: new Icon(Icons.add)
      ),
    );
  }
}