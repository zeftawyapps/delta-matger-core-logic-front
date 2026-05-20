import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:matger_pro_core_logic/utls/type_parser.dart';
import 'package:matger_pro_core_logic/models/entity_meta.dart';
import 'package:matger_pro_core_logic/models/localized_string.dart';

class CategoryData {
  final String id;
  final LocalizedString name;
  final String organizationId;
  final EntityMeta? meta;
  final LocalizedString? description;
  final String? imageUrl;
  final bool isActive;
  final int? displayOrder;
  final int? productCount;
  final bool isMasterProduct;
  final String sharingLevel;

  CategoryData({
    required this.id,
    required this.name,
    required this.organizationId,
    this.meta,
    this.description,
    this.imageUrl,
    this.isActive = true,
    this.displayOrder,
    this.productCount,
    this.isMasterProduct = true,
    this.sharingLevel = 'private',
  });

  // Alias for backward compatibility if needed
  String get categoryId => id;

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: (json['id'] ?? json['categoryId'] ?? json['_id'] ?? '').toString(),
      name: LocalizedString.fromJson(json['name']),
      organizationId: (json['organizationId'] ?? '').toString(),
      meta: json['meta'] != null
          ? EntityMeta.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
      description: json['description'] != null
          ? LocalizedString.fromJson(json['description'])
          : null,
      imageUrl: json['imageUrl'] != null
          ? (json['imageUrl'].toString().contains('http')
              ? json['imageUrl'].toString()
              : ApiUrls.IMAGE_BASE_URL + json['imageUrl'].toString())
          : null,
      isActive: TypeParser.parseBool(json['isActive'], true),
      displayOrder: TypeParser.parseInt(json['displayOrder']),
      productCount: TypeParser.parseInt(json['productCount']),
      isMasterProduct: TypeParser.parseBool(json['isMasterProduct'], true),
      sharingLevel: (json['sharingLevel'] ?? 'private').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
      'organizationId': organizationId,
      'meta': meta?.toJson(),
      'description': description?.toJson(),
      'imageUrl': imageUrl,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'productCount': productCount,
      'isMasterProduct': isMasterProduct,
      'sharingLevel': sharingLevel,
    };
  }

  CategoryData copyWith({
    String? id,
    LocalizedString? name,
    String? organizationId,
    EntityMeta? meta,
    LocalizedString? description,
    String? imageUrl,
    bool? isActive,
    int? displayOrder,
    int? productCount,
    bool? isMasterProduct,
    String? sharingLevel,
  }) {
    return CategoryData(
      id: id ?? this.id,
      name: name ?? this.name,
      organizationId: organizationId ?? this.organizationId,
      meta: meta ?? this.meta,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      productCount: productCount ?? this.productCount,
      isMasterProduct: isMasterProduct ?? this.isMasterProduct,
      sharingLevel: sharingLevel ?? this.sharingLevel,
    );
  }

  @override
  String toString() {
    return 'CategoryData(id: $id, name: ${name.ar}, organizationId: $organizationId, isActive: $isActive, productCount: $productCount, isMasterProduct: $isMasterProduct, sharingLevel: $sharingLevel)';
  }
}
