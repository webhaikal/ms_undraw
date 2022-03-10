import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  Color color = Colors.red;
  UnDrawIllustration illustration = UnDrawIllustration.mobile_application;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.color_lens),
        onPressed: () {
          setState(() {
            color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                .withOpacity(1.0);
          });
        },
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1024
          ),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                  mainAxisExtent: 285,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 4))
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(UnDrawIllustration.values[index].name
                          .replaceAll('_', ' ')
                          .trim()
                          .split(' ')
                          .map((e) =>
                              "${e[0].toUpperCase()}${e.substring(1).toLowerCase()}")
                          .toList()
                          .join(' ')
                          .trim()),
                      SizedBox(
                        // height: 220+67,
                        child: Center(
                          child: UnDraw(
                            color: color,
                            useMemCache: false,
                            height: 200,
                            width: 200,
                            illustration: UnDrawIllustration.values[index],
                            placeholder: const Text("Illustration is loading..."),
                            errorWidget: const Icon(Icons.error_outline,
                                color: Colors.red, size: 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: UnDrawIllustration.values.length),
        ),
      ),
    );
  }
}
