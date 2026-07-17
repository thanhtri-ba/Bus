class BaseResponse {
  final bool success;
  final String message;

  BaseResponse({required this.success, required this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class AuthResponse {
  final bool success;
  final String message;
  final String? accessToken;
  final String? refreshToken;
  final Map<String, dynamic>? user;

  AuthResponse({
    required this.success,
    required this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      user: json['user'],
    );
  }
}

class CheckEmailResponse {
  final bool exists;
  final String email;

  CheckEmailResponse({required this.exists, required this.email});

  factory CheckEmailResponse.fromJson(Map<String, dynamic> json) {
    return CheckEmailResponse(
      exists: json['exists'] ?? false,
      email: json['email'] ?? '',
    );
  }
}
