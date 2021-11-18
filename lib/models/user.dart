class User {
  final int id;
  final int permissions;
  final String avatarUrl;
  final String userName;
  final String userBio;

  User(this.id, this.permissions, this.avatarUrl, this.userName, this.userBio);
  
  factory User.fromJson(Map<String, dynamic> json) {
  User user = User(json["ID"], json["user_permissions"], json["user_avatar"],json["user_name"], json["user_bio"]);
    return user;
  }
}
