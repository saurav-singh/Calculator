import 'package:stack/stack.dart' as _Stack;

/*
Map ( * -> × )
Map ( / -> ÷ )
*/

String operators = "+-×÷";
 _Stack.Stack<String> stack;

String calculate(String query) {
  String result = "";
  bool compute = false;

  // If the query contains operators then compute
  for (int i = 0; i < query.length; i++) {
    if (operators.contains(query[i])) {
      compute = true;
      break;
    }
  }

  // Preprocess then compute
  // Query -> Infix -> Postfix -> Result
  if (compute) {
    try {
      query = processQuery(query);
      query = getPostfix(query);
      result = getResult(query);
    } catch (error) {
      return "err";
    }
  }

  // Limit result length to max 7
  result = result.length > 7 ? result.substring(0, 7) : result;
  return result;
}

// Preprocess query -> infix
String processQuery(String query) {
  String newQuery = "";
  for (int i = 0; i < query.length; i++) {
    String c = query[i];
    newQuery += operators.contains(c) ? " " + c + " " : c;
  }
  return newQuery.trimRight();
}

// Preprocess infix -> postfix using stack
String getPostfix(String infix) {
  _Stack.Stack<String> stack = _Stack.Stack();
  String postfix = "";
  Map order = {"+": 1, "-": 1, "×": 2, "÷": 2, "(": 3, ")": 3};
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

// Compute postfix results using stack
String getResult(String query) {
  _Stack.Stack<double> stack = _Stack.Stack();
  List<String> tokens = query.split(" ");

  // Return 0 for invalid query
  if (tokens.length < 2 && tokens.length % 2 == 0) return "0";

  for (int i = 0; i < tokens.length; i++) {
    if (operators.contains(tokens[i])) {
      double x = stack.pop();
      double y = stack.pop();
      if (tokens[i] == "+")
        stack.push(x + y);
      else if (tokens[i] == "-")
        stack.push(y - x);
      else if (tokens[i] == "×")
        stack.push(x * y);
      else if (tokens[i] == "÷") stack.push(y / x);
    } else {
      stack.push(double.parse(tokens[i]));
    }
  }
  return stack.pop().toString();
}
