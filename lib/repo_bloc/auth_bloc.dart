import 'package:matger_core_logic/core/auth/repos/auth_repo.dart';
import 'package:matger_core_logic/utls/bloc/base_bloc.dart';
import 'package:matger_core_logic/core/auth/data/user_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:matger_core_logic/utls/bloc/remote_base_model.dart';
import 'package:JoDija_reposatory/https/http_urls.dart';
import 'package:matger_core_logic/utls/storage/storage_helper.dart';
import 'package:matger_core_logic/models/general_response.dart';
import 'package:matger_core_logic/repo_bloc/storage_bloc.dart';

class AuthBloc {
  static final AuthBloc _singleton = AuthBloc._internal();
  factory AuthBloc() {
    return _singleton;
  }
  AuthBloc._internal() {
    loadStoredAuth();
  }

  final AuthRepo _authRepo = AuthRepo();

  DataSourceBloc<Map<String, dynamic>> loginBloc =
      DataSourceBloc<Map<String, dynamic>>();
  DataSourceBloc<UserModel> registerBloc = DataSourceBloc<UserModel>();
  DataSourceBloc<UserModel> profileBloc = DataSourceBloc<UserModel>();

  // Login action
  void login(String username, String password) async {
    loginBloc.loadingState();

    final result = await _authRepo.login(
      username: username,
      password: password,
    );

    if (result.status == StatusModel.error || result.data == null) {
      loginBloc.failedState(
        ErrorStateModel(message: result.message ?? "Login failed"),
        () => login(username, password),
      );
    } else {
      // Save Token to HttpHeader for subsequent requests
      final token = result.data?.token;
      if (token != null) {
        // Fix: Add a space after Bearer for correct header format
        HttpHeader().setAuthHeader(token, Bearer: "Bearer ");
        // Persist token
        StorageHelper.saveToken(token).then((_) {
          // Refresh Storage UI after saving
          StorageBloc().loadStorageData();
        });
      }

      final response = GeneralResponseModel(
        success: true,
        message: result.message ?? "Login successful",
        data: result.data?.toJson(),
      );

      loginBloc.successState(response.toJson());
    }
  }

  // Load stored auth data on init
  void loadStoredAuth() {
    final token = StorageHelper.getToken();
    if (token != null && token.isNotEmpty) {
      HttpHeader().setAuthHeader(token, Bearer: "Bearer ");
      // Optionally fetch profile immediately if token exists
      getProfile();
    }
  }

  // Logout / Clear Session
  void logout() async {
    await StorageHelper.clearToken();
    HttpHeader().setAuthHeader("");
    profileBloc.loadingState(); // Reset profile state
    loginBloc.loadingState(); // Reset login state
  }

  // Fetch profile action
  void getProfile() async {
    profileBloc.loadingState();

    final result = await _authRepo.getProfile();

    if (result.status == StatusModel.error || result.data == null) {
      // Show raw error JSON in loginBloc for inspector visibility
      if (result.data != null) {
        loginBloc.successState(result.data as Map<String, dynamic>);
      }
      profileBloc.failedState(
        ErrorStateModel(message: result.message ?? "Failed to load profile"),
        () => getProfile(),
      );
    } else {
      profileBloc.successState(result.data);
    }
  }
}
