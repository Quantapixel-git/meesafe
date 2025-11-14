import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/auth/view/login_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/contact_us.dart';
import 'package:mee_safe/feathers/user/faqs_screen.dart';
import 'package:mee_safe/feathers/user/privacy_policy.dart';
import 'package:mee_safe/feathers/user/terms_and_condi_screen.dart';
import 'package:mee_safe/feathers/user/user_review_screen.dart';
import 'package:mee_safe/feathers/user/user_warrenty_claim_screen.dart';
import 'package:mee_safe/feathers/web/web_faqs_screen.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';
import 'package:mee_safe/feathers/web/web_private_policy_screen.dart';
import 'package:mee_safe/feathers/web/web_terms_and_conditions_screen.dart';

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FaqScreen()));
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
                  content: const Text("Are you sure you want to logout?"),
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

class UserWebSidebar extends StatelessWidget {
  final VoidCallback onClose;

  const UserWebSidebar({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: AppColors.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.admin_panel_settings,
                        size: 40, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      "Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),

                // CLOSE BUTTON (for web)
                InkWell(
                  onTap: onClose,
                  child: const Icon(Icons.close, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),

          _menuItem(context, Icons.dashboard, "Dashboard", () {
            onClose();
            Navigator.pop(context);
          }),

          _menuItem(context, Icons.reviews, "Review", () {
            onClose();
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const UserReviewScreen()));
          }),

          _menuItem(context, Icons.format_align_center, "Warranty Claim", () {
            onClose();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const UserWarrantyClaimScreen()));
          }),

          _menuItem(context, Icons.person, "FAQ", () {
            onClose();
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const WebFaqsScreen()));
          }),

          // _menuItem(context, Icons.description_outlined, "Contact Us", () {
          //   onClose();
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (_) => const ContactUsScreen()));
          // }),

          _menuItem(context, Icons.description_outlined, "Terms & Conditions",
              () {
            onClose();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const WebTermsAndConditionsScreen()));
          }),

          _menuItem(context, Icons.privacy_tip_outlined, "Privacy Policy", () {
            onClose();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const WebPrivatePolicyScreen()));
          }),

          const Divider(height: 35),

          _menuItem(context, Icons.logout, "Logout", () {
            onClose();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => WebHomeScreen()),
              (route) => false,
            );
          }),
        ],
      ),
    );
  }

  Widget _menuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
