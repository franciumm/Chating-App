class UserModel {
  String id;
  String? photo;
  String name;
  String Email;
  UserModel({
    required this.id,
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
  fromJson(Map<String, dynamic> json) => {
        id: json["id"],
        photo: json["photo"],
        name: json["nama"],
        Email: json["email"],
      };
}
