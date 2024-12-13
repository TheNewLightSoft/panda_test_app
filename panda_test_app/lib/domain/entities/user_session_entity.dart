class UserSessionEntity {
  final bool isAuthenticated;
  final String? token;
  UserSessionEntity({
    required this.isAuthenticated,
    this.token,
  });
}
