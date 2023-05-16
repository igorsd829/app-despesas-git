import 'package:despessas/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(brightness: Brightness.light);
    return MaterialApp(
      // theme: tema.copyWith(
      //   colorScheme: tema.colorScheme.copyWith(
      //     primary: Colors.deepPurple,
      //     secondary: Colors.red,
      //   ),
      // ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: tema.copyWith(
        primaryColor: Colors.purple,
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.cyan,
          secondary: Colors.deepPurpleAccent,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
