import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_spotify_parser/html_service/html_service.dart';
import 'package:simple_spotify_parser/screens/screens.dart';

GetIt getIt = GetIt.instance;
void main() {
  getIt.registerLazySingleton<HtmlService>(() => HtmlService());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: InsertUrlScreen());
  }
}
