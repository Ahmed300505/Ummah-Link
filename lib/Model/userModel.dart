import 'package:uuid/uuid.dart';

class UserModel {
  final String uid;
  final String uuid;
  final String name;
  final String username;
  final String email;
  final String role;
  final String? profileImageUrl;
  final String? bannerImageUrl;
  final String bio;
  final List<String> followers;
  final List<String> following;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.email,
    this.role = 'user',
    this.profileImageUrl,
    this.bannerImageUrl,
    this.bio = '',
    this.followers = const [],
    this.following = const [],
    String? uuid,
    DateTime? createdAt,
  })  : uuid = uuid ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'uuid': uuid,
      'name': name,
      'username': username,
      'email': email,
      'role': role,
      'profileImageUrl': profileImageUrl,
      'bannerImageUrl': bannerImageUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      uuid: map['uuid'] ?? const Uuid().v4(),
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user',
      profileImageUrl: map['profileImageUrl'],
      bannerImageUrl: map['bannerImageUrl'],
      bio: map['bio'] ?? '',
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }
}
