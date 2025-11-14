import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/home_screen.dart';
import 'package:mee_safe/feathers/user/all_category_screen.dart';
import 'package:mee_safe/feathers/user/blog_screen.dart';
import 'package:mee_safe/feathers/user/corporate_trade_in_screen.dart';
import 'package:mee_safe/feathers/user/order_screen.dart';
import 'package:mee_safe/feathers/user/our_store_screen.dart';
import 'package:mee_safe/feathers/user/profile_screen.dart';
import 'package:mee_safe/feathers/user/recent_services_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  bool _isMoreOpen = false;
  bool _isDrawerOpen = false; // 🆕 For sidebar toggle

  final List<Widget> _pages = const [
    SellHomeScreen(),
    AllCategoryScreen(),
    ProfileScreen(),
    RecentServicesScreen(),
    MyOrdersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth > 900;

        // 💻 WEB LAYOUT (Now with Drawer)
        if (isWeb) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: Row(
              children: [
                // 🧭 Collapsible Sidebar Drawer
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isDrawerOpen ? 240 : 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Icon(Icons.verified_user,
                          size: 40, color: AppColors.primary),
                      if (_isDrawerOpen)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "MeeSafe",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      const Divider(thickness: 0.5),
                      _buildSidebarItem(Icons.currency_rupee, "Sell", 0),
                      _buildSidebarItem(Icons.category_outlined, "All Category", 1),
                      _buildSidebarItem(Icons.person_outline, "Profile", 2),
                      _buildSidebarItem(Icons.menu, "More", 3),
                      _buildSidebarItem(Icons.shopping_bag_outlined, "Orders", 4),
                    ],
                  ),
                ),

                // 🌐 Main Content Area
                Expanded(
                  child: Column(
                    children: [
                      // 🔝 TOP NAVBAR (with Drawer Button)
                      Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _isDrawerOpen
                                        ? Icons.menu_open
                                        : Icons.menu,
                                    color: Colors.black87,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isDrawerOpen = !_isDrawerOpen;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "MeeSafe Dashboard",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                _buildTopNavItem(Icons.currency_rupee, "Sell", 0),
                                _buildTopNavItem(
                                    Icons.category_outlined, "All Category", 1),
                                _buildTopNavItem(Icons.person_outline, "Profile", 2),
                                // Hover “More” dropdown
                                MouseRegion(
                                  onEnter: (_) =>
                                      setState(() => _isMoreOpen = true),
                                  onExit: (_) =>
                                      setState(() => _isMoreOpen = false),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      _buildTopNavItem(Icons.menu, "More", 3),
                                      if (_isMoreOpen)
                                        Positioned(
                                          top: 60,
                                          left: 0,
                                          child: Material(
                                            elevation: 8,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  _dropdownItem(
                                                    Icons
                                                        .business_center_outlined,
                                                    "Corporate Trade-In",
                                                    () => _navigateTo(
                                                        const CorporateInTradeScreen()),
                                                  ),
                                                  _dropdownItem(
                                                    Icons
                                                        .store_mall_directory_outlined,
                                                    "Our Stores",
                                                    () => _navigateTo(
                                                        const StoreLocatorScreen()),
                                                  ),
                                                  _dropdownItem(
                                                    Icons.article_outlined,
                                                    "Blogs",
                                                    () => _navigateTo(
                                                        const BlogsScreen()),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                _buildTopNavItem(Icons.shopping_bag_outlined,
                                    "Orders", 4),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 🧩 Page Content
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            key: ValueKey(_selectedIndex),
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.05),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: _pages[_selectedIndex],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // 📱 MOBILE LAYOUT (unchanged)
        return Scaffold(
          body: SafeArea(child: _pages[_selectedIndex]),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            currentIndex: _selectedIndex,
            onTap: (index) {
              if (index == 3) {
                _showMobileMoreOptions();
              } else {
                _onItemTapped(index);
              }
            },
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.black54,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.currency_rupee), label: 'Sell'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: 'All Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: 'Orders'),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Sidebar item
  Widget _buildSidebarItem(IconData icon, String title, int index) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        if (index == 3) {
          _showMobileMoreOptions();
        } else {
          setState(() => _selectedIndex = index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected ? AppColors.primary : Colors.black54,
                size: 20),
            if (_isDrawerOpen) ...[
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : Colors.black87,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // 🔹 Top Nav Item
  Widget _buildTopNavItem(IconData icon, String title, int index) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        if (index != 3) _onItemTapped(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected ? AppColors.primary : Colors.black54,
                size: 20),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Dropdown Item for “More”
  Widget _dropdownItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 10),
            Text(title,
                style: const TextStyle(fontSize: 15, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  // 🔹 Mobile “More” bottom sheet
  void _showMobileMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            _dropdownItem(Icons.business_center_outlined, "Corporate Trade-In",
                () => _navigateTo(const CorporateInTradeScreen())),
            _dropdownItem(Icons.store_mall_directory_outlined, "Our Stores",
                () => _navigateTo(const StoreLocatorScreen())),
            _dropdownItem(Icons.article_outlined, "Blogs",
                () => _navigateTo(const BlogsScreen())),
          ],
        ),
      ),
    );
  }
}
