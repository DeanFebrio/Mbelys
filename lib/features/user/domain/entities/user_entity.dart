class UserEntity {
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;
  final String name;
  final String phoneNumber;
  final String? userPhotoUrl;

  UserEntity({
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.name,
    required this.phoneNumber,
    this.userPhotoUrl,
  });
}