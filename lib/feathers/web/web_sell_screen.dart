import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/sell_screen.dart';
import 'package:mee_safe/feathers/web/web_brand_selection_screen.dart';
import 'package:mee_safe/feathers/web/web_footer_secton.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';

class WebSellScreen extends StatelessWidget {
  const WebSellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 900;
    final ScrollController _scrollController = ScrollController();
Widget _whyWeBestSection(bool isWide) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: isWide ? 160 : 20, vertical: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Heading
        Text(
          "Why are we the Best in Market?",
          style: TextStyle(
            fontSize: isWide ? 36 : 26,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),

        // Cards Row
        LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bestCard(
                  title: "Easy Doorstep Pickup:",
                  desc:
                      "Enjoy the convenience of our hassle-less doorstep free pickup service. We come to you, saving you time and effort.",
                  image: "assets/images/female.jpeg",
                ),
                _bestCard(
                  title: "Assured Best Price:",
                  desc:
                      "Receive the highest value for your gadgets with our guaranteed best-price offers. We ensure you get the maximum worth.",
                  image: "assets/images/male.jpeg",
                ),
                _bestCard(
                  title: "Fast Service & Instant Payment:",
                  desc:
                      "Get paid instantly with our swift and secure payment system. No delays, just quick and reliable transactions.",
                  image: "assets/images/female.jpeg",
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}


    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WebHeaderNav(),
            // 🔹 TOP BAR

            const SizedBox(height: 40),

            // 🔹 OFFER TITLE SECTION
            Column(
              children: const [
                Text(
                  'Exclusive Offers!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 OFFER IMAGE BANNER
CarouselSlider(
  options: CarouselOptions(
    height: isWide ? 280 : 200,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 3),
    enlargeCenterPage: true,
    viewportFraction: isWide ? 0.8 : 1.0,
    aspectRatio: isWide ? 16 / 6 : 16 / 9,
  ),
  items: [
    'assets/images/ad_1.jpeg',
    'assets/images/ad_2.png',
    'assets/images/ad_3.png',
  ].map((imagePath) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: isWide ? 800 : double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }).toList(),
),

            const SizedBox(height: 15),

            // 🔹 DOT INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 🔹 MAIN TITLE
            const Text(
              'Registered Any Device, Anytime — Only on Mee Safe!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 40),

          // 🔹 DEVICE CATEGORY CARDS (Horizontal scroll with arrows)
Padding(
  padding: EdgeInsets.symmetric(horizontal: isWide ? 160 : 20, vertical: 20),
  child: SizedBox(
    height: 140,
    child: Stack(
      children: [
        // List of cards
        ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: [
            _deviceCard('Phone', Icons.phone_android, context),
            _deviceCard('Tablet', Icons.tablet_mac, context),
            _deviceCard('Laptop', Icons.laptop_mac, context),
            _deviceCard('Smartwatch', Icons.watch, context),
            _deviceCard('Gaming Console', Icons.videogame_asset, context),
            _deviceCard('TV', Icons.tv, context),
          ].map((card) => Padding(
            padding: const EdgeInsets.only(right: 20),
            child: card,
          )).toList(),
        ),

        // Left Arrow
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                _scrollController.animateTo(
                  _scrollController.offset - 200,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Container(
                width: 40,
                color: Colors.transparent,
                child: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 20),
              ),
            ),
          ),
        ),

        // Right Arrow
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                _scrollController.animateTo(
                  _scrollController.offset + 200,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Container(
                width: 40,
                color: Colors.transparent,
                child: const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 20),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),


            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'all devices',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 80),

            // ============================
            // 🔹 EXCLUSIVE WEB SECTIONS
            // ============================

            // ✅ TESTIMONIAL SECTION
            _testimonialSection(isWide),
            _whyWeBestSection(isWide),
            SellScreen(),

            const SizedBox(height: 80),

            // ✅ SUCCESS IN NUMBERS SECTION
            _successInNumbers(isWide),

            const SizedBox(height: 80),

            // ✅ DOWNLOAD NOW SECTION
            _downloadNowSection(isWide),
            FooterSection(),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _bestCard({
  required String title,
  required String desc,
  required String image,
}) {
  return MouseRegion(
    onEnter: (event) {},
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          )
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color.fromARGB(255, 199, 198, 248), // soft pink gradient like MEESAFE
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),

          // Description
          Text(
            desc,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          // Bottom Image
          SizedBox(
            height: 140,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _deviceCard(String title, IconData icon, BuildContext context) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF3F3F8), Color(0xFFE9E9F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WebBrandSelectionScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
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
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// 🔹 TESTIMONIAL SECTION (Web-style carousel)
Widget _testimonialSection(bool isWide) {
  final List<Map<String, String>> testimonials = [
    {
      'image': 'assets/images/female.jpeg',
      'review': 'Mee Safe made selling my old phone effortless!',
      'name': 'Rohit Sharma',
    },
    {
      'image': 'assets/images/male.jpeg',
      'review': 'Instant quote and quick pickup. Loved the service!',
      'name': 'Anjali Patel',
    },
    {
      'image': 'assets/images/female.jpeg',
      'review': 'Best resale value I’ve ever got — super smooth process.',
      'name': 'Vikas Kumar',
    },
  ];

  return Container(
    padding: EdgeInsets.symmetric(horizontal: isWide ? 160 : 40, vertical: 40),
    child: Column(
      children: [
        const Text(
          "What Our Customers Say",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 25),
        CarouselSlider(
          options: CarouselOptions(
            height: 350,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            viewportFraction: isWide ? 0.5 : 0.8,
          ),
          items: testimonials.map((testimonial) {
            return _testimonialCard(
              testimonial['image']!,
              testimonial['review']!,
              testimonial['name']!,
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _testimonialCard(String imagePath, String review, String name) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    padding: const EdgeInsets.all(24),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.1),
          blurRadius: 12,
          offset: const Offset(2, 6),
        ),
      ],
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // User Image with border
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Icon(Icons.format_quote, color: AppColors.primary, size: 28),
        const SizedBox(height: 16),
        Text(
          review,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "- $name",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}



  // 🔹 SUCCESS IN NUMBERS
  Widget _successInNumbers(bool isWide) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 180 : 40),
      child: Column(
        children: [
          const Text(
            "Success in Numbers",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 50,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _numberCard("1M+", "Happy Customers"),
              _numberCard("500K+", "Devices Sold"),
              _numberCard("100+", "Cities Covered"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _numberCard(String count, String label) {
    return Container(
      width: 220,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(color: Colors.black54, fontSize: 15)),
        ],
      ),
    );
  }

  // 🔹 DOWNLOAD NOW SECTION
  Widget _downloadNowSection(bool isWide) {
    return Container(
      color: AppColors.primary.withOpacity(0.05),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 160 : 40,
        vertical: 60,
      ),
      child: Column(
        children: [
          const Text(
            "Download the Mee Safe App",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Sell, trade or recycle your devices anytime, anywhere.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          const SizedBox(height: 25),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              Image.asset('assets/images/playstore.jpeg', height: 50),
              Image.asset('assets/images/apple.png', height: 50),
            ],
          ),
        ],
      ),
    );
  }
}

