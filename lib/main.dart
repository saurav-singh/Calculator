import 'package:flutter/material.dart';
import 'calculate.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          // Display Numbers
          SizedBox(
              height: 100.0,
              child: Column(
                children: [Text(query), Text(result)],
              )),

          // Display Buttons
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Table(
                children: [
                  TableRow(children: [
                    button("1"),
                    button("2"),
                    button("3"),
                    button("*")
                  ]),
                  TableRow(children: [
                    button("4"),
                    button("5"),
                    button("6"),
                    button("-")
                  ]),
                  TableRow(children: [
                    button("7"),
                    button("8"),
                    button("9"),
                    button("+")
                  ]),
                  TableRow(children: [
                    button("C"),
                    button("0"),
                    button("."),
                    button("/")
                  ]),
                  TableRow(children: [
                    Container(),
                    Container(),
                    Container(),
                    button("="),
                  ])
                ],
              ),
            ),
          )
        ]));
  }

  // Widgets for the UI

  Widget button(String value) => Container(
        padding: EdgeInsets.all(5.0),
        height: 80,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
}
