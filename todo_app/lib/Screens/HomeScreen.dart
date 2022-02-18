import 'package:flutter/material.dart';
import 'package:todo_app/Constants/ApiUrl.dart';
import 'package:todo_app/Models/todoData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_app/Widgets/AppBar.dart';
import 'package:todo_app/Widgets/TodoContainer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: isLoading
          ? CircularProgressIndicator()
          : ListView(
              children: todoList.map((e) {
                return TodoContainer(
                  id: e.id,
                  title: e.title,
                  desc: e.desc,
                  isDone: e.isDone,
                );
              }).toList(),
            ),
    );
  }
}
