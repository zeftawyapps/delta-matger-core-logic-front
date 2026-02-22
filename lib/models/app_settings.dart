class AppSettings {
  final bool success;
  final String message;
  final String timestamp;
  final String environment;
  final String version;

  AppSettings({
    required this.success,
    required this.message,
    required this.timestamp,
    required this.environment,
    required this.version,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
      environment: json['environment'] ?? '',
      version: json['version'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'timestamp': timestamp,
      'environment': environment,
      'version': version,
    };
  }
}
