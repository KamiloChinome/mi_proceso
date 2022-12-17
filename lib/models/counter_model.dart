import 'package:flutter/material.dart';
class CounterModel with ChangeNotifier{
  String _counterLenght = '0';

  String get counterLenght => _counterLenght;
  set counterLenght(String i){
    _counterLenght = i;
    notifyListeners();
  }
}