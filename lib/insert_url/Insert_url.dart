import 'package:flutter/material.dart';
import 'package:simple_spotify_parser/home/home.dart';

class InsertUrl extends StatelessWidget {
  InsertUrl({Key? key}) : super(key: key);

  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parser App')),
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
                    builder: (context) => Home(
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
