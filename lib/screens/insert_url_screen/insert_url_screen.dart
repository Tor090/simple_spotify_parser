import 'package:flutter/material.dart';
import 'package:simple_spotify_parser/screens/screens.dart';

class InsertUrlScreen extends StatelessWidget {
  InsertUrlScreen({Key? key}) : super(key: key);

  TextEditingController urlController = TextEditingController(
      text: 'https://open.spotify.com/album/1qwlxZTNLe1jq3b0iidlue');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parser App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: urlController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Input url'),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (urlController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Field is empty')));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          url: urlController.text,
                        )));
              }
            },
            child: const Text('Parse url'),
          )
        ],
      ),
    );
  }
}
