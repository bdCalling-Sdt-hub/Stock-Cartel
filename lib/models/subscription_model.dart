class SubscriptionModel {
  final String? status;
  final int? statusCode;
  final String? message;
  final Data? data;
  final Pagination? pagination;

  SubscriptionModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.pagination,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
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
  final String? title;
  final String? duration;
  final double? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Attribute({
    this.id,
    this.title,
    this.duration,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["_id"],
    title: json["title"],
    duration: json["duration"],
    price: json["price"]?.toDouble(),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "duration": duration,
    "price": price,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Pagination {
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}
