class UserEntity {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    this.createdAt,
    this.updatedAt,
  });
}