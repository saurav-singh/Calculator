import 'package:flutter/material.dart';
import 'calculate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(children: [
      // Display Numbers
      Container(
          height: 300.0,
          width: _width,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90.0),
          ),
          child: viewNumbers(query, result)),

      // Display Buttons
      Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Table(
            children: [
              TableRow(children: [
                button("1"),
                button("2"),
                button("3"),
                button("×")
              ]),
              TableRow(children: [
                button("4"),
                button("5"),
                button("6"),
                button("÷")
              ]),
              TableRow(children: [
                button("7"),
                button("8"),
                button("9"),
                button("-")
              ]),
              TableRow(children: [
                button("C"),
                button("0"),
                button("."),
                button("+")
              ]),
            ],
          ),
        ),
      ),

      // Equals button
      Container(
        width: _width,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
        child: button("="),
      )
    ]));
  }

/*
 * UI Widgets
**/
  Widget viewNumbers(String query, String result) {
    return Stack(
      children: [
        Positioned(
          bottom: 120,
          right: 0,
          child: Text(
            query,
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 0,
          child: Text(
            result,
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent),
          ),
        )
      ],
    );
  }

  Widget button(String value) => Container(
        height: 75.0,
        width: 295.0,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: RaisedButton(
          color: Colors.white,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          onPressed: () {
            setState(() {
              if (value == "C") {
                query = "";
                result = "";
              } else if (value == "=") {
                query = result;
                result = "";
              } else if (query.length < 15) {
                query += value;
                String prev = result;
                result = calculate(query);
                result = result == "err" ? prev : result;
              }
            });
          },
          child: Text(
            value,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
}
