import 'package:matger_core_logic/features/commrec/data/order_model.dart';
import 'package:matger_core_logic/features/commrec/source/order_source.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';

class OrderRepo {
  late final OrderSource _orderSource;

  OrderRepo({OrderSource? orderSource}) {
    _orderSource = orderSource ?? OrderSource();
  }

  Future<RemoteBaseModel<OrderData>> createOrder({
    required String organizationId,
    String? customerId,
    required double totalAmount,
    required List<OrderItemData> items,
    Map<String, dynamic>? additionalData,
  }) async {
    final result = await _orderSource.createOrder(
      organizationId: organizationId,
      customerId: customerId,
      totalAmount: totalAmount,
      items: items.map((e) => e.toJson()).toList(),
      additionalData: additionalData,
    );

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      return RemoteBaseModel(
        data: OrderData.fromJson(result.data as Map<String, dynamic>),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<List<OrderData>>> getShopOrders(String shopId) async {
    final result = await _orderSource.getShopOrders(shopId);

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
      final orders = data
          .map((e) => OrderData.fromJson(e as Map<String, dynamic>))
          .toList();
      return RemoteBaseModel(data: orders, status: StatusModel.success);
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<OrderData>> getOrderById(String orderId) async {
    final result = await _orderSource.getOrderById(orderId);

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      return RemoteBaseModel(
        data: OrderData.fromJson(result.data as Map<String, dynamic>),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<bool>> updateOrderStatus(
    String orderId,
    String status,
  ) async {
    final result = await _orderSource.updateOrderStatus(orderId, status);

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
