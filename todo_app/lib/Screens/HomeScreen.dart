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
  final colorList = <Color>[
    const Color(0xFF001133),
    const Color(0xFFeeb714),
  ];
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

  void DeleteATodo(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + id));
      setState(() {
        todoList = [];
      });
      fetchData();
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
                      PieChart(
                        dataMap: {
                          "Complete": workDone.toDouble(),
                          "Incomplete": (todoList.length - workDone).toDouble()
                        },
                        colorList: colorList,
                        legendOptions: const LegendOptions(
                          legendTextStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Column(
                        children: todoList.map((e) {
                          return TodoContainer(
                            id: e.id,
                            title: e.title,
                            desc: e.desc,
                            isDone: e.isDone,
                            onPressDelete: () => DeleteATodo(e.id.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height / 2,
                color: const Color(0xFF405173),
                child: Column(),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF405173),
      ),
    );
  }
}
