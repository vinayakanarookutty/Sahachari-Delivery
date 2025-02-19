import 'package:flutter/material.dart';
import 'package:nexamart_delivary/Common/widgets/custon_button.dart';
import 'package:nexamart_delivary/constants/global_variables.dart';
import 'package:nexamart_delivary/constants/utils.dart';
import 'package:nexamart_delivary/features/delivery/screens/delivary_screen.dart';
import 'package:nexamart_delivary/features/delivery/services/delivery_service.dart';
import 'package:nexamart_delivary/features/search/screens/search_screen.dart';
import 'package:nexamart_delivary/models/order.dart';
import 'package:nexamart_delivary/models/user_data.dart';
import 'package:nexamart_delivary/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final DeliveryServices deliveryServices = DeliveryServices();
  int currentStep = 0;
  UserData? userData;
  List<Map<String, dynamic>> adminAddresses = [];
  bool isOrderAccepted = false;
  bool isLoading = true;

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    currentStep = widget.order.status;
    super.initState();
    currentStep = widget.order.status.clamp(0, 2);
    fetchUserData();
    fetchAdminAddresses();
    // changeOrderStatus(currentStep);
  }

  Future<void> fetchAdminAddresses() async {
    List<String> adminId = widget.order.products[0].adminId is String
        ? [widget.order.products[0].adminId.toString()]
        : (widget.order.products[0].adminId as List<dynamic>)
        .map((e) => e as String)
        .toList();

    try {
      final addresses =
      await deliveryServices.getAdminAddresses(context, adminId);
      setState(() {
        adminAddresses = addresses.map((address) => address.toMap()).toList();
        isLoading = false;
      });
    } catch (e) {
      showSnackbar(context, 'Error fetching admin addresses: $e');
      setState(() {
        isLoading = false;
      });
    }
  }


  void changeOrderStatus(int status) {
    deliveryServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  Future<void> fetchUserData() async {
    String userId = widget.order.userId;
    try {
      UserData? fetchUser = await deliveryServices.getUserData(context, userId);
      if (fetchUser != null) {
        setState(() {
          userData = fetchUser;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        userData = null;
      });
    }
  }

  void _launchDialer(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _acceptOrder() async {
    final success =
        await deliveryServices.acceptOrder(widget.order.id, context);
    if (success) {
      setState(() {
        isOrderAccepted = true; // Mark the order as accepted
      });
      Navigator.pushReplacementNamed(
        context,
        DelivaryScreen.routeName,
        arguments: 1,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order accepted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept order ${widget.order.id}')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text('Order Details'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date:    ${DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.order.orderedAt),
                      )}',
                    ),
                    Text("Order ID:        ${widget.order.id}"),
                    Text("Order Total:    \₹${widget.order.totalPrice}")
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Purchase Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
              const Text(
                'Pickup Addresses',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
                child: isLoading
                    ? Text('Loading Pickup Address...')
                    : adminAddresses.isEmpty
                    ? const Text("No pickup addresses available.")
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: adminAddresses.length,
                  itemBuilder: (context, index) {
                    final admin = adminAddresses[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Admin Name: ${admin['name']}",
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Admin Address: ${admin['address']}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Delivery Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (userData != null) ...[
                      Text(
                        "User Name:    ${userData!.name}",
                        softWrap: true,
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.visible,
                      ),
                      Text(
                        "User Address:    ${userData!.address}",
                        softWrap: true,
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.visible,
                      ),
                      GestureDetector(
                        onTap: () => _launchDialer(userData!.phoneNo),
                        child: Text(
                          "Phone Number: ${userData!.phoneNo}",
                          softWrap: true,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ] else if (userData == null) ...[
                      const Text("Loading Delivery Details..."),
                    ],
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(text: 'Accept Order', onTap: _acceptOrder),
              )
            ],
          ),
        ),
      ),
    );
  }
}
