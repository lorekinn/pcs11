import 'package:dio/dio.dart';
import '../models/note.dart';
import '../models/order.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080'));

  Future<List<Sweet>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      List<Sweet> products = (response.data as List)
          .map((json) => Sweet.fromJson(json))
          .toList();
      return products;
    } catch (e) {
      throw Exception('Не удалось загрузить продукты: $e');
    }
  }

  Future<void> createProduct(Sweet sweet) async {
    try {
      await _dio.post('/products', data: sweet.toJson());
    } catch (e) {
      throw Exception('Не удалось создать продукт: $e');
    }
  }

  Future<Sweet> getProductByID(int id) async {
    try {
      final response = await _dio.get('/products/$id');
      return Sweet.fromJson(response.data);
    } catch (e) {
      throw Exception('Продукт не найден: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dio.delete('/products/$id');
    } catch (e) {
      throw Exception('Не удалось удалить продукт: $e');
    }
  }


  Future<List<Order>> getOrderHistory() async {
    try {
      final response = await _dio.get('/orders');
      List<Order> orders = (response.data as List)
          .map((json) => Order.fromJson(json))
          .toList();
      return orders;
    } catch (e) {
      throw Exception('Не удалось загрузить историю заказов: $e');
    }
  }

  Future<void> createOrder(List<Sweet> orderItems, int totalCost) async {
    try {
      final data = {
        "products": orderItems
            .map((sweet) =>
        {
          "product_id": sweet.id,
          "name": sweet.name,
          "price": sweet.price,
          "quantity": sweet.quantity,
          "image_url": sweet.imageUrl,
        })
            .toList(),
        "total_price": totalCost,
      };

      await _dio.post('/orders', data: data);
    } catch (e) {
      throw Exception('Не удалось отправить заказ: $e');
    }
  }
}
