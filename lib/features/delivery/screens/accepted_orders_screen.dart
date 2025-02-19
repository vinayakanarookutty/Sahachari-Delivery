import 'package:flutter/material.dart';
import 'package:nexamart_delivary/Common/widgets/custom_text.dart';
import 'package:nexamart_delivary/Common/widgets/loader.dart';
import 'package:nexamart_delivary/features/delivery/services/delivery_service.dart';
import 'package:nexamart_delivary/models/order.dart';

import 'added_order_detail_screen.dart';
import 'order_details_screen.dart';

class AcceptedOrdersScreen extends StatefulWidget {
  const AcceptedOrdersScreen({super.key});

  @override
  State<AcceptedOrdersScreen> createState() => _AcceptedOrdersScreenState();
}

class _AcceptedOrdersScreenState extends State<AcceptedOrdersScreen> {
  List<Order>? acceptedOrders;
  DeliveryServices deliveryService = DeliveryServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    final acceptedOrders = await deliveryService.fetchAddedOrders(context);
    setState(() {
      this.acceptedOrders = acceptedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return acceptedOrders == null
        ? Loader()
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.66,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: acceptedOrders!.length,
              itemBuilder: (context, index) {
                final orderData = acceptedOrders![index];
                final product = orderData.products.isNotEmpty
                    ? orderData.products[0]
                    : null;
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AddedOrderDetailScreen.routeName,
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
                              CustomText(
                                text: product != null
                                    ? product.name
                                    : 'not available',
                                fontSize: 16.0,
                                maxLine: 1,
                                textOverFlow: TextOverflow.ellipsis,
                                weight: FontWeight.w600,
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
