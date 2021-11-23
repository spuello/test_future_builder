import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_future_builder/counter_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final counterProvider = CounterModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => counterProvider,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("TEST FUTURE BUILDER"),
        ),
        body: FutureBuilder(
            future: counterProvider.initialize(),
            builder: (context, snapshot) {
              print("[main.dart] snapshot: ${snapshot}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Consumer<CounterModel>(builder: (context, model, child) {
                      return Text(
                        'Count : '
                        '${model.count}',
                        style: const TextStyle(fontSize: 30),
                      );
                    }),
                    TextField(
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        print("[main.dart] value: ${value}");
                        counterProvider.add(int.parse(value));
                      },
                    ),
                  ],
                ),
              );
            }),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: counterProvider.increment,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: counterProvider.decrement,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _futureTest() async {
    await Future.delayed(const Duration(seconds: 10));
  }
}
