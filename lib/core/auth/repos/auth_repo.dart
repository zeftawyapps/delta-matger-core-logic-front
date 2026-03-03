import 'package:matger_core_logic/core/auth/data/user_model.dart';
import 'package:matger_core_logic/core/auth/source/auth_source.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';

class AuthRepo {
  late final AuthSource _authSource;

  AuthRepo({AuthSource? authSource}) {
    _authSource = authSource ?? AuthSource();
  }

  Future<RemoteBaseModel<UserModel>> login({
    required String username,
    required String password,
  }) async {
    final result = await _authSource.login(
      username: username,
      password: password,
    );

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
        data: null,
      );
    }

    try {
      // Handle nested data field if present, otherwise use the whole object
      final rawData = result.data as Map<String, dynamic>;
      final data = (rawData.containsKey('data') && rawData['data'] is Map)
          ? rawData['data'] as Map<String, dynamic>
          : rawData;

      return RemoteBaseModel(
        data: UserModel.fromJson(data),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<UserModel>> register({
    required Map<String, dynamic> userData,
  }) async {
    final result = await _authSource.register(userData: userData);

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      final rawData = result.data as Map<String, dynamic>;
      final data = (rawData.containsKey('data') && rawData['data'] is Map)
          ? rawData['data'] as Map<String, dynamic>
          : rawData;
      return RemoteBaseModel(
        data: UserModel.fromJson(data),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }

  Future<RemoteBaseModel<UserModel>> getProfile() async {
    final result = await _authSource.getProfile();

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      final rawData = result.data as Map<String, dynamic>;
      final data = (rawData.containsKey('data') && rawData['data'] is Map)
          ? rawData['data'] as Map<String, dynamic>
          : rawData;
      return RemoteBaseModel(
        data: UserModel.fromJson(data),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }
}
