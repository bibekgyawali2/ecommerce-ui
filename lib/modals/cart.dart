class Cart {
  int? id;
  String? name;
  String? price;
  String? img;
  int? quantity;
  String? isExist;
  String? time;
  String? product;

  Cart(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExist,
      this.time,
      this.product});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = json['product'];
  }
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      img: map['img'],
      quantity: map['quantity'],
      isExist: map['isExist'],
      time: map['time'],
      product: map['product'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['img'] = this.img;
    data['quantity'] = this.quantity;
    data['isExist'] = this.isExist;
    data['time'] = this.time;
    data['product'] = this.product;
    return data;
  }
}
