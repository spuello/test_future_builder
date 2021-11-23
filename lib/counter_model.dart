import 'package:flutter/cupertino.dart';

class CounterModel extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2), () {
      count = 10;
      notifyListeners();
    });
  }

  void add(int parse) {
    count += parse;
    print("[counter_model.dart] count: ${count}");
    notifyListeners();
  }
}
