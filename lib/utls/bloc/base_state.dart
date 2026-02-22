import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matger_core_logic/utls/bloc/base_bloc.dart';
import 'package:matger_core_logic/utls/bloc/remote_base_model.dart';
part 'base_state.freezed.dart';

@immutable
@freezed
class DataSourceBaseState<T> with _$BaseState<T> {
  const factory DataSourceBaseState.init() = _Init;
  const factory DataSourceBaseState.loading() = _Loading;
  const factory DataSourceBaseState.success([T? model]) = _Success<T>;
  const factory DataSourceBaseState.failure(
    ErrorStateModel error,
    VoidCallback callback,
  ) = _Failure;
}
