class JoinedUsers {
  static const COLLECTION_NAME = "Users";
  String UserId;
  String RoomId;
  JoinedUsers({required this.UserId, required this.RoomId});

  Map<String, dynamic> toJson() => {'userId': UserId, 'roomId': RoomId};

  JoinedUsers.fromJson(Map<String, dynamic> json)
      : this(UserId: json['userId'], RoomId: json['roomId']);
}
