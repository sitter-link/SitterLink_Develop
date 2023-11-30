import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String shortName;
  final String name;

  const City({required this.shortName, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shortName': shortName,
      'name': name,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      shortName: map['short_name'],
      name: map['city'],
    );
  }

  @override
  List<Object?> get props => [shortName, name];
}

extension CityExtension on List<City> {
  City? findCityWith(String? city) {
    final index = indexWhere((e) => e.shortName == city);
    if (index != -1) {
      return this[index];
    } else {
      return null;
    }
  }
}
