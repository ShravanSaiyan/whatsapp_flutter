class UserModel {
  final String name;
  final String userId;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;

  const UserModel({
    required this.name,
    required this.userId,
    required this.profilePic,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      userId: map['userId'] as String,
      profilePic: map['profilePic'] as String,
      isOnline: map['isOnline'] as bool,
      phoneNumber: map['phoneNumber'] as String,
      groupId: List<String>.from(map['groupId']),
    );
  }
}
