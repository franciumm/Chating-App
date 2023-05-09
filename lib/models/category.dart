class Rooms {
  static const COLLECTION_NAME = "Rooms";

  String ownerid;
  String name;
  String desc;
  String cat;
  late String id;

  Rooms({
    required this.ownerid,
    required this.name,
    required this.desc,
    required this.cat,
    this.id = '',
  });

  Map<String, dynamic> toJson() =>
      {"ownerid": ownerid, "id": id, "name": name, "desc": desc, "cat": cat};

  Rooms.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            ownerid: json["ownerid"],
            name: json["name"],
            desc: json["desc"],
            cat: json["cat"]);
}
