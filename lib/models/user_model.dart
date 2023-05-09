class UserModel {
  static const COLLECTION_NAME = "Users";
  String id;
  String? photo;
  String name;
  String Email;
  UserModel({
    this.id = '',
    this.photo,
    required this.name,
    required this.Email,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo == null ? null : photo,
        "nama": name,
        "email": Email,
      };
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          photo: json["photo"],
          name: json["nama"],
          Email: json["email"],
        );
}
