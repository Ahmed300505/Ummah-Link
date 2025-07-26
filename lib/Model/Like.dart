class Like {
  final String id;
  final String postId;
  final String userId;
  final String userUuid;
  final String userName;
  final String? userProfileImage;
  final DateTime createdAt;

  Like({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userUuid,
    required this.userName,
    this.userProfileImage,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      id: map['id'] ?? '',
      postId: map['postId'] ?? '',
      userId: map['userId'] ?? '',
      userUuid: map['userUuid'] ?? '',
      userName: map['userName'] ?? '',
      userProfileImage: map['userProfileImage'],
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'userUuid': userUuid,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'createdAt': createdAt,
    };
  }
}