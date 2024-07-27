class Person {
  const Person({required this.firstname, required this.lastname});

  final String firstname;
  final String lastname;

  String get name => '$firstname $lastname';

  @override
  String toString() {
    return name;
  }
}
