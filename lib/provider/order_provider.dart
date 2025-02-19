// import 'package:flutter/foundation.dart';
// import 'package:nexamart_delivary/models/order.dart';
//
// class OrderProvider with ChangeNotifier {
//   List<Order> _orders = [];
//
//   List<Order> get orders => _orders;
//
//   // Fetch all orders
//   void fetchOrders(List<Order> fetchedOrders) {
//     _orders = fetchedOrders;
//     notifyListeners();
//   }
//
//   // Add a new order
//   void addOrder(Order order) {
//     _orders.add(order);
//     notifyListeners();
//   }
//
//   // Update an existing order
//   void updateOrder(String id, Order updatedOrder) {
//     final index = _orders.indexWhere((order) => order.id == id);
//     if (index != -1) {
//       _orders[index] = updatedOrder;
//       notifyListeners();
//     }
//   }
//
//   // Delete an order by ID
//   void deleteOrder(String id) {
//     _orders.removeWhere((order) => order.id == id);
//     notifyListeners();
//   }
//
//   // Get an order by ID
//   Order? getOrderById(String id) {
//     return _orders.firstWhere(
//       (order) => order.id == id,
//       orElse: () => Order(
//         id: '',
//         products: [],
//         quantity: [],
//         address: '',
//         userId: '',
//         orderedAt: 0,
//         status: 0,
//         totalPrice: 0.0,
//       ), // Explicit cast
//     );
//   }
// }
