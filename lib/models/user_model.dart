class UserModel {
  String name;
  String password;
  String? email;
  DateTime? createdAt;
  
  UserModel({
    required this.name,
    required this.password,
    this.email,
    this.createdAt,
  });
  
  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
  
  // Create from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      email: map['email'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }
} 