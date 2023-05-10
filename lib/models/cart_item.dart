class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String? imageUrl;
  final double rating;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['userId'],
      productId: json['productId'],
      title: json['name'],
      quantity: json['productCount'],
      price: json['productTotalPrice'].toDouble(),
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'productId': productId,
      'name': title,
      'productCount': quantity,
      'productTotalPrice': price,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }
}
