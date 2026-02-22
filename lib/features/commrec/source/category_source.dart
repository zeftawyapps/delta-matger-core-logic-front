import 'package:JoDija_reposatory/utilis/http_remotes/http_client.dart';
import 'package:JoDija_reposatory/utilis/http_remotes/http_methos_enum.dart';
import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:dio/dio.dart';
import 'package:matger_core_logic/consts/end_points.dart';
import 'dart:typed_data';

class CategorySource {
  CategorySource();

  Future<Result<RemoteBaseModel, dynamic>> createCategory({
    required String name,
    required String shopId,
    String? description,
    Uint8List? imageBytes,
    String? imageName,
    bool trigger = true,
  }) async {
    try {
      String url =
          "${ApiUrls.BASE_URL}${EndPoints.categories}?trigger=$trigger";

      if (imageBytes != null) {
        final result = await HttpClient(userToken: true).uploadMapResult(
          url: url,
          fileKey: "image",
          file: MultipartFile.fromBytes(
            imageBytes,
            filename: imageName ?? "image.png",
          ),
          data: {
            "name": name,
            "organizationId": shopId,
            if (description != null) "description": description,
          },
          cancelToken: CancelToken(),
        );
        return _handleResult(result);
      } else {
        final result = await HttpClient(userToken: true).sendRequest(
          method: HttpMethod.POST,
          url: url,
          body: {
            "name": name,
            "organizationId": shopId,
            if (description != null) "description": description,
          },
          cancelToken: CancelToken(),
        );
        return _handleResult(result);
      }
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> getActiveCategories() async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.activeCategories}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.GET,
        url: url,
        cancelToken: CancelToken(),
      );
      return _handleResult(result);
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> getCategoriesByShop(
    String shopId,
  ) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.shopCategories(shopId)}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.GET,
        url: url,
        cancelToken: CancelToken(),
      );
      return _handleResult(result);
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> updateCategory({
    required String categoryId,
    String? name,
    bool? isActive,
    Uint8List? imageBytes,
    String? imageName,
    bool trigger = true,
  }) async {
    try {
      String url =
          "${ApiUrls.BASE_URL}${EndPoints.categories}/$categoryId?trigger=$trigger";

      if (imageBytes != null) {
        final result = await HttpClient(userToken: true).uploadMapResult(
          url: url,
          fileKey: "image",
          file: MultipartFile.fromBytes(
            imageBytes,
            filename: imageName ?? "image.png",
          ),
          data: {
            if (name != null) "name": name,
            if (isActive != null) "isActive": isActive.toString(),
          },
          cancelToken: CancelToken(),
        );
        return _handleResult(result);
      } else {
        final result = await HttpClient(userToken: true).sendRequest(
          method: HttpMethod.PUT,
          url: url,
          body: {
            if (name != null) "name": name,
            if (isActive != null) "isActive": isActive.toString(),
          },
          cancelToken: CancelToken(),
        );
        return _handleResult(result);
      }
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> deleteCategory(
    String categoryId, {
    bool trigger = true,
  }) async {
    try {
      String url =
          "${ApiUrls.BASE_URL}${EndPoints.categories}/$categoryId?trigger=$trigger";
      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.DELETE,
        url: url,
        cancelToken: CancelToken(),
      );
      return _handleResult(result);
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Result<RemoteBaseModel, dynamic> _handleResult(
    Result<RemoteBaseModel, RemoteBaseModel> result,
  ) {
    if (result.data?.status == StatusModel.success) {
      return Result.data(result.data?.data);
    }
    return Result.error(
      RemoteBaseModel(
        message: result.error?.message ?? result.data?.message,
        status: result.data?.status ?? StatusModel.error,
      ),
    );
  }
}
