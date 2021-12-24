import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Beauty Salon Appointment',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Color.fromRGBO(240, 98, 146, 1),
          secondary: Color.fromRGBO(105, 239, 173, 1)
        )
      ),
    ).modular();
  }
}