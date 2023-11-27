class UserProfile {
  String email;
  String? profilePicture;
  String userId;

  UserProfile({ required this.email,
    this.profilePicture,
    required this.userId});


  Map<String, dynamic> toJson() => {
    'email': email,
    'profilePicture': profilePicture,
    'userId': userId,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    email: json['email'] as String,
    profilePicture: json['profilePicture'] ?? '',
    userId: json['userId'] as String,
  );
}

