import 'package:JoDija_reposatory/utilis/http_remotes/http_client.dart';
import 'package:JoDija_reposatory/utilis/http_remotes/http_methos_enum.dart';
import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:dio/dio.dart';
import 'package:matger_core_logic/consts/end_points.dart';

class TestPageSource {
  /// Fetches test page data.
  ///
  /// [mockResponse] optionally provides raw mock data for testing (text connection).
  Future<Result<RemoteBaseModel, Map<String, dynamic>>> getTestPages({
    Map<String, dynamic>? mockResponse,
  }) async {
    // If mock response is provided (text connection phase), return it immediately.
    if (mockResponse != null) {
      return Result.data(mockResponse);
    }

    try {
      // Fetch data from API
      String url = "${ApiUrls.BASE_URL}${EndPoints.test}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.GET,
        url: url,
        cancelToken: CancelToken(),
      );

      if (result.data?.status == StatusModel.success) {
        final data = result.data?.data;
        if (data is Map<String, dynamic>) {
          return Result.data(data);
        }
        return Result.data({});
      } else {
        return Result.error(
          RemoteBaseModel(
            message: result.error?.message,
            status: result.data?.status ?? StatusModel.error,
          ),
        );
      }
    } catch (e) {
      return Result.error(
        RemoteBaseModel(message: e.toString(), status: StatusModel.error),
      );
    }
  }
}
