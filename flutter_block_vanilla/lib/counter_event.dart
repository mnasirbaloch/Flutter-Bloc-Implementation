import 'package:flutter/material.dart';

// A class which contains sub-classes as the supported event. we can also use enum as well instead of abstrac class and sub-classes
@immutable
abstract class CounterEvent {}

// A class which represent the increment operation
@immutable
class IncrementCounterEvent extends CounterEvent {}

// A class representing decrement operaton
@immutable
class DecrementCounterEvent extends CounterEvent {}

// A class representing reset operation
@immutable
class ResetCounterEvent extends CounterEvent {}
