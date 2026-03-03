import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:matger_core_logic/models/entity_meta.dart';

class ProductData {
  final String productId;
  final String name;
  final String categoryId;
  final String organizationId;
  final double price;
  final double? oldPrice;
  final double? cost;
  final List<String> imageUrls;
  final bool isActive;
  final int stockQuantity;
  final Map<String, dynamic> additionalData;
  final EntityMeta? meta;

  ProductData({
    required this.productId,
    required this.name,
    required this.categoryId,
    required this.organizationId,
    required this.price,
    this.oldPrice,
    this.cost,
    this.imageUrls = const [],
    this.isActive = true,
    this.stockQuantity = 0,
    this.additionalData = const {},
    this.meta,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    // Collect all fields that are not part of the core structure into additionalData
    final coreFields = [
      'productId',
      'id',
      'name',
      'categoryId',
      'category',
      'organizationId',
      'price',
      'oldPrice',
      'cost',
      'imageUrls',
      'images',
      'image',
      'isActive',
      'stockQuantity',
      'meta',
      'createdAt',
      'updatedAt',
    ];

    final additional = Map<String, dynamic>.from(json)
      ..removeWhere((key, value) => coreFields.contains(key));

    return ProductData(
      productId: (json['productId'] ?? json['id'] ?? '') as String,
      name: (json['name'] as String? ?? ''),
      categoryId: (json['categoryId'] ?? json['category'] ?? '') as String,
      organizationId: (json['organizationId'] as String? ?? ''),
      price: (json['price'] as num? ?? 0.0).toDouble(),
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      cost: (json['cost'] as num?)?.toDouble(),
      imageUrls:
          (json['imageUrls'] as List?)
              ?.map((e) => ApiUrls.IMAGE_BASE_URL + e.toString())
              .toList() ??
          (json['images'] as List?)
              ?.map((e) => ApiUrls.IMAGE_BASE_URL + e.toString())
              .toList() ??
          [],
      isActive: json['isActive'] as bool? ?? true,
      stockQuantity: (json['stockQuantity'] as num? ?? 0).toInt(),
      additionalData: additional,
      meta: json['meta'] != null ? EntityMeta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'name': name,
      'category': categoryId,
      'organizationId': organizationId,
      'price': price,
      'oldPrice': oldPrice,
      'cost': cost,
      'images': imageUrls,
      'isActive': isActive,
      'stockQuantity': stockQuantity,
      'meta': meta?.toJson(),
      ...additionalData,
    };
  }

  // Flattened description for easier access
  String get description => additionalData['description'] as String? ?? '';
}
