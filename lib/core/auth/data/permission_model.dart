import 'package:matger_core_logic/models/entity_meta.dart';

enum PermissionType {
  read,
  write,
  delete,
  update,
  admin,
  manage,
  stream;

  static PermissionType fromString(String value) {
    return PermissionType.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => PermissionType.read,
    );
  }
}

enum ResourceType {
  user,
  role,
  permission,
  book,
  product,
  category,
  system,
  order,
  all;

  static ResourceType fromString(String value) {
    if (value == '*') return ResourceType.all;
    return ResourceType.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => ResourceType.all,
    );
  }

  String toRawString() {
    if (this == ResourceType.all) return '*';
    return name;
  }
}

class PermissionModel {
  final String id;
  final String name;
  final String? description;
  final PermissionType type;
  final ResourceType resource;
  final Map<String, dynamic>? conditions;
  final bool isActive;
  final EntityMeta? meta;

  PermissionModel({
    required this.id,
    required this.name,
    required this.type,
    required this.resource,
    this.description,
    this.conditions,
    this.isActive = true,
    this.meta,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      type: PermissionType.fromString(json['type'] as String? ?? 'read'),
      resource: ResourceType.fromString(json['resource'] as String? ?? '*'),
      conditions: json['conditions'] as Map<String, dynamic>?,
      isActive: json['isActive'] as bool? ?? true,
      meta: json['meta'] != null ? EntityMeta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.name,
      'resource': resource.toRawString(),
      'conditions': conditions,
      'isActive': isActive,
      'meta': meta?.toJson(),
    };
  }

  String get permissionKey => "${resource.toRawString()}:${type.name}";
}
