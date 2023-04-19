class UserModel {
  UserModel({
    this.id,
    this.photo,
    this.name,
    this.email,
  });

  int? id;
  String? photo;
  String? name;
  String? email;

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "photo": photo == null ? null : photo,
        "nama": name == null ? null : name,
        "email": email == null ? null : email,
      };
  fromJson(Map<String, dynamic> json) => {
        id: json["id"] == null ? null : json["id"],
        photo: json["photo"] == null ? null : json["photo"],
        name: json["nama"] == null ? null : json["nama"],
        email: json["email"] == null ? null : json["email"],
      };
}
