import 'package:flutter/material.dart';
import 'package:todo_app/Constants/ApiUrl.dart';
import 'package:todo_app/Models/todoData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo_app/Widgets/AppBar.dart';
import 'package:todo_app/Widgets/TodoContainer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int workDone = 0;
  List<Todo> todoList = [];
  bool isLoading = true;
  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(api));
      var data = json.decode(response.body);
      data.forEach((todo) {
        Todo i = Todo(
          id: todo['id'],
          title: todo['title'],
          desc: todo['desc'],
          isDone: todo['isDone'],
          date: todo['date'],
        );
        if (todo['isDone']) {
          workDone += 1;
        }
        todoList.add(i);
      });
      //print(todoList.length);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error is $e");
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF405173),
      appBar: customAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            isLoading
                ? Container(
                    padding: EdgeInsets.all(10),
                    // FOR bring the circle to center comment out padding and use below lines
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: [
                      PieChart(dataMap: {
                        "Done": workDone.toDouble(),
                        "Incomplete": (todoList.length - workDone).toDouble()
                      }),
                      Column(
                        children: todoList.map((e) {
                          return TodoContainer(
                            id: e.id,
                            title: e.title,
                            desc: e.desc,
                            isDone: e.isDone,
                          );
                        }).toList(),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
