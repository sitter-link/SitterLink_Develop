class AppToken {
  final String accessToken;
  final String refreshToken;

  const AppToken({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AppToken.fromJson(Map<String, dynamic> json) {
    return AppToken(
      accessToken: json["access"],
      refreshToken: json["refresh"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "access": accessToken,
      "refresh": refreshToken,
    };
  }
}
