class UserModel {
  final String id;
  final String name;
  final String email;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isVerified,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'isVerified': isVerified,
    };
  }
}
