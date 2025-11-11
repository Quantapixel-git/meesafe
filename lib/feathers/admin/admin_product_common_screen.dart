import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/admin/admin_device_screen.dart';
import 'package:mee_safe/feathers/admin/admin_brand_screen.dart';
import 'package:mee_safe/feathers/admin/admin_model.dart';
import 'package:mee_safe/feathers/admin/admin_varient_screen.dart' hide Device;

class AdminProductCommonScreen extends StatelessWidget {
  const AdminProductCommonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_DashboardCard> cards = [
      _DashboardCard(
        title: "Device",
        icon: Icons.devices,
        color: AppColors.primary,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AdminDeviceScreen()),
          );
        },
      ),
      _DashboardCard(
        title: "Brand",
        icon: Icons.business_center,
        color: Colors.blue,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AdminBrandScreen()),
          );
        },
      ),
      _DashboardCard(
        title: "Model",
        icon: Icons.layers_outlined,
        color: Colors.deepPurple,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AdminModelScreen()),
          );
        },
      ),
      _DashboardCard(
        title: "Variant",
        icon: Icons.memory,
        color: Colors.green,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AdminVariantScreen(),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Product List"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          final card = cards[index];
          return GestureDetector(
            onTap: card.onTap,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: card.color.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(card.icon, color: card.color, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    card.title,
                    style: TextStyle(
                      color: card.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DashboardCard {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
