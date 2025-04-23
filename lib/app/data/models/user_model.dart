class UserModel {
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final NotificationSettings notificationSettings;
  final String? deviceToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.notificationSettings,
    this.deviceToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      notificationSettings:
          NotificationSettings.fromJson(json['notificationSettings']),
      deviceToken: json['deviceToken'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'notificationSettings': notificationSettings.toJson(),
      'deviceToken': deviceToken,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class NotificationSettings {
  final bool pushEnabled;
  final bool emailEnabled;

  NotificationSettings({
    required this.pushEnabled,
    required this.emailEnabled,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      pushEnabled: json['pushEnabled'],
      emailEnabled: json['emailEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushEnabled': pushEnabled,
      'emailEnabled': emailEnabled,
    };
  }
}
