// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

List<ChatModel> chatModelFromJson(String str) => List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModel {
  final String? id;
  final SenderId? senderId;
  final String? roomId;
  final String? text;
  final bool? readed;
  final dynamic replyTo;
  final List<dynamic>? deletedBy;
  final String? messageType;
  final FileClass? file;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ChatModel({
    this.id,
    this.senderId,
    this.roomId,
    this.text,
    this.readed,
    this.replyTo,
    this.deletedBy,
    this.messageType,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json["_id"],
    senderId: json["senderId"] == null ? null : SenderId.fromJson(json["senderId"]),
    roomId: json["roomId"],
    text: json["text"],
    readed: json["readed"],
    replyTo: json["replyTo"],
    deletedBy: json["deletedBy"] == null ? [] : List<dynamic>.from(json["deletedBy"]!.map((x) => x)),
    messageType: json["messageType"],
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "senderId": senderId?.toJson(),
    "roomId": roomId,
    "text": text,
    "readed": readed,
    "replyTo": replyTo,
    "deletedBy": deletedBy == null ? [] : List<dynamic>.from(deletedBy!.map((x) => x)),
    "messageType": messageType,
    "file": file?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class FileClass {
  final String? publicFileUrl;
  final String? path;

  FileClass({
    this.publicFileUrl,
    this.path,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    publicFileUrl: json["publicFileURL"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrl,
    "path": path,
  };
}

class SenderId {
  final String? id;
  final String? name;
  final FileClass? image;
  final bool? online;

  SenderId({
    this.id,
    this.name,
    this.image,
    this.online,
  });

  factory SenderId.fromJson(Map<String, dynamic> json) => SenderId(
    id: json["_id"],
    name: json["name"],
    image: json["image"] == null ? null : FileClass.fromJson(json["image"]),
    online: json["online"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image?.toJson(),
    "online": online,
  };
}
