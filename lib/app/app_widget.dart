import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Beauty Salon Appointment',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color.fromRGBO(240, 98, 146, 1),
          secondary: const Color.fromRGBO(105, 239, 173, 1)
        )
      ),
      initialRoute: '/home',
    ).modular();
  }
}