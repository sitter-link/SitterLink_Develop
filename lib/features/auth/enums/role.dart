// ignore_for_file: constant_identifier_names

enum Role {
  Nanny(value: "Nanny", shortValue: "N"),
  Parent(value: "Parent", shortValue: "P");

  final String value;
  final String shortValue;

  const Role({
    required this.value,
    required this.shortValue,
  });

  factory Role.fromString(String val) {
    if (val == Role.Nanny.value || val == Role.Nanny.shortValue) {
      return Role.Nanny;
    } else {
      return Role.Parent;
    }
  }
}
