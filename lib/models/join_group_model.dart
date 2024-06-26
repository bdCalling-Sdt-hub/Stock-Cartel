class JoinGroupModel {
  final String? status;
  final int? statusCode;
  final String? message;
  final Data? data;
  final Pagination? pagination;

  JoinGroupModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory JoinGroupModel.fromJson(Map<String, dynamic> json) => JoinGroupModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
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
    attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"]!.map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class Attribute {
  final LastMessage? lastMessage;
  final String? id;
  final String? roomId;
  final String? adminId;
  final List<String>? participantsId;
  final String? name;
  final Avatar? avatar;
  final String? groupType;
  final Map<String, int>? unreadMessages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Attribute({
    this.lastMessage,
    this.id,
    this.roomId,
    this.adminId,
    this.participantsId,
    this.name,
    this.avatar,
    this.groupType,
    this.unreadMessages,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    id: json["_id"],
    roomId: json["roomId"],
    adminId: json["adminId"],
    participantsId: json["participantsId"] == null ? [] : List<String>.from(json["participantsId"]!.map((x) => x)),
    name: json["name"],
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
    groupType: json["groupType"],
    unreadMessages: Map.from(json["unreadMessages"]!).map((k, v) => MapEntry<String, int>(k, v)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "lastMessage": lastMessage?.toJson(),
    "_id": id,
    "roomId": roomId,
    "adminId": adminId,
    "participantsId": participantsId == null ? [] : List<dynamic>.from(participantsId!.map((x) => x)),
    "name": name,
    "avatar": avatar?.toJson(),
    "groupType": groupType,
    "unreadMessages": Map.from(unreadMessages!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Avatar {
  final String? path;
  final String? publicFileUrl;

  Avatar({
    this.path,
    this.publicFileUrl,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    path: json["path"],
    publicFileUrl: json["publicFileURL"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "publicFileURL": publicFileUrl,
  };
}

class LastMessage {
  final Avatar? file;
  final String? message;
  final String? messageType;
  final String? owner;
  final DateTime? createdAt;

  LastMessage({
    this.file,
    this.message,
    this.messageType,
    this.owner,
    this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    file: json["file"] == null ? null : Avatar.fromJson(json["file"]),
    message: json["message"],
    messageType: json["messageType"],
    owner: json["owner"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "file": file?.toJson(),
    "message": message,
    "messageType": messageType,
    "owner": owner,
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Pagination {
  final int? totalPages;
  final int? currentPage;
  final dynamic prevPage;
  final dynamic nextPage;
  final int? totalEvents;

  Pagination({
    this.totalPages,
    this.currentPage,
    this.prevPage,
    this.nextPage,
    this.totalEvents,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    prevPage: json["prevPage"],
    nextPage: json["nextPage"],
    totalEvents: json["totalEvents"],
  );

  Map<String, dynamic> toJson() => {
    "totalPages": totalPages,
    "currentPage": currentPage,
    "prevPage": prevPage,
    "nextPage": nextPage,
    "totalEvents": totalEvents,
  };
}
