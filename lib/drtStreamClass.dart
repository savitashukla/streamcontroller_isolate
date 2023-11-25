import 'dart:async';

class CounterBloc {

  final _counterController = StreamController<int>();

  Stream<int> get counterStream => _counterController.stream;

    void incrementCounter(int stri) {
    _counterController.sink.add(stri);
  }

  void dispose() {
    _counterController.close();
  }
}