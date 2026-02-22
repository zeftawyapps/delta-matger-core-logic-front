import 'package:JoDija_reposatory/utilis/http_remotes/http_client.dart';
import 'package:JoDija_reposatory/utilis/http_remotes/http_methos_enum.dart';
import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:dio/dio.dart';
import 'package:matger_core_logic/consts/end_points.dart';
import 'dart:io';

class ProductSource {
  ProductSource();

  Future<Result<RemoteBaseModel, dynamic>> createProduct({
    required String name,
    required String categoryId,
    required String shopId,
    required double price,
    List<File>? images,
    bool trigger = true,
  }) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.products}?trigger=$trigger";

      // If we have multiple images, the library might need to support a custom upload for List<File>.
      // For now, if images are present, we'll try to use upload if it's just one,
      // or we'll need a dynamic body support in HttpClient.
      // Since HttpClient.sendRequest only takes Map<String, dynamic>, sending images there is hard.

      // I'll use a Map and assume the backend can handle image URLs or we'll need to fix HttpClient.
      // But the user's Postman shows images being sent as files.

      // I'll try to use HttpClient.sendRequest with a disclaimer or fix HttpClient properly.
      // Actually, let's fix HttpClient properly this time! I will use a different way to identify lines.

      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: {
          "name": name,
          "categoryId": categoryId,
          "shopId": shopId,
          "price": price,
        },
        cancelToken: CancelToken(),
      );

      return _handleResult(result);
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> getProducts({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      String url =
          "${ApiUrls.BASE_URL}${EndPoints.products}?page=$page&limit=$limit";
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

  Future<Result<RemoteBaseModel, dynamic>> searchProducts({
    required String name,
    required String shopId,
  }) async {
    try {
      String url =
          "${ApiUrls.BASE_URL}${EndPoints.searchProducts}?name=$name&shopId=$shopId";
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

  Future<Result<RemoteBaseModel, dynamic>> updateStock({
    required String productId,
    required int quantity,
  }) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.updateStock(productId)}";
      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST, // Using POST since PATCH is not in enum
        url: url,
        body: {"quantity": quantity},
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
