import 'package:flutter/material.dart';

// A class actually the state which will be changes on user interaction
@immutable
class CounterState {
  // final field because class is immutable
  final int count;
  const CounterState({required this.count});
}
