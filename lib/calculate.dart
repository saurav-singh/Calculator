import 'package:stack/stack.dart' as _Stack;

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

// class Calculate {

//   String query;
//   String result;

//   Calculate(){
//     query = "0";
//     result = "0";
//   }

//   void setQuery(String query) {
//     print(query);
//     this.query = query;
//   }

// }
