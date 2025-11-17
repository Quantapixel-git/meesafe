import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/admin/admin_drawer.dart';
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

    return LayoutBuilder(
      builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
        /// ---------------------- 📱 MOBILE VERSION -------------------------
        if (constraints.maxWidth < 700) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Manage Product List"),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
            body: _buildMobileUI(cards),
          );
        }

        /// ---------------------- 🖥 DESKTOP / WEB VERSION -------------------
        return Scaffold(
          body: Row(
            children: [
               if (isDesktop)
                SizedBox(
                  width: 250,
                  child: const AdminDrawer(),
                ),


              /// Right Content
              Expanded(
                child: Column(
                  children: [
                    _buildDesktopHeader(),
                    Expanded(child: _buildDesktopUI(cards)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 📱 MOBILE UI (Original – Not Modified)
  // ---------------------------------------------------------------------------
  Widget _buildMobileUI(List<_DashboardCard> cards) {
    return GridView.builder(
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
    );
  }

  // ---------------------------------------------------------------------------
  // 🖥 DESKTOP SIDE DRAWER (PERMANENT)
  // ---------------------------------------------------------------------------
  Widget _buildDesktopSidebar() {
    return Container(
      width: 230,
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          const Text(
            "Admin Panel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _drawerItem(Icons.dashboard, "Dashboard"),
          _drawerItem(Icons.devices, "Products"),
          _drawerItem(Icons.settings, "Settings"),
          _drawerItem(Icons.logout, "Logout"),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      hoverColor: Colors.white24,
      onTap: () {},
    );
  }

  // ---------------------------------------------------------------------------
  // 🖥 DESKTOP HEADER
  // ---------------------------------------------------------------------------
  Widget _buildDesktopHeader() {
    return Container(
      height: 70,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: const Text(
        "Manage Product List",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 🖥 DESKTOP UI CONTENT
  // ---------------------------------------------------------------------------
  Widget _buildDesktopUI(List<_DashboardCard> cards) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final card = cards[index];
        return InkWell(
          onTap: card.onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: card.color.withOpacity(0.08),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(card.icon, color: card.color, size: 50),
                const SizedBox(height: 20),
                Text(
                  card.title,
                  style: TextStyle(
                    color: card.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
