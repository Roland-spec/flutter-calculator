import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  get math_expressions => null;

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _calculateResult() {
    try {
      setState(() {
        _result = _evaluateExpression(_expression);
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  String _evaluateExpression(String expression) {
    
    try {
      // Use the math_expressions library to parse and evaluate the expression
      final parser = Parser();
      final parsedExpression = parser.parse(expression);
      final contextModel = ContextModel();
      final evaluatedExpression =
          parsedExpression.evaluate(EvaluationType.REAL, contextModel);
      return evaluatedExpression.toString();
    } catch (e) {
      return 'Error';
    }
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression.isEmpty ? 'Enter an expression' : _expression,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _result.isEmpty ? 'Result' : _result,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('+'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('/'),
            ],
          ),
          Row(
            children: [
              _buildButton('C'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: FilledButton(
        onPressed: () {
          if (text == '=') {
            _calculateResult();
          } else if (text == 'C') {
            _clearExpression();
          } else {
            _addToExpression(text);
          }
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
