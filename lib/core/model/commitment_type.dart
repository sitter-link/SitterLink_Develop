class CommitmentType {
  final String name;
  final int id;

  CommitmentType({required this.name, required this.id});

  factory CommitmentType.fromMap(Map<String, dynamic> map) {
    return CommitmentType(
      name: map['name'],
      id: map['id'],
    );
  }
}
