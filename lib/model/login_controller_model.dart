class UserModel {
  bool status;
  String message;
  dynamic error;
  UserData data;

  UserModel({
    required this.status,
    required this.message,
    this.error,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      error: json['error'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  User user;
  String accessToken;
  String refreshToken;
  String expiresIn;
  String refreshExpiresIn;

  UserData({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
      refreshExpiresIn: json['refresh_expires_in'],
    );
  }
}

class User {
  int id;
  String fullName;
  String? email;
  String mobile;
  bool isActive;
  bool isVerify;
  DateTime createdAt;
  DateTime updatedAt;
  UserRole role;
  bool isProfileCreated;

  User(
      {required this.id,
      required this.fullName,
      this.email,
      required this.mobile,
      required this.isActive,
      required this.isVerify,
      required this.createdAt,
      required this.updatedAt,
      required this.role,
      required this.isProfileCreated});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        fullName: json['full_name'],
        email: json['email'],
        mobile: json['mobile'],
        isActive: json['is_active'],
        isVerify: json['is_verify'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        role: UserRole.fromJson(json['role']),
        isProfileCreated: json['is_profile_created']);
  }
}

class UserRole {
  int id;
  String name;

  UserRole({
    required this.id,
    required this.name,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'],
      name: json['name'],
    );
  }
}
