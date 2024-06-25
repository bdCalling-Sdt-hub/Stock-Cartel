class ProfileModel {
  final String? status;
  final int? statusCode;
  final String? message;
  final Data? data;
  final Pagination? pagination;

  ProfileModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  final String? type;
  final Attributes? attributes;

  Data({
    this.type,
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
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

  Attributes({
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

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
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

class Pagination {
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}
