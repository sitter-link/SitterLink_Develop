// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:nanny_app/features/auth/enums/role.dart';

class User extends Equatable {
  final int id;
  final String fullName;
  final String phone;
  final Role role;
  final bool hasUserProfile;
  final String avatar;

  const User({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.hasUserProfile,
    required this.avatar,
  });

  @override
  List<Object?> get props =>
      [id, fullName, phone, role, hasUserProfile, avatar];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullName,
      'phone_number': phone,
      'role': role.name,
      "has_user_profile": hasUserProfile,
      "avatar": avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['fullname'] ?? "",
      phone: map['phone_number'] ?? "",
      role: Role.fromString(map["user_role"] ?? map["role"] ?? ""),
      hasUserProfile: map["has_user_profile"] ?? false,
      avatar: map["avatar"] ?? "",
    );
  }

  User copyWith({
    int? id,
    String? fullName,
    String? phone,
    Role? role,
    bool? hasUserProfile,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      hasUserProfile: hasUserProfile ?? this.hasUserProfile,
      avatar: avatar ?? this.avatar,
    );
  }
}
