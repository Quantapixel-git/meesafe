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

  final List<Widget> _pages = const [
    SellHomeScreen(),
    AllCategoryScreen(),
    ProfileScreen(),
    RecentServicesScreen(),
    MyOrdersScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      _showMoreOptions(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showMoreOptions(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8 * anim1.value,
            sigmaY: 8 * anim1.value,
          ),
          child: Opacity(
            opacity: anim1.value,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: anim1,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.topRight,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 5,
                              width: 45,
                              margin: const EdgeInsets.only(bottom: 14),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            _buildOption(
                              context,
                              Icons.business_center_outlined,
                              "Corporate Trade-In",
                              () {
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CorporateInTradeScreen(),
                                  ),
                                );
                              },
                            ),
                            _buildOption(
                              context,
                              Icons.store_mall_directory_outlined,
                              "Our Stores",
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StoreLocatorScreen(),
                                  ),
                                );
                              },
                            ),
                            _buildOption(
                              context,
                              Icons.article_outlined,
                              "Blogs",
                              () {
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlogsScreen(),
                                  ),
                                );
                              },
                            ),
                            // _buildOption(
                            //   context,
                            //   Icons.more_horiz,
                            //   "More",
                            //   () {},
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 26,
                        top: 8,
                        child: AnimatedOpacity(
                          opacity: anim1.value,
                          duration: const Duration(milliseconds: 300),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOption(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_rupee),
              activeIcon: Icon(Icons.currency_rupee, size: 26),
              label: 'Sell',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              activeIcon: Icon(Icons.category, size: 26),
              label: 'All Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person, size: 26),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              activeIcon: Icon(Icons.menu, size: 26),
              label: 'More',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag, size: 26),
              label: 'Orders',
            ),
          ],
        ),
      ),
    );
  }
}
