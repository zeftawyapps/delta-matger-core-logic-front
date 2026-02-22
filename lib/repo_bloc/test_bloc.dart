import 'package:matger_core_logic/core/auth/repos/test_repo.dart';
import 'package:matger_core_logic/utls/bloc/base_bloc.dart';
import 'package:matger_core_logic/models/app_settings.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:matger_core_logic/utls/bloc/remote_base_model.dart';

class TestBloc {
  static final TestBloc _singleton = TestBloc._internal();
  factory TestBloc() {
    return _singleton;
  }
  TestBloc._internal();

  DataSourceBloc<AppSettings> settingsBloc = DataSourceBloc<AppSettings>();
  DataSourceBloc<dynamic> updateSettingsBloc = DataSourceBloc<dynamic>();

  // Load settings
  void loadSettings() async {
    settingsBloc.loadingState();

    // Simulate fetching data from backend using the provided JSON
    await Future.delayed(const Duration(milliseconds: 500));
    TestRepo testRepo = TestRepo();
    final result = await testRepo.getLandingData();

    if (result.status == StatusModel.error || result.data == null) {
      settingsBloc.failedState(
        ErrorStateModel(message: result.message ?? "Failed to load settings"),
        () {
          loadSettings();
        },
      );
    } else {
      // result.data is already AppSettings because of Repo transformation
      settingsBloc.successState(result.data);
    }
  }
}
