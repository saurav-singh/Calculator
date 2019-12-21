import 'package:flutter/material.dart';
import 'package:stack/stack.dart' as _Stack;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String query = "";
  String result = "";

  Widget button(String value) => Container(
        padding: EdgeInsets.all(10.0),
        width: 80,
        height: 80,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          onPressed: () {
            setState(() {
              if (value == "C") {
                query = "";
              } else {
                query += value;
                result = calculate(query);
              }
            });
          },
          child: Text(
            value,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.lightBlueAccent),
              width: 300,
              height: 40,
              child: Text(query, style: TextStyle(fontSize: 20.0))),
          Text(result, style: TextStyle(fontSize: 20.0)),
          Row(children: [button("7"), button("8"), button("9"), button("+")]),
          Row(children: [button("4"), button("5"), button("6"), button("-")]),
          Row(children: [button("1"), button("2"), button("3"), button("*")]),
          Row(children: [button("C"), button("0"), button("."), button("/")]),
          Row(
            children: [button("=")],
          )
        ],
      ),
    );
  }
}

// TEMP CALCULATION FUNCTIONS - put to a class

String calculate(String query) {
  String result = "";
  if (query.contains("+") ||
      query.contains("-") ||
      query.contains("*") ||
      query.contains("/")) {
    query = processQuery(query);
    query = getPostfix(query);
    try {
      result = getResult(query);
    } catch (error) {
      return "err";
    }
  }
  return result;
}

String processQuery(String query) {
  String newQuery = "";
  String operators = "+-*/";
  for (int i = 0; i < query.length; i++) {
    if (operators.contains(query[i]))
      newQuery += " " + query[i] + " ";
    else
      newQuery += query[i];
  }
  return newQuery.trimRight();
}

String getPostfix(String infix) {
  _Stack.Stack<String> stack = _Stack.Stack();
  String postfix = "";
  String operators = "+-*/";
  Map order = {"+": 1, "-": 1, "*": 2, "/": 2, "(": 3, ")": 3};
  List<String> tokens = infix.split(" ");

  for (int i = 0; i < tokens.length; i++) {
    if (operators.contains(tokens[i])) {
      while (stack.isNotEmpty && order[stack.top()] >= order[tokens[i]]) {
        postfix += stack.pop() + " ";
      }
      stack.push(tokens[i]);
    } else if (tokens[i] == "(")
      stack.push(tokens[i]);
    else if (tokens[i] == ")") {
      while (true) {
        String operator = stack.pop();
        postfix += operator + " ";
        if (operator == "(" || stack.isEmpty) break;
      }
    } else {
      postfix += tokens[i] + " ";
    }
  }

  while (stack.isNotEmpty) postfix += stack.pop() + " ";

  return postfix.trimRight();
}

String getResult(String query) {
  _Stack.Stack<double> stack = _Stack.Stack();
  List<String> tokens = query.split(" ");
  String operators = "+-*/";

  if (tokens.length < 2 && tokens.length % 2 == 0) return "0";
  for (int i = 0; i < tokens.length; i++) {
    if (operators.contains(tokens[i])) {
      double x = stack.pop();
      double y = stack.pop();
      if (tokens[i] == "+")
        stack.push(x + y);
      else if (tokens[i] == "-")
        stack.push(y - x);
      else if (tokens[i] == "*")
        stack.push(x * y);
      else if (tokens[i] == "/") stack.push(y / x);
    } else {
      stack.push(double.parse(tokens[i]));
    }
  }
  return stack.pop().toString();
}
