class ProductsResponseModel {
  ProductsResponseModel({
    this.status,
    this.message,
    this.products,
  });

  ProductsResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  num? status;
  String? message;
  List<Products>? products;
  ProductsResponseModel copyWith({
    num? status,
    String? message,
    List<Products>? products,
  }) =>
      ProductsResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        products: products ?? this.products,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Products {
  Products({
    this.id,
    this.company,
    this.name,
    this.type,
    this.price,
    this.image,
    this.description,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    company = json['company'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
  }
  num? id;
  String? company;
  String? name;
  String? type;
  String? price;
  String? image;
  String? description;
  Products copyWith({
    num? id,
    String? company,
    String? name,
    String? type,
    String? price,
    String? image,
    String? description,
  }) =>
      Products(
        id: id ?? this.id,
        company: company ?? this.company,
        name: name ?? this.name,
        type: type ?? this.type,
        price: price ?? this.price,
        image: image ?? this.image,
        description: description ?? this.description,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company'] = company;
    map['name'] = name;
    map['type'] = type;
    map['price'] = price;
    map['image'] = image;
    map['description'] = description;
    return map;
  }
}
