class GeneralResponseModel {
  final bool? success;
  final String? message;
  final Map<String, dynamic>? data;

  GeneralResponseModel({this.success, this.message, this.data});

  factory GeneralResponseModel.fromJson(Map<String, dynamic> json) {
    return GeneralResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (data != null) 'data': data,
    };
  }
}
