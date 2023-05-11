import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String input = "0";
  String answer = "";
  String expression = "";
  double inputSize = 38.0;
  double answerSize = 48.0;

  buttonHit(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        input = "0";
        answer = "";
        inputSize = 48.0;
        answerSize = 38.0;
      } else if (buttonText == "C") {
        inputSize = 48.0;
        answerSize = 38.0;
        input = input.substring(0, input.length - 1);
        if (input == "") {
          input = "0";
        }
      } else if (buttonText == "=") {
        inputSize = 38.0;
        answerSize = 48.0;

        expression = input;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          answer = '${exp.evaluate(EvaluationType.REAL, cm)}';
          var myDouble = double.parse(answer);
          answer =
              myDouble.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
        } catch (e) {
          answer = "Invalid Expression";
        }
      } else {
        inputSize = 48.0;
        answerSize = 38.0;
        if (input == "0") {
          input = buttonText;
        } else {
          input = input + buttonText;
        }
      }
    });
  }

  Widget calcButton(String buttonText, Color buttonColor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 5, 7, 0),
      height: MediaQuery.of(context).size.height * 0.1,
      child: FlatButton(
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          padding: const EdgeInsets.all(16.0),
          onPressed: () => buttonHit(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BSCS20004 Calculator')),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              input,
              style: TextStyle(fontSize: inputSize, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(136, 50, 50, 50),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: Text(
              answer,
              style: TextStyle(fontSize: answerSize, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(children: [
                      calcButton("C", const Color.fromARGB(255, 86, 86, 86)),
                      calcButton("%", const Color.fromARGB(255, 86, 86, 86)),
                      calcButton("AC", const Color.fromARGB(255, 86, 86, 86)),
                      calcButton("÷", const Color.fromARGB(255, 86, 86, 86)),
                    ]),
                    TableRow(children: [
                      calcButton("7", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("8", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("9", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("×", const Color.fromARGB(255, 86, 86, 86)),
                    ]),
                    TableRow(children: [
                      calcButton("4", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("5", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("6", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("-", const Color.fromARGB(255, 86, 86, 86)),
                    ]),
                    TableRow(children: [
                      calcButton("1", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("2", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("3", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("+", const Color.fromARGB(255, 86, 86, 86)),
                    ]),
                    TableRow(children: [
                      calcButton("00", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("0", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton(".", const Color.fromARGB(137, 30, 30, 30)),
                      calcButton("=", Colors.orangeAccent),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
