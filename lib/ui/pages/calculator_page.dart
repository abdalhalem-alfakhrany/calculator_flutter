import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_tree/function_tree.dart';
import 'package:simple_calculator/ui/constances/enums.dart';
import 'package:simple_calculator/ui/logic/cubit/theme_cubit.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  bool isEvaluated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              print(state.theme);
              return IconButton(
                onPressed: () {
                  if (state.theme == AppTheme.dark) {
                    BlocProvider.of<ThemeCubit>(context)
                        .changeTheme(AppTheme.light);
                  } else {
                    BlocProvider.of<ThemeCubit>(context)
                        .changeTheme(AppTheme.dark);
                  }
                },
                icon: Icon(
                  state.theme == AppTheme.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _expressionDisplay(),
          SizedBox(
            height: 50,
          ),
          _numPad(),
        ],
      ),
    );
  }

  _expressionDisplay() => Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                _expression,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      );

  _numPad() {
    var pad = [
      ['Delete', 'Clear', '+'],
      ['7', '8', '9', '-'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '/'],
      ['=', '.', '^'],
    ];

    var notExpandable = ['.', '^', '+'];

    List<Widget> buttonsColumns = [];
    pad.forEach(
      (numbersRow) {
        List<Widget> buttonsRow = [];
        numbersRow.forEach(
          (number) {
            var button = Container(
              margin: EdgeInsets.all(10),
              child: OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                ),
                onPressed: () => _operation(number),
                child: Text(number),
              ),
            );

            if (notExpandable.indexOf(number) == -1) {
              buttonsRow.add(Expanded(child: button));
            } else {
              buttonsRow.add(button);
            }
          },
        );
        buttonsColumns.add(Row(children: buttonsRow));
      },
    );

    return Column(children: buttonsColumns);
  }

  void _delete() {
    setState(() {
      var listOfChars = _expression.split("");
      listOfChars.removeLast();
      _expression = listOfChars.join();
    });
  }

  void _evaleuate() {
    setState(() {
      _expression = _expression.interpret().toString();
      isEvaluated = true;
    });
  }

  void _append(number) {
    setState(() {
      if (isEvaluated) {
        _clear();
        isEvaluated = false;
      }
      _expression += number;
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
    });
  }

  _operation(number) {
    switch (number) {
      case 'Delete':
        _delete();
        break;
      case 'Clear':
        _clear();
        break;
      case '=':
        _evaleuate();
        break;
      default:
        _append(number);
    }
  }
}
