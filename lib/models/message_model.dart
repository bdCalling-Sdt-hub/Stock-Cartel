class MessageModel {
  final String? status;
  final int? statusCode;
  final String? message;
  final Data? data;
  final Pagination? pagination;

  MessageModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
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
  final String? id;
  final SenderId? senderId;
  final String? roomId;
  final String? text;
  final List<ParticipantsId>? participantsId;
  final bool? readed;
  final dynamic replyTo;
  final List<dynamic>? deletedBy;
  final MessageType? messageType;
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
    senderId: json["senderId"] == null ? null : SenderId.fromJson(json["senderId"]),
    roomId: json["roomId"],
    text: json["text"],
    participantsId: json["participantsId"] == null ? [] : List<ParticipantsId>.from(json["participantsId"]!.map((x) => ParticipantsId.fromJson(x))),
    readed: json["readed"],
    replyTo: json["replyTo"],
    deletedBy: json["deletedBy"] == null ? [] : List<dynamic>.from(json["deletedBy"]!.map((x) => x)),
    messageType: messageTypeValues.map[json["messageType"]]!,
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "senderId": senderId?.toJson(),
    "roomId": roomId,
    "text": text,
    "participantsId": participantsId == null ? [] : List<dynamic>.from(participantsId!.map((x) => x.toJson())),
    "readed": readed,
    "replyTo": replyTo,
    "deletedBy": deletedBy == null ? [] : List<dynamic>.from(deletedBy!.map((x) => x)),
    "messageType": messageTypeValues.reverse[messageType],
    "file": file?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class FileClass {
  final PublicFileUrl? publicFileUrl;
  final Path? path;

  FileClass({
    this.publicFileUrl,
    this.path,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    publicFileUrl: publicFileUrlValues.map[json["publicFileURL"]]!,
    path: pathValues.map[json["path"]]!,
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrlValues.reverse[publicFileUrl],
    "path": pathValues.reverse[path],
  };
}

enum Path {
  NULL
}

final pathValues = EnumValues({
  "null": Path.NULL
});

enum PublicFileUrl {
  IMAGES_GROUPS_GROUP_PNG,
  IMAGES_USERS_1718260216216_IMAGE_JPG,
  IMAGES_USERS_1718441075678_CARTEL_LOGO_PNG
}

final publicFileUrlValues = EnumValues({
  "/images/groups/group.png": PublicFileUrl.IMAGES_GROUPS_GROUP_PNG,
  "/images/users/1718260216216-image.jpg": PublicFileUrl.IMAGES_USERS_1718260216216_IMAGE_JPG,
  "/images/users/1718441075678-cartel-logo.png": PublicFileUrl.IMAGES_USERS_1718441075678_CARTEL_LOGO_PNG
});

enum MessageType {
  TEXT
}

final messageTypeValues = EnumValues({
  "text": MessageType.TEXT
});

class ParticipantsId {
  final Id? id;
  final Name? name;
  final bool? privacyPolicyAccepted;
  final bool? isAdmin;
  final bool? isVerified;
  final bool? isDeleted;
  final bool? isBlocked;
  final bool? isPassword;
  final FileClass? image;
  final Subscription? subscription;
  final dynamic oneTimeCode;
  final String? phone;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final PaymentStatus? paymentStatus;
  final bool? online;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ParticipantsId({
    this.id,
    this.name,
    this.privacyPolicyAccepted,
    this.isAdmin,
    this.isVerified,
    this.isDeleted,
    this.isBlocked,
    this.isPassword,
    this.image,
    this.subscription,
    this.oneTimeCode,
    this.phone,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.paymentStatus,
    this.online,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ParticipantsId.fromJson(Map<String, dynamic> json) => ParticipantsId(
    id: idValues.map[json["_id"]]!,
    name: nameValues.map[json["name"]]!,
    privacyPolicyAccepted: json["privacyPolicyAccepted"],
    isAdmin: json["isAdmin"],
    isVerified: json["isVerified"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    isPassword: json["isPassword"],
    image: json["image"] == null ? null : FileClass.fromJson(json["image"]),
    subscription: subscriptionValues.map[json["subscription"]]!,
    oneTimeCode: json["oneTimeCode"],
    phone: json["phone"],
    subscriptionStartDate: json["subscriptionStartDate"] == null ? null : DateTime.parse(json["subscriptionStartDate"]),
    subscriptionEndDate: json["subscriptionEndDate"] == null ? null : DateTime.parse(json["subscriptionEndDate"]),
    paymentStatus: paymentStatusValues.map[json["paymentStatus"]]!,
    online: json["online"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "name": nameValues.reverse[name],
    "privacyPolicyAccepted": privacyPolicyAccepted,
    "isAdmin": isAdmin,
    "isVerified": isVerified,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "isPassword": isPassword,
    "image": image?.toJson(),
    "subscription": subscriptionValues.reverse[subscription],
    "oneTimeCode": oneTimeCode,
    "phone": phone,
    "subscriptionStartDate": subscriptionStartDate?.toIso8601String(),
    "subscriptionEndDate": subscriptionEndDate?.toIso8601String(),
    "paymentStatus": paymentStatusValues.reverse[paymentStatus],
    "online": online,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

enum Id {
  THE_66614_BDE42049454_ED45_D594,
  THE_66629_F5_E2_D237_F4255_F46219
}

final idValues = EnumValues({
  "66614bde42049454ed45d594": Id.THE_66614_BDE42049454_ED45_D594,
  "66629f5e2d237f4255f46219": Id.THE_66629_F5_E2_D237_F4255_F46219
});

enum Name {
  AHAD_HOSSAIN_AIMAN,
  MR_SWAPON
}

final nameValues = EnumValues({
  "Ahad Hossain Aiman": Name.AHAD_HOSSAIN_AIMAN,
  "Mr Swapon": Name.MR_SWAPON
});

enum PaymentStatus {
  PAID,
  UNPAID
}

final paymentStatusValues = EnumValues({
  "paid": PaymentStatus.PAID,
  "unpaid": PaymentStatus.UNPAID
});

enum Subscription {
  FREE,
  WEEKLY
}

final subscriptionValues = EnumValues({
  "free": Subscription.FREE,
  "weekly": Subscription.WEEKLY
});

class SenderId {
  final Id? id;
  final Name? name;
  final FileClass? image;
  final bool? online;

  SenderId({
    this.id,
    this.name,
    this.image,
    this.online,
  });

  factory SenderId.fromJson(Map<String, dynamic> json) => SenderId(
    id: idValues.map[json["_id"]]!,
    name: nameValues.map[json["name"]]!,
    image: json["image"] == null ? null : FileClass.fromJson(json["image"]),
    online: json["online"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "name": nameValues.reverse[name],
    "image": image?.toJson(),
    "online": online,
  };
}

class Pagination {
  final int? totalPages;
  final int? currentPage;
  final dynamic prevPage;
  final int? nextPage;
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
