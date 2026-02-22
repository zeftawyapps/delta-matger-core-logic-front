import 'package:JoDija_reposatory/utilis/http_remotes/http_client.dart';
import 'package:JoDija_reposatory/utilis/http_remotes/http_methos_enum.dart';
import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:dio/dio.dart';
import 'package:matger_core_logic/consts/end_points.dart';

class OrderSource {
  OrderSource();

  Future<Result<RemoteBaseModel, dynamic>> createOrder({
    required String organizationId,
    String? customerId,
    required double totalAmount,
    required List<Map<String, dynamic>> items,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.orders}";
      final body = {
        "organizationId": organizationId,
        if (customerId != null) "customerId": customerId,
        "totalAmount": totalAmount,
        "items": items,
        if (additionalData != null) ...additionalData,
      };

      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: body,
        cancelToken: CancelToken(),
      );
      return _handleResult(result);
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> getShopOrders(String shopId) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.shopOrders(shopId)}";
      final result = await HttpClient(userToken: true).sendRequest(
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

  Future<Result<RemoteBaseModel, dynamic>> getOrderById(String orderId) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.orderById(orderId)}";
      final result = await HttpClient(userToken: true).sendRequest(
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

  Future<Result<RemoteBaseModel, dynamic>> updateOrderStatus(
    String orderId,
    String status,
  ) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.updateOrderStatus(orderId)}";
      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.PUT,
        url: url,
        body: {"status": status},
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
