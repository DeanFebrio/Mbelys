class UserEntity {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String? photoUrl;
  final String? pendingEmail;
  final String? emailChangeStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.photoUrl,
    this.pendingEmail,
    this.emailChangeStatus,
    this.createdAt,
    this.updatedAt,
  });
}