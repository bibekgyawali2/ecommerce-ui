class Order {
  final int id;
  final int userId;
  final String name;
  final double price;
  final int quantity;
  final String time;
  final String isExist;
  final List<int> product;
  final String status;
  final List<Product> products;

  Order({
    required this.id,
    required this.userId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.time,
    required this.isExist,
    required this.product,
    required this.status,
    required this.products,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    final List<dynamic> productDataList = map['product'];
    final List<int> productData =
        productDataList.map((item) => item as int).toList();

    final List<dynamic> productsList = map['products'];
    final List<Product> parsedProducts =
        productsList.map((item) => Product.fromMap(item)).toList();

    return Order(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      price: double.parse(map['price']),
      quantity: map['quantity'],
      time: map['time'],
      isExist: map['isExist'],
      product: productData,
      status: map['status'],
      products: parsedProducts,
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final int stars;
  final String img;
  final int typeId;
  final String createdAt;
  final String updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.stars,
    required this.img,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: double.parse(map['price']),
      description: map['description'],
      stars: map['stars'],
      img: map['img'],
      typeId: map['typeId'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
