import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  void _showDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate:
          DateFormat.yMMMMd().parse(DateFormat.yMMMMd().format(DateTime(2001,7,9))),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontFamily: 'ProductSans')),
      ),
      body: const Center(
        child: Text('Click the button to show date picker.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDatePicker,
        tooltip: 'Show date picker',
        child: const Icon(Icons.edit_calendar),
      ),
    );
  }}