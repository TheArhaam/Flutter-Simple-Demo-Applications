import 'package:flutter/material.dart';

void main() {
  runApp(Example());
}

class Example extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExampleState();
  }
}

class ExampleState extends State<Example> {
  List<String> item = List();
  String temp;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ADD DATA TO LISTVIEW'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            TextField(
              onChanged: (str) {
                temp = str;
              },
              maxLength: 20,
            ),
            RaisedButton(
              child: Text('SUBMIT'),
              onPressed: () {
                setState(() {
                  item.add(temp);
                });
              },
            ),
            ListView(
              shrinkWrap: true,
              children: item.map((element) => Text(element)).toList(),
            )
          ],
        ),
      ),
    );
  }
}
