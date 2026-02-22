import 'package:JoDija_reposatory/utilis/http_remotes/http_client.dart';
import 'package:JoDija_reposatory/utilis/http_remotes/http_methos_enum.dart';
import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:dio/dio.dart';
import 'package:matger_core_logic/consts/end_points.dart';

class AuthSource {
  Future<Result<RemoteBaseModel, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.login}";
      final data = await HttpClient(userToken: false).sendRequestJsonMap(
        method: HttpMethod.POST,
        url: url,
        body: {"emailOrUsername": username, "password": password},
        cancelToken: CancelToken(),
      );

      return Result.data(data);
    } on DioError catch (e) {
      return Result.error(
        RemoteBaseModel(
          message: e.message,
          status: StatusModel.error,
          data: e.response?.data,
        ),
      );
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> register({
    required Map<String, dynamic> userData,
  }) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.register}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: userData,
        cancelToken: CancelToken(),
      );

      if (result.data?.status == StatusModel.success) {
        return Result.data(result.data?.data);
      }
      return Result.error(
        RemoteBaseModel(
          message: result.error?.message,
          status: result.data?.status ?? StatusModel.error,
        ),
      );
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> getProfile() async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.profile}";
      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.GET,
        url: url,
        cancelToken: CancelToken(),
      );

      if (result.data?.status == StatusModel.success) {
        return Result.data(result.data?.data);
      }
      return Result.error(
        RemoteBaseModel(
          message: result.error?.message,
          status: result.data?.status ?? StatusModel.error,
        ),
      );
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }
}
