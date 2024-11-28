class Order {
  final int id;
  final List<OrderItem> products;
  final int totalPrice;
  final String date;

  Order({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.date,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      products: (json['products'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalPrice: json['total_price'],
      date: json['date'],
    );
  }
}

class OrderItem {
  final int productId;
  final String name;
  final int price;
  final int quantity;
  final String imageUrl;

  OrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      imageUrl: json['image_url'],
    );
  }
}