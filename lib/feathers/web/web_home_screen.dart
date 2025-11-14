import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/order_screen.dart';
import 'package:mee_safe/feathers/user/our_store_screen.dart';
import 'package:mee_safe/feathers/user/user_drawer.dart';
import 'package:mee_safe/feathers/web/web_blog_screen.dart';
import 'package:mee_safe/feathers/web/web_corporate_trade_page.dart';
import 'package:mee_safe/feathers/web/web_faqs_screen.dart';
import 'package:mee_safe/feathers/web/web_login_signup.dart';
import 'package:mee_safe/feathers/web/web_private_policy_screen.dart';
import 'package:mee_safe/feathers/web/web_profile_screen.dart';
import 'package:mee_safe/feathers/web/web_sell_screen.dart';
import 'package:mee_safe/feathers/web/web_store_locator_screen.dart';
import 'package:mee_safe/feathers/web/web_terms_and_conditions_screen.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  bool _showSidebar = false;
  String? _hoveredMenu;
  Widget _selectedScreen = const WebSellScreen(); // default screen

  void openSidebar() {
    setState(() => _showSidebar = true);
  }

  void closeSidebar() {
    setState(() => _showSidebar = false);
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 1000;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: _selectedScreen),
            ],
          ),
          if (_showSidebar)
            Positioned.fill(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: closeSidebar,
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 280,
                      child: UserWebSidebar(
                        onClose: closeSidebar,
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

  Widget _navItem(String label) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredMenu = label),
      onExit: (_) => setState(() => _hoveredMenu = null),
      child: GestureDetector(
        onTap: () {
          if (label == 'Corporate Trade-In') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebCorporateTradePage()),
            );
          } else if (label == 'Our Stores') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StoreLocatorScreen()),
            );
          } else if (label == 'Blogs') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebBlogScreen()),
            );
          }
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight:
                _hoveredMenu == label ? FontWeight.bold : FontWeight.w500,
            color: _hoveredMenu == label ? AppColors.primary : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _navItemWithIcon(IconData icon, String label) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredMenu = label),
      onExit: (_) => setState(() => _hoveredMenu = null),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight:
                  _hoveredMenu == label ? FontWeight.bold : FontWeight.w500,
              color: _hoveredMenu == label ? AppColors.primary : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _navDropdown(String title, List<String> items) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredMenu = title),
      onExit: (_) => setState(() => _hoveredMenu = null),
      child: PopupMenuButton<String>(
        tooltip: title,
        offset: const Offset(0, 45),
        onSelected: (value) {
          if (value.startsWith('Sell')) {
            setState(() {
              _selectedScreen = const WebSellScreen();
            });
          } else if (value == 'Terms and conditions') {
            setState(() {
              _selectedScreen = const WebTermsAndConditionsScreen();
            });
          } else if (value == 'Private Policy') {
            setState(() {
              _selectedScreen = const WebPrivatePolicyScreen();
            });
          } else if (value == 'FAQ') {
            setState(() {
              _selectedScreen = const WebFaqsScreen();
            });
          }
        },
        itemBuilder: (context) => items
            .map(
              (e) => PopupMenuItem<String>(
                value: e,
                child: Text(e),
              ),
            )
            .toList(),
        child: Row(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                fontSize: 15,
                fontWeight:
                    _hoveredMenu == title ? FontWeight.bold : FontWeight.w500,
                color: _hoveredMenu == title ? Colors.red : Colors.black87,
              ),
              child: Text(title),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          ],
        ),
      ),
    );
  }

  // 🔸 DEVICE CARDS
  Widget _deviceCard(String title, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 200,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {},
          hoverColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: AppColors.primary),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebHeaderNav extends StatefulWidget {
  const WebHeaderNav({super.key});

  @override
  State<WebHeaderNav> createState() => _WebHeaderNavState();
}

class _WebHeaderNavState extends State<WebHeaderNav> {
  String? _hoveredMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ Header (Logo + Search + Login)
        Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 70),
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
                    icon: const Icon(Icons.menu, size: 26),
                    onPressed: () {
                      // Open the sidebar in parent WebHomeScreen
                      final parent = context
                          .findAncestorStateOfType<_WebHomeScreenState>();
                      parent?.openSidebar();
                    },
                  ),
                  SizedBox(width: 50,),
                  const Text(
                    "Mee Safe",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(width: 40),
                  SizedBox(
                    width: 350,
                    height: 38,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search mobile phones, laptops and more...',
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        prefixIcon: const Icon(Icons.search,
                            color: Colors.grey, size: 20),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                   OutlinedButton(
                    onPressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MyOrdersScreen()),
                        );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'My Orders',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showWebPopup(context, LoginDialog());
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Login / Sign up',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  PopupMenuButton<String>(
                    offset: const Offset(0, 45),
                    elevation: 4,
                    onSelected: (value) {
                      if (value == 'profile') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WebProfileScreen()),
                        );
                      } else if (value == 'logout') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WebHomeScreen()),
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'profile',
                        child: Row(
                          children: [
                            Icon(Icons.person_outline, size: 18),
                            SizedBox(width: 10),
                            Text("Profile"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'logout',
                        child: Row(
                          children: [
                            Icon(Icons.logout, size: 18, color: Colors.red),
                            SizedBox(width: 10),
                            Text("Logout", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    child: OutlinedButton(
                      onPressed: null, // Press handled by PopupMenu
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

        // ✅ Navigation Bar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _navItemWithIcon(
                      Icons.location_on_outlined, 'Select your location'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _navDropdown('Sell Device', [
                    'Sell Phone',
                    'Sell Tablet',
                    'Sell Laptop',
                    'Sell Console',
                  ]),
                  const SizedBox(width: 25),
                  _navItem('Corporate Trade-In'),
                  const SizedBox(width: 25),
                  _navItem('Our Stores'),
                  const SizedBox(width: 25),
                  _navItem('Blogs'),
                  const SizedBox(width: 25),
                  _navDropdown('More', [
                    'FAQ',
                    'Terms and conditions',
                    'Private Policy',
                  ]),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.black12),
      ],
    );
  }

  // ✅ Individual menu item
  Widget _navItem(String label) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredMenu = label),
      onExit: (_) => setState(() => _hoveredMenu = null),
      child: GestureDetector(
        onTap: () {
          if (label == 'Corporate Trade-In') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebCorporateTradePage()),
            );
          } else if (label == 'Our Stores') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebStoreLocatorScreen()),
            );
          } else if (label == 'Blogs') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebBlogScreen()),
            );
          }
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight:
                _hoveredMenu == label ? FontWeight.bold : FontWeight.w500,
            color: _hoveredMenu == label ? AppColors.primary : Colors.black87,
          ),
        ),
      ),
    );
  }

  // ✅ Dropdown for Sell Device and More
  Widget _navDropdown(String title, List<String> items) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredMenu = title),
      onExit: (_) => setState(() => _hoveredMenu = null),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 45),
        onSelected: (value) {
          if (value.startsWith('Sell')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebSellScreen()),
            );
          } else if (value == 'Terms and conditions') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const WebTermsAndConditionsScreen()),
            );
          } else if (value == 'Private Policy') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebPrivatePolicyScreen()),
            );
          } else if (value == 'FAQ') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebFaqsScreen()),
            );
          }
        },
        itemBuilder: (context) => items
            .map(
              (e) => PopupMenuItem<String>(
                value: e,
                child: Text(e),
              ),
            )
            .toList(),
        child: Row(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                fontSize: 15,
                fontWeight:
                    _hoveredMenu == title ? FontWeight.bold : FontWeight.w500,
                color:
                    _hoveredMenu == title ? AppColors.primary : Colors.black87,
              ),
              child: Text(title),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          ],
        ),
      ),
    );
  }

  // ✅ Location item with icon
  Widget _navItemWithIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

Future<void> showWebPopup(BuildContext context, Widget child) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    barrierColor: Colors.black.withOpacity(0.35), // background dim
    pageBuilder: (_, __, ___) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6), // blur effect
        child: Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            builder: (context, value, _) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
          ),
        ),
      );
    },
  );
}
