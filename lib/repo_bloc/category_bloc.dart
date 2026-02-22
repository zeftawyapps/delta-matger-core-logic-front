import 'dart:typed_data';
import 'package:matger_core_logic/features/commrec/repo/category_repo.dart';
import 'package:matger_core_logic/features/commrec/data/category_model.dart';
import 'package:matger_core_logic/utls/bloc/base_bloc.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:matger_core_logic/utls/bloc/remote_base_model.dart';

class CategoryBloc {
  static final CategoryBloc _singleton = CategoryBloc._internal();
  factory CategoryBloc() => _singleton;
  CategoryBloc._internal();

  final CategoryRepo _repo = CategoryRepo();

  final DataSourceBloc<CategoryData> categoryDataBloc =
      DataSourceBloc<CategoryData>();
  final DataSourceBloc<List<CategoryData>> categoriesListBloc =
      DataSourceBloc<List<CategoryData>>();
  final DataSourceBloc<Map<String, dynamic>> rawDataBloc =
      DataSourceBloc<Map<String, dynamic>>();

  Future<void> createCategory({
    required String name,
    required String shopId,
    String? description,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    categoryDataBloc.loadingState();
    rawDataBloc.loadingState();

    final result = await _repo.createCategory(
      name: name,
      shopId: shopId,
      description: description,
      imageBytes: imageBytes,
      imageName: imageName,
    );

    if (result.status == StatusModel.success && result.data != null) {
      categoryDataBloc.successState(result.data!);
      rawDataBloc.successState(result.data!.toJson());
    } else {
      categoryDataBloc.failedState(
        ErrorStateModel(message: result.message ?? "Failed to create category"),
        () => createCategory(
          name: name,
          shopId: shopId,
          description: description,
          imageBytes: imageBytes,
          imageName: imageName,
        ),
      );
    }
  }

  Future<void> getCategoriesByShop(String shopId) async {
    categoriesListBloc.loadingState();
    rawDataBloc.loadingState();

    final result = await _repo.getCategoriesByShop(shopId);

    if (result.status == StatusModel.success && result.data != null) {
      categoriesListBloc.successState(result.data!);
      rawDataBloc.successState({
        "count": result.data!.length,
        "items": result.data!.map((e) => e.toJson()).toList(),
      });
    } else {
      categoriesListBloc.failedState(
        ErrorStateModel(message: result.message ?? "Failed to get categories"),
        () => getCategoriesByShop(shopId),
      );
    }
  }
}
