class ProductsModel {
  int? id;
  String? name;
  String? price;
  String? description;
  String? stars;
  String? img;
  String? location;
  int? typeId;

  ProductsModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.stars,
    this.img,
    this.location,
    this.typeId,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      stars: json['stars'],
      img: json['img'],
      location: json['location'],
      typeId: json['typeId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['stars'] = stars;
    data['img'] = img;
    data['location'] = location;
    data['typeId'] = typeId;
    return data;
  }
}
