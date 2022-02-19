import 'package:flutter/material.dart';
import 'package:todo_app/Constants/ApiUrl.dart';
import 'package:todo_app/Models/todoData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo_app/Widgets/AppBar.dart';
import 'package:todo_app/Widgets/TodoContainer.dart';

class HomeUtils {
  Future<List<Todo>> fetchData() async {
    List<Todo> todoList = [];
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
      return todoList;
    } catch (e) {
      print("Error is $e");
    }
    return todoList;
  }

  Future<void> postData({String title = "", String desc = ""}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"title": title, "desc": desc, "isDone": false}),
      );
      if (response.statusCode == 201) {
        fetchData();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Error is $e");
    }
  }

  Future<void> DeleteATodo(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + id));
      fetchData();
    } catch (e) {
      print("Error is $e");
    }
  }
}
