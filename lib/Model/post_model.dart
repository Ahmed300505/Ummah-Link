class Post {
  final String id;
  final String userId;
  final String userUuid;
  final String communityName;
  final String title;
  final String content;
  final String? imageUrl;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> likedBy;
  Post({
    required this.id,
    required this.userId,
    required this.userUuid,
    required this.communityName,
    required this.title,
    required this.content,
    this.imageUrl,
    this.likesCount = 0,
    this.commentsCount = 0,
    DateTime? createdAt,
    this.updatedAt,
    this.likedBy = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      userUuid: map['userUuid'] ?? '',
      communityName: map['communityName'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'],
      likesCount: map['likesCount'] ?? 0,
      commentsCount: map['commentsCount'] ?? 0,
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: map['updatedAt']?.toDate(),
      likedBy: List<String>.from(map['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userUuid': userUuid,
      'communityName': communityName,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'likedBy': likedBy,
    };
  }
  Post copyWith({
    String? id,
    String? userId,
    String? userUuid,
    String? communityName,
    String? title,
    String? content,
    String? imageUrl,
    int? likesCount,
    int? commentsCount,
    List<String>? likedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userUuid: userUuid ?? this.userUuid,
      communityName: communityName ?? this.communityName,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      likedBy: likedBy ?? this.likedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}