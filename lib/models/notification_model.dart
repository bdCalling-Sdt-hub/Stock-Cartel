class NotificationModel {
  final String? status;
  final int? statusCode;
  final String? message;
  final Data? data;
  final Pagination? pagination;

  NotificationModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
  final String? type;
  final List<Attribute>? attributes;

  Data({
    this.type,
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}

class Attribute {
  final String? id;
  final String? receiverId;
  final String? message;
  final String? role;
  final String? type;
  final bool? viewStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Attribute({
    this.id,
    this.receiverId,
    this.message,
    this.role,
    this.type,
    this.viewStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["_id"],
        receiverId: json["receiverId"],
        message: json["message"],
        role: json["role"],
        type: json["type"],
        viewStatus: json["viewStatus"],
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
        "receiverId": receiverId,
        "message": message,
        "role": role,
        "type": type,
        "viewStatus": viewStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Pagination {
  final int? totalPages;
  final int? currentPage;
  final dynamic prevPage;
  final int? nextPage;
  final int? totalNotification;

  Pagination({
    this.totalPages,
    this.currentPage,
    this.prevPage,
    this.nextPage,
    this.totalNotification,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
        totalNotification: json["totalNotification"],
      );

  Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "currentPage": currentPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
        "totalNotification": totalNotification,
      };
}
