class Message {
  static const COLLECTION_NAME = "Messages";

  String senderName;
  String senderId;
  String content;
  int dateTime;
  String roomId;
  String id;
  Message(
      {required this.content,
      required this.dateTime,
      required this.roomId,
      required this.senderId,
      required this.senderName,
      this.id = ""});

  Map<String, dynamic> toJson() => {
        "content": content,
        "id": id,
        "dateTime": dateTime,
        "roomId": roomId,
        "senderId": senderId,
        "senderName": senderName
      };

  Message.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            senderName: json["senderName"],
            content: json["content"],
            dateTime: json["dateTime"],
            roomId: json["roomId"],
            senderId: json["senderId"]);
}
