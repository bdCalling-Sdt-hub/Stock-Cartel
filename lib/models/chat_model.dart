class ChatMessage {
  final String? text;
  final ChatMedia? chatMedia;
  final Sender? sender;
  final DateTime? createAt;

  ChatMessage({
    this.text,
    this.chatMedia,
    this.sender,
    this.createAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    text: json["text"],
    chatMedia: json["chat_media"] == null ? null : ChatMedia.fromJson(json["chat_media"]),
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    createAt:json["create_at"]==null?null:DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "chat_media": chatMedia?.toJson(),
    "sender": sender?.toJson(),
    "create_at": createAt,
  };
}

class ChatMedia {
  final String? url;
  final String? mediaType;

  ChatMedia({
    this.url,
    this.mediaType,
  });

  factory ChatMedia.fromJson(Map<String, dynamic> json) => ChatMedia(
    url: json["url"],
    mediaType: json["media_type"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "media_type": mediaType,
  };
}

class Sender {
  final String? id;
  final String? image;

  Sender({
    this.id,
    this.image,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
