import 'package:flutter/material.dart';

Widget button(String value, Function func) => Container(
      padding: EdgeInsets.all(10.0),
      child: RaisedButton(
        onPressed: func(value),
        child: Text(
          value,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
