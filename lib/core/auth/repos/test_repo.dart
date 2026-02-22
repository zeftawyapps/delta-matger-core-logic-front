import 'package:matger_core_logic/models/app_settings.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import '../source/test_page_source.dart';

class TestRepo {
  late final TestPageSource _landingPageSource;

  TestRepo({TestPageSource? landingPageSource}) {
    _landingPageSource = landingPageSource ?? TestPageSource();
  }

  /// Retrieves landing page data from the source and converts it to AppSettings model.
  Future<RemoteBaseModel<AppSettings>> getLandingData({
    Map<String, dynamic>? mockData,
  }) async {
    final result = await _landingPageSource.getTestPages(
      mockResponse: mockData,
    );

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    if (result.data != null) {
      try {
        final settings = AppSettings.fromJson(result.data!);
        return RemoteBaseModel(data: settings, status: StatusModel.success);
      } catch (e) {
        return RemoteBaseModel(
          status: StatusModel.error,
          message: "Data Parsing Error: $e",
        );
      }
    }

    return RemoteBaseModel(status: StatusModel.error, message: "No data found");
  }
}
