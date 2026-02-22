import 'package:JoDija_reposatory/utilis/http_remotes/http_client.dart';
import 'package:JoDija_reposatory/utilis/http_remotes/http_methos_enum.dart';
import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:dio/dio.dart';
import 'package:matger_core_logic/consts/end_points.dart';

class OrganizationSource {
  Future<Result<RemoteBaseModel, dynamic>> createOrganizationWithOwner({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> organizationData,
  }) async {
    try {
      String url = "${ApiUrls.BASE_URL}${EndPoints.createOrgWithOwner}";

      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: {"userData": userData, "organizationData": organizationData},
        cancelToken: CancelToken(),
      );

      if (result.data?.status == StatusModel.success) {
        return Result.data(result.data?.data);
      }
      return Result.error(
        RemoteBaseModel(
          message: result.error?.message ?? result.data?.message,
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
