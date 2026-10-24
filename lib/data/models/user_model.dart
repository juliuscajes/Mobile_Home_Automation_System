class UserModel {
  final int uid;
  final String displayName;
  final String email;
  final String role; // Admin, Family Member, Elderly
  String status; // Pending, Approved, Rejected

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.role,
    required this.status,
  });

  bool get isAdmin => role == 'Admin';
  bool get isElderly => role == 'Elderly';
}
