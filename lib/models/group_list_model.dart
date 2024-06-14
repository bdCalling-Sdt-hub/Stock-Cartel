class GroupListModel {
  final LastMessage? lastMessage;
  final String? id;
  final String? roomId;
  final Id? adminId;
  final List<Id>? participantsId;
  final String? name;
  final Avatar? avatar;
  final String? groupType;
  final UnreadMessages? unreadMessages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  GroupListModel({
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

  factory GroupListModel.fromJson(Map<String, dynamic> json) => GroupListModel(
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    id: json["_id"],
    roomId: json["roomId"],
    adminId: json["adminId"] == null ? null : Id.fromJson(json["adminId"]),
    participantsId: json["participantsId"] == null ? [] : List<Id>.from(json["participantsId"]!.map((x) => Id.fromJson(x))),
    name: json["name"],
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
    groupType: json["groupType"],
    unreadMessages: json["unreadMessages"] == null ? null : UnreadMessages.fromJson(json["unreadMessages"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "lastMessage": lastMessage?.toJson(),
    "_id": id,
    "roomId": roomId,
    "adminId": adminId?.toJson(),
    "participantsId": participantsId == null ? [] : List<dynamic>.from(participantsId!.map((x) => x.toJson())),
    "name": name,
    "avatar": avatar?.toJson(),
    "groupType": groupType,
    "unreadMessages": unreadMessages?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Id {
  final String? id;
  final String? name;
  final bool? privacyPolicyAccepted;
  final bool? isAdmin;
  final bool? isVerified;
  final bool? isDeleted;
  final bool? isBlocked;
  final bool? isPassword;
  final Avatar? image;
  final String? subscription;
  final dynamic oneTimeCode;
  final String? phone;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final String? paymentStatus;
  final bool? online;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Id({
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

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"],
    name: json["name"],
    privacyPolicyAccepted: json["privacyPolicyAccepted"],
    isAdmin: json["isAdmin"],
    isVerified: json["isVerified"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    isPassword: json["isPassword"],
    image: json["image"] == null ? null : Avatar.fromJson(json["image"]),
    subscription: json["subscription"],
    oneTimeCode: json["oneTimeCode"],
    phone: json["phone"],
    subscriptionStartDate: json["subscriptionStartDate"] == null ? null : DateTime.parse(json["subscriptionStartDate"]),
    subscriptionEndDate: json["subscriptionEndDate"] == null ? null : DateTime.parse(json["subscriptionEndDate"]),
    paymentStatus: json["paymentStatus"],
    online: json["online"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "privacyPolicyAccepted": privacyPolicyAccepted,
    "isAdmin": isAdmin,
    "isVerified": isVerified,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "isPassword": isPassword,
    "image": image?.toJson(),
    "subscription": subscription,
    "oneTimeCode": oneTimeCode,
    "phone": phone,
    "subscriptionStartDate": subscriptionStartDate?.toIso8601String(),
    "subscriptionEndDate": subscriptionEndDate?.toIso8601String(),
    "paymentStatus": paymentStatus,
    "online": online,
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

class UnreadMessages {
  final int? the66629F5E2D237F4255F46219;

  UnreadMessages({
    this.the66629F5E2D237F4255F46219,
  });

  factory UnreadMessages.fromJson(Map<String, dynamic> json) => UnreadMessages(
    the66629F5E2D237F4255F46219: json["66629f5e2d237f4255f46219"],
  );

  Map<String, dynamic> toJson() => {
    "66629f5e2d237f4255f46219": the66629F5E2D237F4255F46219,
  };
}
