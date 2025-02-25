// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:nexamart_delivary/Common/widgets/custon_button.dart';
// import 'package:nexamart_delivary/Common/widgets/stars.dart';
// import 'package:nexamart_delivary/constants/utils.dart';
// import 'package:nexamart_delivary/features/address/screens/address_screen.dart';
// import 'package:nexamart_delivary/features/product_details/services/product_details_services.dart';
// import 'package:nexamart_delivary/features/search/screens/search_screen.dart';
// import 'package:nexamart_delivary/models/product.dart';
// import 'package:nexamart_delivary/provider/user_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../../constants/global_variables.dart';
//
// class ProductDetailsScreen extends StatefulWidget {
//   static const String routeName = '/product-details';
//   final Product product;
//   const ProductDetailsScreen({super.key, required this.product});
//
//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   final ProductDetailsServices productDetailsServices =
//   ProductDetailsServices();
//
//   void navigateToSearchScreen(String query) {
//     Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
//   }
//
//   double avgRating = 0;
//   double myRating = 0;
//
//   void addToCart() async {
//     productDetailsServices.addToCart(
//       context: context,
//       product: widget.product,
//     );
//   }
//
//   void navigateToAddressScreen(int sum) {
//     Navigator.pushNamed(
//       context,
//       AddressScreen.routeName,
//       arguments: sum.toString(),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     double totalRating = 0;
//     for (int i = 0; i < widget.product.rating!.length; i++) {
//       totalRating += widget.product.rating![i].rating;
//       if (widget.product.rating![i].userId ==
//           Provider.of<UserProvider>(context, listen: false).user.id) {
//         myRating = widget.product.rating![i].rating;
//       }
//     }
//     if (totalRating != 0) {
//       avgRating = totalRating / widget.product.rating!.length;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context).user;
//     double sum = 0;
//     sum = widget.product.price;
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 42,
//                   margin: const EdgeInsets.only(left: 15),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(7),
//                     elevation: 1,
//                     child: TextFormField(
//                       onFieldSubmitted: navigateToSearchScreen,
//                       decoration: InputDecoration(
//                         prefixIcon: InkWell(
//                           onTap: () {},
//                           child: const Padding(
//                             padding: EdgeInsets.only(left: 6),
//                             child: Icon(
//                               Icons.search,
//                               color: Colors.black,
//                               size: 23,
//                             ),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.only(top: 10),
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide:
//                           BorderSide(color: Colors.black38, width: 1),
//                         ),
//                         hintText: 'Search NexaMart.in',
//                         hintStyle: const TextStyle(
//                             fontWeight: FontWeight.w500, fontSize: 17),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.transparent,
//                 height: 42,
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                 ),
//                 child: const Icon(
//                   Icons.mic,
//                   color: Colors.black,
//                   size: 25,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     widget.product.id!,
//                   ),
//                   Stars(rating: avgRating),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//               child: Text(
//                 widget.product.name,
//                 style: const TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//             //PageView.builder
//             SizedBox(
//               height: 300,
//               child: PageView.builder(
//                 itemCount: widget.product.images.length,
//                 controller: PageController(viewportFraction: 1),
//                 itemBuilder: (context, index) {
//                   return Image.network(
//                     widget.product.images[index],
//                     fit: BoxFit.contain,
//                     height: 200,
//                   );
//                 },
//               ),
//             ),
//             Container(
//               color: Colors.black12,
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: RichText(
//                 text: TextSpan(
//                   text: 'Deal Price: ',
//                   style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold),
//                   children: [
//                     TextSpan(
//                       text: '\$${widget.product.price}',
//                       style: const TextStyle(
//                           fontSize: 22,
//                           color: Colors.red,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(widget.product.description),
//             ),
//             Container(
//               color: Colors.black12,
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: CustomButton(
//                 text: 'Buy Now',
//                 onTap: () => userProvider.token.isNotEmpty
//                     ? navigateToAddressScreen(sum.toInt())
//                     : showSnackbar(context, 'Please Login'),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: CustomButton(
//                 text: 'Add to Cart',
//                 onTap: () => userProvider.token.isNotEmpty
//                     ? addToCart()
//                     : showSnackbar(context, 'Please Login'),
//                 color: const Color.fromARGB(255, 252, 150, 67),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               color: Colors.black12,
//               height: 5,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.0),
//               child: Text(
//                 'Rate the Product',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//             ),
//             userProvider.token.isNotEmpty
//                 ? RatingBar.builder(
//               initialRating: myRating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemPadding: const EdgeInsets.symmetric(horizontal: 4),
//               itemBuilder: (context, _) => const Icon(
//                 Icons.star,
//                 color: Color.fromARGB(255, 238, 176, 82),
//               ),
//               onRatingUpdate: (rating) {
//                 productDetailsServices.rateProducts(
//                     context: context,
//                     product: widget.product,
//                     rating: rating);
//               },
//             )
//                 : InkWell(
//               onTap: () => showSnackbar(context, 'Please Login'),
//               child: Stars(
//                 rating: avgRating,
//                 itemSize: 45,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
