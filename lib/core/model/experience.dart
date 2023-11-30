class Experience {
  final int id;
  final String name;
  final String value;

  Experience({
    required this.id,
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': name,
      'type_value': value,
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      id: map['id'],
      name: map['type'],
      value: map['type_value'],
    );
  }
}
