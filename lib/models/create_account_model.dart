class CreateAccountModel {
  final String? id;
  final String? name;
  final bool? privacyPolicyAccepted;
  final bool? isAdmin;
  final bool? isVerified;
  final bool? isDeleted;
  final bool? isBlocked;
  final bool? isPassword;
  final Image? image;
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

  CreateAccountModel({
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

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) => CreateAccountModel(
        id: json["_id"],
        name: json["name"],
        privacyPolicyAccepted: json["privacyPolicyAccepted"],
        isAdmin: json["isAdmin"],
        isVerified: json["isVerified"],
        isDeleted: json["isDeleted"],
        isBlocked: json["isBlocked"],
        isPassword: json["isPassword"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        subscription: json["subscription"],
        oneTimeCode: json["oneTimeCode"],
        phone: json["phone"],
        subscriptionStartDate: json["subscriptionStartDate"] == null
            ? null
            : DateTime.parse(json["subscriptionStartDate"]),
        subscriptionEndDate: json["subscriptionEndDate"] == null
            ? null
            : DateTime.parse(json["subscriptionEndDate"]),
        paymentStatus: json["paymentStatus"],
        online: json["online"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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

class Image {
  final dynamic path;
  final String? publicFileUrl;

  Image({
    this.path,
    this.publicFileUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        path: json["path"],
        publicFileUrl: json["publicFileURL"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "publicFileURL": publicFileUrl,
      };
}
