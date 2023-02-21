import 'package:flutter/material.dart';
import 'block.dart';
import 'counter_event.dart';
import 'counter_state.dart';

// HomePage class
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final CounterBlock block = CounterBlock();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // we are using streamBuilder which will be build each time something is sinked(added) into stream
      body: StreamBuilder<CounterState>(
        // the stream to which we want to listen
        stream: block.stateStream,
        builder: (context, snapshot) {
          // check if the connection to stream is done or not.
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Text(
                // Using snapshot data the data here is CounterState object as stream is of type CounterState
                // and inside that we can access count variable to get value
                snapshot.data!.count.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            );
          } else {
            return Center(
              child: Text(
                block.counterState.count.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            );
          }
        },
      ),
      // Floating action button, there will be three buttons in row to support increment,decrement,reset operations
      floatingActionButton: buildFloatingButtonRow(block),
    );
  }
}

// A function which will return floating buttons row
Row buildFloatingButtonRow(CounterBlock block) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(child: Container()),
      // Floating action button for IncrementCounterEvent() operation
      Expanded(
        child: FloatingActionButton(
          onPressed: () {
            // here UI is sinking an event to stream which is listen by block and block will
            // perform the function passed to listen and add update to stream the UI will be updated as
            // the stream builder will build again because it gets new data
            block.eventSink.add(
              IncrementCounterEvent(),
            );
          },
          child: const Icon(Icons.arrow_upward_sharp),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      // floating action button for decrement operation
      Expanded(
        child: FloatingActionButton(
          onPressed: () {
            block.eventSink.add(
              DecrementCounterEvent(),
            );
          },
          child: const Icon(Icons.arrow_downward_sharp),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      // floating action button for reset operation
      Expanded(
        child: FloatingActionButton(
          onPressed: () {
            block.eventSink.add(
              ResetCounterEvent(),
            );
          },
          child: const Icon(Icons.restore_rounded),
        ),
      ),
      Expanded(child: Container()),
    ],
  );
}
