Future<void> tick(int duration) async {
  await Future.delayed(Duration(microseconds: duration));
}
