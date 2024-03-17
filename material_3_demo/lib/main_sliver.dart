import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return secondRoute();
  }

  Widget secondRoute() {
    return Scaffold(
      body: Stack(children: [
        CustomScrollView(
          cacheExtent: 9999,
          slivers: [
            SliverAppBar(
              actions: [],
              title: Text('Action ', textScaler: const TextScaler.linear(5)),
            ),

            //Text('Action '),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 422.0,
                    child: Center(
                      child: Text('$index',
                          textScaler: const TextScaler.linear(5)),
                    ),
                  );
                },
                childCount: 5,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
