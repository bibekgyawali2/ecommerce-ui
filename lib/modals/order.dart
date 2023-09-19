class Order {
  final int id;
  final String price;
  final String status;

  Order({required this.id, required this.price, required this.status});

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      price: map['price'],
      status: map['status'],
    );
  }
}
