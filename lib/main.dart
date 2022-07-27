import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_calculator/ui/logic/cubit/theme_cubit.dart';
import 'package:simple_calculator/ui/pages/calculator_page.dart';
import 'package:simple_calculator/ui/themes/app_themes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Calculator',
            theme: themes[state.theme],
            home: CalculatorPage(),
          );
        },
      ),
    );
  }
}
