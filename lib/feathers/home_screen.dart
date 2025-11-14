import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/testimonial_screen.dart';
import 'package:mee_safe/feathers/user/download_now_screen.dart';
import 'package:mee_safe/feathers/user/sell_screen.dart';
import 'package:mee_safe/feathers/user/success_in_numbers.dart';
import 'package:mee_safe/feathers/user/user_drawer.dart';
import 'package:mee_safe/feathers/user/choose_brand_screen.dart';

class SellHomeScreen extends StatefulWidget {
  const SellHomeScreen({super.key});

  @override
  State<SellHomeScreen> createState() => _SellHomeScreenState();
}

class _SellHomeScreenState extends State<SellHomeScreen> {
  int _currentCarousel = 0;

  final List<String> _carouselImages = [
    'assets/images/ad_1.jpeg',
    'assets/images/ad_2.png',
    'assets/images/ad_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double horizontalPadding = width * 0.06;

    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
           InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Icon(Icons.location_on_outlined, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Select location',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
        title: const Text("Mee Safe"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           
   const SizedBox(height: 12),
 // 🔹 Advertisement Heading Section
          Column(
            children: [
              Text(
                "Exclusive Offers!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Sell your device at the best price — quick, easy & secure.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

            // 🔹 Top Advertisement Carousel
            _buildCarousel(),
            const SizedBox(height: 28),
            const Center(
              child: Text(
                'Sell Any Device, Anytime — Only on Mee Safe!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 26),

            // 🔹 Horizontal Device List
            SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _horizontalDeviceCard(
                    icon: Icons.phone_iphone,
                    label: 'Phone',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseBrandScreen(),
                        ),
                      );
                    },
                  ),
                  _horizontalDeviceCard(
                    icon: Icons.tablet_mac,
                    label: 'Tablet',
                    onTap: () {},
                  ),
                  _horizontalDeviceCard(
                    icon: Icons.laptop_mac,
                    label: 'Laptop',
                    onTap: () {},
                  ),
                  _horizontalDeviceCard(
                    icon: Icons.watch,
                    label: 'Smartwatch',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Sell all devices',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 26),
            TestimonialScreen(),
            SellScreen(),
            // BestMarketScreen(),
            const SizedBox(height: 10),
            SuccessInNumbersScreen(),
            DownloadNowScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final bool isWeb = constraints.maxWidth > 800;

      return Column(
        children: [
          CarouselSlider(
            items: _carouselImages.map((imgPath) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWeb ? 10 : 6, // 🔹 space between slides
                ),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: isWeb ? 1000 : double.infinity,
                      maxHeight: isWeb ? 350 : 200,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isWeb ? 20 : 16),
                      boxShadow: [
                        if (isWeb)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isWeb ? 20 : 16),
                      child: Image.asset(
                        imgPath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: isWeb ? 380 : 200,
              autoPlay: true,
              enlargeCenterPage: true,
              // 🔹 slightly reduced viewportFraction to leave visible spacing
              viewportFraction: isWeb ? 0.68 : 0.88,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, _) {
                setState(() {
                  _currentCarousel = index;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          // 🔹 Indicator dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _carouselImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {},
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentCarousel == entry.key ? 18.0 : 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentCarousel == entry.key
                        ? AppColors.primary
                        : Colors.grey.shade400,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    },
  );
}


  // 🔹 Horizontal Device Card
  Widget _horizontalDeviceCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary.withOpacity(0.1), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                radius: 26,
                child: Icon(icon, size: 28, color: AppColors.primary),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
