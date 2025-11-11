import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mee_safe/feathers/auth/view/login_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/contact_us.dart';
import 'package:mee_safe/feathers/user/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contactItems = [
      {
        "title": "Reach us on WhatsApp",
        "subtitle": "+91-9876543210",
        "icon": Icons.phone,
        "color": Colors.green,
        "navigateTo": const WhatsAppPage(),
      },
      {
        "title": "Resolve your queries by Contact Us",
        "subtitle": "Contact Us",
        "icon": Icons.chat_bubble_outline,
        "color": AppColors.primary,
        "navigateTo": const ContactUsScreen(),
      },
      {
        "title": "For Any queries",
        "subtitle": "+91-9876543210",
        "icon": Icons.call_outlined,
        "color": Colors.pinkAccent,
        "navigateTo": const OrderQueryPage(),
      },
    ];

    final profileOptions = [
      {
        "icon": Icons.person_outline,
        "title": "Edit Profile",
        "navigateTo": const EditProfileScreen(),
      },
      {
        "icon": Icons.logout,
        "title": "Logout",
        "navigateTo": null, // Handled separately
      },
    ];

    return Scaffold(
    appBar: PreferredSize(
  preferredSize: const Size.fromHeight(kToolbarHeight),
  child: AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.primary,
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "Profile",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF000080),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Color(0xFFE9ECEF),
                  child: Icon(Icons.person, size: 40, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Tulsi Vasani",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "tulsi@example.com",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Contact Us",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          ...contactItems.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => item["navigateTo"] as Widget),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          (item["color"] as Color).withOpacity(0.1),
                      child: Icon(item["icon"] as IconData,
                          color: item["color"] as Color),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"].toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item["subtitle"].toString(),
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.grey, size: 16),
                  ],
                ),
              ),
            );
          }).toList(),

          const SizedBox(height: 25),

          const Text(
            "Account Settings",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          ...profileOptions.map((item) {
            return GestureDetector(
              onTap: () {
                if (item["title"] == "Logout") {
                  _showLogoutDialog(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => item["navigateTo"] as Widget),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(item["icon"] as IconData,
                        color: Colors.blueAccent, size: 24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item["title"].toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.grey, size: 16),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out successfully!")),
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}

// --- Sub Pages ---
class WhatsAppPage extends StatelessWidget {
  const WhatsAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WhatsApp Support")),
      body: const Center(
        child: Text("This page will open WhatsApp or handle support chat."),
      ),
    );
  }
}

class SellQueryPage extends StatelessWidget {
  const SellQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sell Queries")),
      body: const Center(child: Text("Sell Related Queries Page")),
    );
  }
}

class OrderQueryPage extends StatelessWidget {
  const OrderQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Queries")),
      body: const Center(child: Text("Order Related Queries Page")),
    );
  }
}

// --- New Functional Pages ---

class ManageAddressScreen extends StatelessWidget {
  const ManageAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Addresses")),
      body: const Center(child: Text("Manage your saved addresses here")),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "This is the Privacy Policy page. Your data is secure and not shared with third parties.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support")),
      body: const Center(
        child: Text("FAQ, support chat, and user help details."),
      ),
    );
  }
}
