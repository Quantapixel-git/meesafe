import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/auth/view/login_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/contact_us.dart';
import 'package:mee_safe/feathers/user/faqs_screen.dart';
import 'package:mee_safe/feathers/user/privacy_policy.dart';
import 'package:mee_safe/feathers/user/terms_and_condi_screen.dart';
import 'package:mee_safe/feathers/user/user_review_screen.dart';
import 'package:mee_safe/feathers/user/user_warrenty_claim_screen.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.admin_panel_settings, size: 48, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  "Profile",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
           ListTile(
            leading: const Icon(Icons.reviews),
            title: const Text("Review"),
            onTap: () {
                           Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserReviewScreen()));
            },
          ),
           ListTile(
            leading: const Icon(Icons.format_align_center),
            title: const Text("Warranty Claim"),
            onTap: () {
                           Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserWarrantyClaimScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("FAQ"),
             onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FaqScreen()));
            },
          ),
           ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms & Conditions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsAndConditionsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()));
            },
          ),
             const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
             showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Logout"),
                          content: const Text(
                              "Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Logged out successfully"),
                                  ),
                                );
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        ),
                      );
            },
          ),
        ],
      ),
    );
  }
}
