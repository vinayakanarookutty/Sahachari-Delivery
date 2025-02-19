import 'package:flutter/material.dart';
import 'package:nexamart_delivary/Common/widgets/custom_text.dart';
import 'package:nexamart_delivary/features/account/services/account_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountServices accountServices = AccountServices();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: "Alexix Perera",
                    fontSize: 22,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 5),
                  CustomText(
                    text: 'perera@gmailcom',
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Personal Information",
                  fontSize: 18,
                  weight: FontWeight.bold,
                ),

              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.badge_rounded, color: Colors.grey),
                      const SizedBox(width: 12),
                      const Expanded(
                          child: CustomText(text: 'name', fontSize: 16)
                      ),
                      CustomText(text: 'perere jose', fontSize: 16)
                    ],
                  ),
                  const Divider(color: Colors.grey, thickness: 1),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      const SizedBox(width: 12),
                      Expanded(
                          child: CustomText(text: 'pincode', fontSize: 16)
                      ),
                      CustomText(text: '676525', fontSize: 16)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Account Settings",
                  fontSize: 18,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {

                    },
                    child: Row(
                      children: [
                        const Icon(Icons.password_rounded, color: Colors.grey),
                        const SizedBox(width: 12),
                        const Expanded(
                            child: CustomText(text: 'Change Password', fontSize: 16)
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  InkWell(
                    onTap: () => accountServices.logout(context),
                    child: Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.grey),
                        const SizedBox(width: 12),
                        const Expanded(
                            child: CustomText(text: 'Logout', fontSize: 16  )
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
