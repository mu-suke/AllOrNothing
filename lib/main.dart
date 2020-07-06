import 'package:all_or_nothing_slider/data/const_text.dart';
import 'package:all_or_nothing_slider/data/theme.dart';
import 'package:all_or_nothing_slider/login.dart';
import 'package:all_or_nothing_slider/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstText.appTitle,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ja', 'JP'),
      ],
      home: LoginPage(),
    );
  }
}
