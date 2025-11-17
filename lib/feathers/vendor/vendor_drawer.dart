
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/auth/view/login_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_claim_screen.dart';
import 'package:mee_safe/feathers/vendor/vendor_company_screen.dart';
import 'package:mee_safe/feathers/vendor/vendor_plan_screen.dart';
import 'package:mee_safe/feathers/vendor/vendor_products_screen.dart';
import 'package:mee_safe/feathers/vendor/vendor_warranty_registration_page.dart';

class VendorDrawer extends StatelessWidget {
  const VendorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration:  BoxDecoration(color: AppColors.primary),
            accountName: const Text("Vendor Owner"),
            accountEmail: const Text("vendor@mobilecare.com"),
            currentAccountPicture:  CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.store, color: AppColors.primary, size: 32),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: "Dashboard",
            onTap: () {
              Navigator.pop(context);
            },
          ),
           _buildDrawerItem(
            icon: Icons.home,
            title: "Company",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VendorCompanyScreen()),
              );
            },
          ),
           _buildDrawerItem(
            icon: Icons.subscriptions_rounded,
            title: "Plan",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VendorPlanScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.devices,
            title: "Products",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VendorProductsScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.receipt_long,
            title: "Registration Warranty",
            onTap: () {
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VendorWarrantyScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.bar_chart,
            title: "Manage Claims",
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VendorClaimScreen()),
              );
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
