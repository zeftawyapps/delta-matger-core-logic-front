import 'package:JoDija_reposatory/utilis/http_remotes/http_client.dart';
import 'package:JoDija_reposatory/utilis/http_remotes/http_methos_enum.dart';
import 'package:JoDija_reposatory/constes/api_urls.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';
import 'package:JoDija_reposatory/utilis/result/result.dart';
import 'package:dio/dio.dart';
import 'package:matger_pro_core_logic/consts/end_points.dart';
import 'package:JoDija_reposatory/utilis/functions/jd_repo_console.dart';

class AuthSource {
  Future<Result<RemoteBaseModel, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      JDRepoConsole.info(
        "Attempting login for: $username",
        context: LogContext(module: "AuthSource", method: "login"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.login}";
      final data = await HttpClient(userToken: false).sendRequestJsonMap(
        method: HttpMethod.POST,
        url: url,
        body: {"emailOrUsername": username, "password": password},
        cancelToken: CancelToken(),
      );

      JDRepoConsole.success(
        "Login request successful",
        context: LogContext(module: "AuthSource", method: "login"),
      );
      return Result.data(data);
    } catch (e) {
      return _catchError("login", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> loginOrg({
    required String orgName,
    required String username,
    required String password,
  }) async {
    try {
      JDRepoConsole.info(
        "Attempting login for: $username in $orgName",
        context: LogContext(module: "AuthSource", method: "loginOrg"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.orgLogin(orgName)}";
      final data = await HttpClient(userToken: false).sendRequestJsonMap(
        method: HttpMethod.POST,
        url: url,
        body: {"emailOrUsername": username, "password": password},
        cancelToken: CancelToken(),
      );

      JDRepoConsole.success(
        "Login request successful for organization",
        context: LogContext(module: "AuthSource", method: "loginOrg"),
      );
      return Result.data(data);
    } catch (e) {
      return _catchError("loginOrg", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> register({
    required Map<String, dynamic> userData,
  }) async {
    try {
      JDRepoConsole.info(
        "Attempting register",
        context: LogContext(module: "AuthSource", method: "register"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.register}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: userData,
        cancelToken: CancelToken(),
      );

      if (result.data?.status == StatusModel.success) {
        JDRepoConsole.success(
          "Register successful",
          context: LogContext(module: "AuthSource", method: "register"),
        );
        return Result.data(result.data?.data);
      }
      return _wrap(result);
    } catch (e) {
      return _catchError("register", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> getProfile() async {
    try {
      JDRepoConsole.info(
        "Fetching profile",
        context: LogContext(module: "AuthSource", method: "getProfile"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.profile}";
      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.GET,
        url: url,
        cancelToken: CancelToken(),
      );

      if (result.data?.status == StatusModel.success) {
        JDRepoConsole.success(
          "Profile fetched successfully",
          context: LogContext(module: "AuthSource", method: "getProfile"),
        );
        return Result.data(result.data?.data);
      }
      return _wrap(result);
    } catch (e) {
      return _catchError("getProfile", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> signup({
    required Map<String, dynamic> userData,
  }) async {
    try {
      JDRepoConsole.info(
        "Attempting signup",
        context: LogContext(module: "AuthSource", method: "signup"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.signup}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: userData,
        cancelToken: CancelToken(),
      );

      if (result.data?.status == StatusModel.success) {
        JDRepoConsole.success(
          "Signup successful",
          context: LogContext(module: "AuthSource", method: "signup"),
        );
        return Result.data(result.data?.data);
      }
      return _wrap(result);
    } catch (e) {
      return _catchError("signup", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> requestOtp({
    required String phone,
  }) async {
    try {
      JDRepoConsole.info(
        "Attempting to request OTP for $phone",
        context: LogContext(module: "AuthSource", method: "requestOtp"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.requestOtp}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: {"phone": phone},
        cancelToken: CancelToken(),
      );

      return _wrap(result);
    } catch (e) {
      return _catchError("requestOtp", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      JDRepoConsole.info(
        "Attempting to verify OTP for $phone",
        context: LogContext(module: "AuthSource", method: "verifyOtp"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.verifyOtp}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: {"phone": phone, "code": code},
        cancelToken: CancelToken(),
      );

      if (result.data?.status == StatusModel.success) {
        JDRepoConsole.success(
          "OTP verified successfully",
          context: LogContext(module: "AuthSource", method: "verifyOtp"),
        );
        return Result.data(result.data?.data);
      }
      return _wrap(result);
    } catch (e) {
      return _catchError("verifyOtp", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> resetPassword({
    required String identifier,
    required String newPassword,
    String? otpCode,
  }) async {
    try {
      JDRepoConsole.info(
        "Attempting reset password for: $identifier",
        context: LogContext(module: "AuthSource", method: "resetPassword"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.resetPassword}";
      final result = await HttpClient(userToken: false).sendRequest(
        method: HttpMethod.POST,
        url: url,
        body: {
          "identifier": identifier,
          "newPassword": newPassword,
          if (otpCode != null) "otpCode": otpCode,
        },
        cancelToken: CancelToken(),
      );

      return _wrap(result);
    } catch (e) {
      return _catchError("resetPassword", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> changePassword({
    required String identifier,
    required String newPassword,
  }) async {
    try {
      JDRepoConsole.info(
        "Attempting change password for: $identifier",
        context: LogContext(module: "AuthSource", method: "changePassword"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.changePassword}";
      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.PUT,
        url: url,
        body: {"identifier": identifier, "newPassword": newPassword},
        cancelToken: CancelToken(),
      );

      return _wrap(result);
    } catch (e) {
      return _catchError("changePassword", e);
    }
  }

  Future<Result<RemoteBaseModel, dynamic>> logout() async {
    try {
      JDRepoConsole.info(
        "Attempting logout",
        context: LogContext(module: "AuthSource", method: "logout"),
      );
      String url = "${ApiUrls.BASE_URL}${EndPoints.logout}";
      final result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST,
        url: url,
        cancelToken: CancelToken(),
      );

      return _wrap(result);
    } catch (e) {
      return _catchError("logout", e);
    }
  }

  Result<RemoteBaseModel, dynamic> _wrap(
    Result<RemoteBaseModel, RemoteBaseModel> result,
  ) {
    if (result.data?.status == StatusModel.success) {
      return Result.data(result.data?.data);
    }

    String? message = result.error?.message ?? result.data?.message;

    if (result.data?.data is Map) {
      final dataMap = result.data?.data as Map;
      final msg =
          dataMap['message'] ??
          dataMap['error'] ??
          dataMap['errors'] ??
          dataMap['detail'];
      if (msg != null) {
        if (msg is List) {
          message = msg.join(', ');
        } else {
          message = msg.toString();
        }
      }
    }

    return Result.error(
      RemoteBaseModel(
        message: message ?? 'خطأ غير معروف',
        status: result.data?.status ?? StatusModel.error,
        data: result.data?.data ?? result.error?.data,
      ),
    );
  }

  Result<RemoteBaseModel, dynamic> _catchError(String method, Object e) {
    JDRepoConsole.error(
      "Error in $method: $e",
      context: LogContext(module: "AuthSource", method: method),
    );

    String message = "حدث خطأ غير متوقع";
    dynamic errorData;

    if (e is DioError) {
      errorData = e.response?.data;
      if (errorData is Map) {
        final msg =
            errorData['message'] ??
            errorData['error'] ??
            errorData['errors'] ??
            errorData['detail'];
        if (msg != null) {
          if (msg is List) {
            message = msg.join(', ');
          } else {
            message = msg.toString();
          }
        } else {
          message = e.message ?? "خطأ في الاتصال بالسيرفر";
        }
      } else {
        message = e.message ?? "خطأ في الاتصال بالسيرفر";
      }
    } else {
      message = e.toString();
    }

    return Result.error(
      RemoteBaseModel(
        message: message,
        status: StatusModel.error,
        data: errorData,
      ),
    );
  }
}
