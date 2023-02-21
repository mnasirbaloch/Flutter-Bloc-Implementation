import 'dart:async';

import 'package:flutter_block_vanilla/counter_event.dart';
import 'package:flutter_block_vanilla/counter_state.dart';

// Block listen to stream which is used by UI to push task in and according to passed argument
// will execute the operation and sink the output in state stream listen by UI
class CounterBlock {
  // StreamController of Type CounterEvent which will be used by UI to sink event in so that bloc can listen to it.
  final StreamController<CounterEvent> _eventStreamController =
      StreamController();
  // StreamController of type CounterState in which block will push data and UI will listen and update itself accordingly
  final StreamController<CounterState> _stateStreamController =
      StreamController();
  // CounterState object, the CounterState is Immutable class so each time new object will be created instead of modifiy existing object
  late CounterState counterState;
  // The constructor of CounterBlock in which we initialize the counterState and listen to the stream of type CountEvent
  // so that when-ever UI add event in that stream the block listen to it and respond accordignly
  CounterBlock() {
    counterState = const CounterState(count: 0);
    // A function which will be executed each time an event from UI is added using sink into EventStream
    _eventStreamController.stream.listen(mapEventToState);
  }
// returning StreamSink of CounterEvent so that the UI can add event in this stream
  StreamSink<CounterEvent> get eventSink => _eventStreamController.sink;
// returning the stream object so that the UI can listen to that stream and when-ever block add update in that stream
// UI listen to it and respond accordingly
  Stream<CounterState> get stateStream => _stateStreamController.stream;
// A function which will be invoked each time an event is added by UI in Stream using sink
  void mapEventToState(CounterEvent event) {
    // CounterEvent contains three events as,
    // IncrementCounterEvent
    // DecrementCounterEvent
    // ResetCounterEvent
    // All these actions are basically instance of classes which are child of CounterEvent
    if (event is IncrementCounterEvent) {
      // create a new object of CounterState as it is immutable
      counterState = CounterState(count: counterState.count + 1);
      // add new object in stream so that UI can listen and repond accordingly
      _stateStreamController.sink.add(counterState);
    } else if (event is DecrementCounterEvent) {
      counterState = CounterState(count: counterState.count - 1);
      _stateStreamController.sink.add(counterState);
    } else {
      counterState = const CounterState(count: 0);
      _stateStreamController.sink.add(counterState);
    }
  }
}
