import 'package:flutter/material.dart';

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
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // Variables for the calculator logic
  String displayText = '';  // Display full expression
  double firstNum = 0;      // First number in operation
  double secondNum = 0;     // Second number in operation
  String operation = '';    // Store operation (e.g., +, -, *, /)
  String result = '';       // Final result

  // Function to handle button press logic
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        displayText = '';
        firstNum = 0;
        secondNum = 0;
        operation = '';
        result = '';
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        firstNum = double.parse(displayText);
        operation = buttonText;
        displayText += buttonText;
      } else if (buttonText == '=') {
        List<String> parts = displayText.split(RegExp(r'(\+|\-|\*|\/)'));
        secondNum = double.parse(parts[1]);

        if (operation == '+') {
          result = (firstNum + secondNum).toString();
        } else if (operation == '-') {
          result = (firstNum - secondNum).toString();
        } else if (operation == '*') {
          result = (firstNum * secondNum).toString();
        } else if (operation == '/') {
          result = (firstNum / secondNum).toString();
        }
        displayText = result;
        operation = '';
      } else if (buttonText == '+/-') {
        displayText = (double.parse(displayText) * -1).toString();
      } else if (buttonText == '%') {
        displayText = (double.parse(displayText) / 100).toString();
      } else if (buttonText == '.') {
        if (!displayText.contains('.')) {
          displayText += '.';
        }
      } else {
        displayText += buttonText;  // Append to displayText
      }
    });
  }

  // Button widget
  Widget calcButton(String btnTxt, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () => buttonPressed(btnTxt),
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        padding: const EdgeInsets.all(20),
        shape: CircleBorder(),
      ),
      child: Text(
        btnTxt,
        style: TextStyle(
          fontSize: 30,
          color: txtColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', const Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('8', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('9', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('*', const Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('5', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('6', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('-', const Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('2', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('3', const Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcButton('+', const Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => buttonPressed('0'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                calcButton('.', const Color.fromRGBO(255, 160, 0, 1), Colors.white),
                calcButton('=', const Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
