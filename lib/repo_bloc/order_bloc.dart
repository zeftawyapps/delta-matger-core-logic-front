import 'package:matger_core_logic/features/commrec/repo/order_repo.dart';
import 'package:matger_core_logic/features/commrec/data/order_model.dart';
import 'package:matger_core_logic/utls/bloc/base_bloc.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:matger_core_logic/utls/bloc/remote_base_model.dart';

class OrderBloc {
  static final OrderBloc _singleton = OrderBloc._internal();
  factory OrderBloc() => _singleton;
  OrderBloc._internal();

  final OrderRepo _repo = OrderRepo();

  final DataSourceBloc<OrderData> orderDataBloc = DataSourceBloc<OrderData>();
  final DataSourceBloc<List<OrderData>> ordersListBloc =
      DataSourceBloc<List<OrderData>>();
  final DataSourceBloc<Map<String, dynamic>> rawDataBloc =
      DataSourceBloc<Map<String, dynamic>>();

  Future<void> createOrder({
    required String organizationId,
    String? customerId,
    required double totalAmount,
    required List<OrderItemData> items,
    Map<String, dynamic>? additionalData,
  }) async {
    orderDataBloc.loadingState();
    rawDataBloc.loadingState();

    final result = await _repo.createOrder(
      organizationId: organizationId,
      customerId: customerId,
      totalAmount: totalAmount,
      items: items,
      additionalData: additionalData,
    );

    if (result.status == StatusModel.success && result.data != null) {
      orderDataBloc.successState(result.data!);
      rawDataBloc.successState(result.data!.toJson());
    } else {
      orderDataBloc.failedState(
        ErrorStateModel(message: result.message ?? "Failed to create order"),
        () => createOrder(
          organizationId: organizationId,
          customerId: customerId,
          totalAmount: totalAmount,
          items: items,
          additionalData: additionalData,
        ),
      );
    }
  }

  Future<void> getShopOrders(String shopId) async {
    ordersListBloc.loadingState();
    rawDataBloc.loadingState();

    final result = await _repo.getShopOrders(shopId);

    if (result.status == StatusModel.success && result.data != null) {
      ordersListBloc.successState(result.data!);
      rawDataBloc.successState({
        "count": result.data!.length,
        "items": result.data!.map((e) => e.toJson()).toList(),
      });
    } else {
      ordersListBloc.failedState(
        ErrorStateModel(message: result.message ?? "Failed to get orders"),
        () => getShopOrders(shopId),
      );
    }
  }
}
