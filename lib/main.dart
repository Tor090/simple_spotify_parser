import 'package:flutter/material.dart';
import 'package:simple_spotify_parser/insert_url/Insert_url.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: InsertUrl());
  }
}
