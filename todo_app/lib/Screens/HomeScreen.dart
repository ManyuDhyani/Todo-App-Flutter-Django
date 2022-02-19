import 'package:flutter/material.dart';
import 'package:todo_app/Constants/ApiUrl.dart';
import 'package:todo_app/Models/todoData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo_app/Widgets/AppBar.dart';
import 'package:todo_app/Widgets/TodoContainer.dart';
import 'package:todo_app/Utils/HomeUtils.dart';

HomeUtils homeUtilsFunction = HomeUtils();

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int workDone = 0;
  List<Todo> todoList = [];
  bool isLoading = true;

  void _showModal() {
    String title = "";
    String desc = "";
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          color: const Color(0xFF405173),
          child: Column(
            children: [
              const Text(
                "Add your Todo Task",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF001133),
                      ),
                    ),
                    labelText: "Task",
                    labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF001133),
                      ),
                    ),
                    labelText: "Description",
                    labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                    //   hintText: "Description",
                    //   hintStyle:
                    //       TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      desc = value;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF001133))),
              )
            ],
          ),
        );
      },
    );
  }

  final colorList = <Color>[
    const Color(0xFF001133),
    const Color(0xFFeeb714),
  ];

  @override
  void initState() {
    homeUtilsFunction.fetchData().then((value) {
      setState(() {
        todoList = value;
        isLoading = false;
      });
    });
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
                            onPressDelete: () =>
                                homeUtilsFunction.DeleteATodo(e.id.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //elevation: 4.0,
        onPressed: () {
          _showModal();
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
