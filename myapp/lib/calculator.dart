import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// Calculator Page Widget
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

// State class for the Calculator Page
class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';
  double? _result;

  // Function to handle digit button presses
  void _onDigitPressed(String digit) {
    setState(() {
      _input += digit;
    });
  }

  // Function to handle 'AC' button press (clear all)
  void _onAllClearPressed() {
    setState(() {
      _input = '';
      _result = null;
    });
  }

  // Function to handle 'C' button press (clear last entry)
  void _onClearPressed() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      } else {
        _input = '';
        _result = null;
      }
    });
  }

  // Function to handle operator button presses
  void _onOperatorPressed(String operator) {
    if (_result != null) {
      // If there is a result, set input to the result and clear the result
      _input = '$_result$operator';
      _result = null;
    } else if (_input.isNotEmpty) {
      // Check if there is already an operator in the input
      if (_input.endsWith('+') ||
          _input.endsWith('-') ||
          _input.endsWith('x') ||
          _input.endsWith('/')) {
        // Replace the last operator with the new one
        _input = _input.substring(0, _input.length - 1) + operator;
      } else {
        // If there is no operator at the end, append the new operator
        _input += operator;
      }
    }
  }


// Function to handle '=' button press (evaluate the expression)
  void _onEqualPressed() {
    try {
      if (_input.isNotEmpty && _isValidExpression()) {

        Parser p = Parser();
        ContextModel cm = ContextModel();
        Expression exp = p.parse(_input);
        double evalResult = exp.evaluate(EvaluationType.REAL, cm);

        print('Expression: $_input');
        print('Sanitized Expression: $_input');
        print('Result: $evalResult');

        setState(() {
          _result = evalResult;
          _input = '$_result';
        });
      }
    } catch (e) {
      print('Error during expression evaluation: $e');
      setState(() {
        _result = null;
      });
    }
  }


// Function to validate the expression before evaluation
  bool _isValidExpression() {
    try {
      Parser().parse(_input);
      return true;
    } catch (e) {
      print('Invalid expression: $_input');
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    // Scaffold configuration for the Calculator Page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // Display input expression
                  Text(
                    _input,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  // Display result if available
                  if (_result != null)
                    Text(
                      '= $_result',
                      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: Column(
              children: [
                // Rows of calculator buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCalculatorButton('AC'),// Clear all button
                    _buildCalculatorButton('C'),// Clear last entry button
                    _buildCalculatorButton('%'),// Percentage button
                    _buildCalculatorButton('/'),// Division button
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCalculatorButton('7'),
                    _buildCalculatorButton('8'),
                    _buildCalculatorButton('9'),
                    _buildCalculatorButton('*'),// Multiplication button
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCalculatorButton('4'),
                    _buildCalculatorButton('5'),
                    _buildCalculatorButton('6'),
                    _buildCalculatorButton('-'),// Subtraction button
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCalculatorButton('1'),
                    _buildCalculatorButton('2'),
                    _buildCalculatorButton('3'),
                    _buildCalculatorButton('+'),// Addition button
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCalculatorButton('0'),
                    _buildCalculatorButton('.'),
                    _buildCalculatorButton('='),// Equal button
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build calculator buttons
  Widget _buildCalculatorButton(String buttonContent) {
    double buttonWidth = buttonContent == '0' ? 2.0 : 1.0;

    return Expanded(
      flex: buttonWidth.toInt(),
      child: ElevatedButton(
        // Button press handling based on button content
        onPressed: () {
          if (buttonContent == '=') {
            _onEqualPressed();
          } else if (buttonContent == 'C') {
            _onClearPressed();
          } else if (buttonContent == 'AC') {
            _onAllClearPressed();
          } else {
            _onDigitPressed(buttonContent);
          }
        },
        child: Text(
          buttonContent,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

}
