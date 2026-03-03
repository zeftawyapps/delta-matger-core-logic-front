import 'package:matger_core_logic/features/commrec/data/category_model.dart';
import 'package:matger_core_logic/features/commrec/source/category_source.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'dart:typed_data';

class CategoryRepo {
  late final CategorySource _categorySource;

  CategoryRepo({CategorySource? categorySource}) {
    _categorySource = categorySource ?? CategorySource();
  }

  Future<RemoteBaseModel<CategoryData>> createCategory({
    required String name,
    required String shopId,
    String? description,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    final result = await _categorySource.createCategory(
      name: name,
      shopId: shopId,
      description: description,
      imageBytes: imageBytes,
      imageName: imageName,
    );

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      return RemoteBaseModel(
        data: CategoryData.fromJson(result.data as Map<String, dynamic>),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<List<CategoryData>>> getCategoriesByOrganization(
    String organizationId,
  ) async {
    final result = await _categorySource.getCategoriesByOrganization(
      organizationId,
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
      final categories = data
          .map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList();
      return RemoteBaseModel(data: categories, status: StatusModel.success);
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<CategoryData>> updateCategory({
    required String categoryId,
    String? name,
    bool? isActive,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    final result = await _categorySource.updateCategory(
      categoryId: categoryId,
      name: name,
      isActive: isActive,
      imageBytes: imageBytes,
      imageName: imageName,
    );

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      return RemoteBaseModel(
        data: CategoryData.fromJson(result.data as Map<String, dynamic>),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<bool>> deleteCategory(String categoryId) async {
    final result = await _categorySource.deleteCategory(categoryId);

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
        data: false,
      );
    }

    return RemoteBaseModel(data: true, status: StatusModel.success);
  }
}
