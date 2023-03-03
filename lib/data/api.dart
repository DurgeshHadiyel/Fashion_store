class Data {
  String id;
  String image;
  String title;
  double price;
  String types;
  bool favorite;
  int cart;

  Data({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.types,
    required this.favorite,
    required this.cart,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as String,
      image: json['image'],
      title: json['title'] as String,
      price: double.parse(json['price'].toString()),
      types: json['types'] as String,
      favorite: json['favorite'] as bool,
      cart: int.parse(json['cart'].toString()),
    );
  }

  static Map<String, dynamic> toJson(Data data) {
    final Map<String, dynamic> map = {};
    map['id'] = data.id;
    map['image'] = data.image;
    map['title'] = data.title;
    map['price'] = data.price;
    map['types'] = data.types;
    map['favorite'] = data.favorite;
    map['cart'] = data.cart;
    return map;
  }
}
