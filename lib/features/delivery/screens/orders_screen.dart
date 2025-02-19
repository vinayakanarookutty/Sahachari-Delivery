import 'package:flutter/material.dart';
import 'package:nexamart_delivary/Common/widgets/custom_text.dart';
import 'package:nexamart_delivary/Common/widgets/loader.dart';
import 'package:nexamart_delivary/features/delivery/services/delivery_service.dart';
import 'package:nexamart_delivary/models/order.dart';

import 'order_details_screen.dart';
// import 'package:nexamart_admin/order_details/order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final DeliveryServices deliveryService = DeliveryServices();
  List<Order>? orders;

  @override
  void initState() {
    getAllOrders();
    super.initState();
  }

  void getAllOrders() async {
    orders = await deliveryService.fetchAllOrders(context);
    setState(() {
      this.orders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.66,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                final orderData = orders![index];
                final product = orderData.products.isNotEmpty
                    ? orderData.products[0]
                    : null;
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                        arguments: orderData);
                  },
                  child: SizedBox(
                    height: 140,
                    // child: SingleProduct(
                    //   // Ensure the product index is valid
                    //   image: orderData.products.isNotEmpty
                    //       ? orderData.products[0].images[0]
                    //       : 'placeholder_image_url', // provide a placeholder image URL if there are no products
                    // ),
                    child: Container(
                      child: Column(
                        children: [
                          product != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.images.isNotEmpty
                                        ? product.images[0]
                                        : 'not available',
                                    width: double.infinity,
                                    height: 210,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 210,
                                  color: Colors.grey.shade200,
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child:
                                    // CustomText(
                                    //   text: product != null
                                    //       ? product.name
                                    //       : 'not available',
                                    //   fontSize: 16.0,
                                    //   maxLine: 1,
                                    //   textOverFlow: TextOverflow.ellipsis,
                                    //   weight: FontWeight.w600,
                                    // ),

                                    Text(
                                  product != null
                                      ? product.name
                                      : 'not available',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: product != null
                                      ? '₹${product.price.toString()}'
                                      : '₹ not available',
                                  fontSize: 14.0)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
