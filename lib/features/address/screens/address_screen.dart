// import 'package:flutter/material.dart';
// import 'package:nexamart_delivary/Common/widgets/custom_textfield.dart';
// import 'package:nexamart_delivary/constants/global_variables.dart';
// import 'package:nexamart_delivary/constants/utils.dart';
// import 'package:nexamart_delivary/features/address/services/address_services.dart';
// import 'package:nexamart_delivary/provider/user_provider.dart';
// import 'package:pay/pay.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:provider/provider.dart';
//
// class AddressScreen extends StatefulWidget {
//   final String totalAmount;
//   static const String routeName = '/address';
//   const AddressScreen({super.key, required this.totalAmount});
//
//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }
//
// class _AddressScreenState extends State<AddressScreen> {
//   final _addressFormKey = GlobalKey<FormState>();
//
//   final TextEditingController flatBuildingController = TextEditingController();
//   final TextEditingController areaController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//
//   final AddressServices addressServices = AddressServices();
//
//   String addressToBeUsed = '';
//   final List<PaymentItem> paymentItem = [];
//
//   String applePayConfig = '';
//   String googlePayConfig = '';
//
//   @override
//   void initState() {
//     super.initState();
//     paymentItem.add(
//       PaymentItem(
//           amount: widget.totalAmount,
//           label: 'Total Amount',
//           status: PaymentItemStatus.final_price),
//     );
//     _loadPayConfig();
//   }
//
//   Future<void> _loadPayConfig() async {
//     try {
//       applePayConfig = await rootBundle.loadString('assets/applepay.json');
//       googlePayConfig = await rootBundle.loadString('assets/gpay.json');
//
//       setState(() {});
//     } catch (e) {
//       // Handle error
//     }
//   }
//
//   void onApplePayResult(res) {
//     if (Provider.of<UserProvider>(context, listen: false)
//         .user
//         .address
//         .isEmpty) {
//       addressServices.saveUserAdress(
//           context: context, address: addressToBeUsed);
//     }
//     addressServices.placeOrder(
//       context: context,
//       address: addressToBeUsed,
//       totalSum: double.parse(widget.totalAmount),
//     );
//   }
//
//   void onGooglePayResult(res) {
//     if (Provider.of<UserProvider>(context, listen: false)
//         .user
//         .address
//         .isEmpty) {
//       addressServices.saveUserAdress(
//           context: context, address: addressToBeUsed);
//     }
//     addressServices.placeOrder(
//       context: context,
//       address: addressToBeUsed,
//       totalSum: double.parse(widget.totalAmount),
//     );
//   }
//
//   void payPressed(String addressFromProvider) {
//     addressToBeUsed = "";
//
//     bool isFormFilled = flatBuildingController.text.isNotEmpty ||
//         areaController.text.isNotEmpty ||
//         pincodeController.text.isNotEmpty ||
//         cityController.text.isNotEmpty;
//
//     if (isFormFilled) {
//       if (_addressFormKey.currentState!.validate()) {
//         addressToBeUsed =
//             '${flatBuildingController.text},${areaController.text},${cityController.text} - ${pincodeController.text}';
//       } else {
//         showSnackbar(context, 'Please enter all details correctly');
//         return;
//       }
//     } else if (addressFromProvider.isNotEmpty) {
//       addressToBeUsed = addressFromProvider;
//     } else {
//       showSnackbar(context, 'Please provide an address');
//       return;
//     }
//   }
//
//   @override
//   void dispose() {
//     flatBuildingController.dispose();
//     areaController.dispose();
//     pincodeController.dispose();
//     cityController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var address = context.watch<UserProvider>().user.address;
//     if (applePayConfig.isEmpty || googlePayConfig.isEmpty) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//           title: Container(
//             alignment: Alignment.topLeft,
//             child: Image.asset(
//               'assets/images/Logo.png',
//               width: 120,
//               height: 60,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               if (address)
//                 Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black12)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           address,
//                           style: const TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text(
//                       'OR',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               Form(
//                 key: _addressFormKey,
//                 child: Column(
//                   children: [
//                     CustomTextfield(
//                       controller: flatBuildingController,
//                       hintText: 'Flat, House no, Building',
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     CustomTextfield(
//                       controller: areaController,
//                       hintText: 'Area Street',
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     CustomTextfield(
//                       controller: pincodeController,
//                       hintText: 'Pincode',
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     CustomTextfield(
//                       controller: cityController,
//                       hintText: 'Town/City',
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//               ApplePayButton(
//                 onPressed: () {
//                   payPressed(address);
//                 },
//                 width: double.infinity,
//                 height: 50,
//                 style: ApplePayButtonStyle.whiteOutline,
//                 type: ApplePayButtonType.buy,
//                 paymentConfiguration:
//                     PaymentConfiguration.fromJsonString(applePayConfig),
//                 paymentItems: paymentItem,
//                 onPaymentResult: onApplePayResult,
//                 margin: const EdgeInsets.only(top: 15),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               GooglePayButton(
//                 onPressed: () => payPressed(address),
//                 paymentConfiguration:
//                     PaymentConfiguration.fromJsonString(googlePayConfig),
//                 paymentItems: paymentItem,
//                 onPaymentResult: onGooglePayResult,
//                 width: double.infinity,
//                 height: 50,
//                 theme: GooglePayButtonTheme.light,
//                 type: GooglePayButtonType.buy,
//                 margin: const EdgeInsets.only(top: 5),
//                 loadingIndicator: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
