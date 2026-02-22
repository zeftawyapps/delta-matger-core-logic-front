import 'package:matger_core_logic/models/entity_meta.dart';

class UserDataDetailsModel {
  final String userId;
  final String username;
  final String email;
  final List<String> roles;
  final String? address;
  final String phone;
  final String? organizationId;
  final DateTime? dateOfBirth;
  final String? bio;
  final String? avatarUrl;
  final Map<String, dynamic> additionalInfo;
  final EntityMeta? meta;

  UserDataDetailsModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    this.roles = const ['user'],
    this.address,
    this.organizationId,
    this.dateOfBirth,
    this.bio,
    this.avatarUrl,
    this.additionalInfo = const {},
    this.meta,
  });

  factory UserDataDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDataDetailsModel(
      userId: json['userId'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      roles:
          (json['roles'] as List?)?.map((e) => e.toString()).toList() ??
          ['user'],
      address: json['address'] as String?,
      organizationId: json['organizationId'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'].toString())
          : null,
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>? ?? {},
      meta: json['meta'] != null ? EntityMeta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'phone': phone,
      'roles': roles,
      'address': address,
      'organizationId': organizationId,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'bio': bio,
      'avatarUrl': avatarUrl,
      'additionalInfo': additionalInfo,
      'meta': meta?.toJson(),
    };
  }
}

class UserModel {
  final String username;
  final String email;
  final String name;
  final String phone;
  final bool isEmailVerified;
  final bool isActive;
  final String? organizationId;
  final List<String> roles;
  final UserDataDetailsModel? otherData;
  final EntityMeta? meta;

  UserModel({
    required this.username,
    required this.email,
    required this.name,
    required this.phone,
    this.isEmailVerified = false,
    this.isActive = true,
    this.organizationId,
    this.roles = const ['user'],
    this.otherData,
    this.meta,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      organizationId: json['organizationId'] as String?,
      roles:
          (json['roles'] as List?)?.map((e) => e.toString()).toList() ??
          ['user'],
      otherData: json['otherData'] != null
          ? UserDataDetailsModel.fromJson(
              json['otherData'] as Map<String, dynamic>,
            )
          : null,
      meta: json['meta'] != null ? EntityMeta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      'isActive': isActive,
      'organizationId': organizationId,
      'roles': roles,
      'otherData': otherData?.toJson(),
      'meta': meta?.toJson(),
    };
  }
}
