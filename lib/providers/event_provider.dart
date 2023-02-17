// EventProvider (Stream)
class EventProvider {
  Stream<int> intStream() {
    Duration interval = const Duration(seconds: 1);
    return Stream<int>.periodic(interval, (int count) => count++);
  }
}
