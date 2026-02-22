import 'package:matger_core_logic/models/entity_meta.dart';

class CategoryData {
  final String categoryId;
  final String name;
  final String organizationId;
  final EntityMeta? meta;
  final String? description;
  final String? imageUrl;
  final bool isActive;
  final int? displayOrder;

  CategoryData({
    required this.categoryId,
    required this.name,
    required this.organizationId,
    this.meta,
    this.description,
    this.imageUrl,
    this.isActive = true,
    this.displayOrder,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      categoryId: json['categoryId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      organizationId: json['organizationId'] as String? ?? '',
      meta: json['meta'] != null
          ? EntityMeta.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      displayOrder: json['displayOrder'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
      'organizationId': organizationId,
      'meta': meta?.toJson(),
      'description': description,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'displayOrder': displayOrder,
    };
  }

  CategoryData copyWith({
    String? categoryId,
    String? name,
    String? organizationId,
    EntityMeta? meta,
    String? description,
    String? imageUrl,
    bool? isActive,
    int? displayOrder,
  }) {
    return CategoryData(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      organizationId: organizationId ?? this.organizationId,
      meta: meta ?? this.meta,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  String toString() {
    return 'CategoryData(categoryId: $categoryId, name: $name, organizationId: $organizationId, isActive: $isActive)';
  }
}
