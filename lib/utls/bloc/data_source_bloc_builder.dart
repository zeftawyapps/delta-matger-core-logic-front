import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matger_core_logic/utls/bloc/base_bloc.dart';
import 'package:matger_core_logic/utls/bloc/base_state.dart';
import 'package:matger_core_logic/utls/bloc/remote_base_model.dart';

typedef SuccessWidgetBuilder<T> = Widget Function(T? data);
typedef FailureWidgetBuilder =
    Widget Function(ErrorStateModel error, VoidCallback callback);
typedef LoadingWidgetBuilder = Widget Function();
typedef DataSourceListener<T> =
    void Function(BuildContext context, DataSourceBaseState<T> state);

class DataSourceBlocBuilder<T> extends StatelessWidget {
  final DataSourceBloc<T> bloc;
  final LoadingWidgetBuilder? loading;
  final SuccessWidgetBuilder<T> success;
  final FailureWidgetBuilder? failure;
  final Widget Function()? init;
  final DataSourceListener<T>? listener;

  const DataSourceBlocBuilder({
    super.key,
    required this.bloc,
    required this.success,
    this.loading,
    this.failure,
    this.init,
    this.listener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataSourceBloc<T>, DataSourceBaseState<T>>(
      bloc: bloc,
      listener: (context, state) {
        if (listener != null) {
          listener!(context, state);
        }
      },
      builder: (context, state) {
        return state.when(
          init: () => init != null ? init!() : const SizedBox.shrink(),
          loading: () => loading != null
              ? loading!()
              : const Center(child: CircularProgressIndicator()),
          success: (data) => success(data),
          failure: (error, callback) => failure != null
              ? failure!(error, callback)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 40,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 8),
                      Text(error.message ?? 'An error occurred'),
                      ElevatedButton(
                        onPressed: callback,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
