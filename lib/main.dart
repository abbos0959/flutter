import 'package:flutter/material.dart';
import 'package:todo/expenses.dart';
import 'package:flutter/services.dart';

var kcolor = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 59, 207, 14),
);
var darkColor = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 9, 99, 125));
void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {});
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: darkColor,
          cardTheme: const CardTheme().copyWith(
            color: darkColor.secondaryContainer,
          )),
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kcolor,
          cardTheme: const CardTheme().copyWith(
              color: kcolor.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
          // appBarTheme: const AppBarTheme().copyWith(
          //     backgroundColor: kcolor.onPrimaryContainer,
          //     foregroundColor: kcolor.primaryContainer
          //     ),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  color: kcolor.onSecondaryContainer,
                  fontSize: 16,
                  fontWeight: FontWeight.normal))),
      home: const Expenses(),
    ),
  );
}
