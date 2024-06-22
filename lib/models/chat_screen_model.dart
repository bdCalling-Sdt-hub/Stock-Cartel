class ChatScreenModel {
  final String? status;
  final int? statusCode;
  final String? message;
  final Data? data;
  final Pagination? pagination;

  ChatScreenModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory ChatScreenModel.fromJson(Map<String, dynamic> json) =>
      ChatScreenModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data?.toJson(),
        "pagination": pagination?.toJson(),
      };
}

class Data {
  final List<Attribute>? attributes;

  Data({
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}

class Attribute {
  final String? id;
  final SenderId? senderId;
  final String? roomId;
  final String? text;
  final List<dynamic>? participantsId;
  final bool? readed;
  final dynamic replyTo;
  final List<dynamic>? deletedBy;
  final String? messageType;
  final FileClass? file;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Attribute({
    this.id,
    this.senderId,
    this.roomId,
    this.text,
    this.participantsId,
    this.readed,
    this.replyTo,
    this.deletedBy,
    this.messageType,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["_id"],
        senderId: json["senderId"] == null
            ? null
            : SenderId.fromJson(json["senderId"]),
        roomId: json["roomId"],
        text: json["text"],
        participantsId: json["participantsId"] == null
            ? []
            : List<dynamic>.from(json["participantsId"]!.map((x) => x)),
        readed: json["readed"],
        replyTo: json["replyTo"],
        deletedBy: json["deletedBy"] == null
            ? []
            : List<dynamic>.from(json["deletedBy"]!.map((x) => x)),
        messageType: json["messageType"],
        file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "senderId": senderId?.toJson(),
        "roomId": roomId,
        "text": text,
        "participantsId": participantsId == null
            ? []
            : List<dynamic>.from(participantsId!.map((x) => x)),
        "readed": readed,
        "replyTo": replyTo,
        "deletedBy": deletedBy == null
            ? []
            : List<dynamic>.from(deletedBy!.map((x) => x)),
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

class Pagination {
  final int? totalPages;
  final int? currentPage;
  final dynamic prevPage;
  final dynamic nextPage;
  final int? totalChats;

  Pagination({
    this.totalPages,
    this.currentPage,
    this.prevPage,
    this.nextPage,
    this.totalChats,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
        totalChats: json["totalChats"],
      );

  Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "currentPage": currentPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
        "totalChats": totalChats,
      };
}
