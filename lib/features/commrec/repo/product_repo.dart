import 'package:matger_core_logic/features/commrec/data/product_model.dart';
import 'package:matger_core_logic/features/commrec/source/product_source.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'dart:io';

class ProductRepo {
  late final ProductSource _productSource;

  ProductRepo({ProductSource? productSource}) {
    _productSource = productSource ?? ProductSource();
  }

  Future<RemoteBaseModel<ProductData>> createProduct({
    required String name,
    required String categoryId,
    required String shopId,
    required double price,
    List<File>? images,
  }) async {
    final result = await _productSource.createProduct(
      name: name,
      categoryId: categoryId,
      shopId: shopId,
      price: price,
      images: images,
    );

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      return RemoteBaseModel(
        data: ProductData.fromJson(result.data as Map<String, dynamic>),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<List<ProductData>>> getProducts({
    int page = 1,
    int limit = 10,
  }) async {
    final result = await _productSource.getProducts(page: page, limit: limit);

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      final List data = result.data is List
          ? result.data
          : (result.data['data'] ?? []);
      final products = data
          .map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList();
      return RemoteBaseModel(data: products, status: StatusModel.success);
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<List<ProductData>>> searchProducts({
    required String name,
    required String shopId,
  }) async {
    final result = await _productSource.searchProducts(
      name: name,
      shopId: shopId,
    );

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      final List data = result.data is List
          ? result.data
          : (result.data['data'] ?? []);
      final products = data
          .map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList();
      return RemoteBaseModel(data: products, status: StatusModel.success);
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }
}
