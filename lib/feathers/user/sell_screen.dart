// ==========================
// 📱 MOBILE VERSION
// ==========================
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/choose_brand_screen.dart';
import 'package:mee_safe/feathers/user/why_best_screen.dart';

class SellScreenMobile extends StatelessWidget {
  const SellScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          Text(
            "Sell Your Mobile for the Highest Price",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          const Text(
            "Choose your mobile brand and get a quick best-price quote",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: const [
              BrandCardMobile(label: 'Apple', icon: Icons.apple),
              BrandCardMobile(label: 'Samsung', icon: Icons.phone_android),
              BrandCardMobile(label: 'OnePlus', icon: Icons.mobile_friendly),
              BrandCardMobile(label: 'Google Pixel', icon: Icons.android),
              BrandCardMobile(label: 'Oppo', icon: Icons.phone_iphone),
              BrandCardMobile(label: 'Vivo', icon: Icons.phone_iphone),
            ],
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChooseBrandScreen()),
              );
            },
            child: const Text(
              "Sell All Brands",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 40),

          const WhyBestSection(),
        ],
      ),
    );
  }
}

/// MOBILE BRAND CARD
class BrandCardMobile extends StatelessWidget {
  final String label;
  final IconData icon;

  const BrandCardMobile({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChooseBrandScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ==========================
// 🖥️ WEB VERSION
// ==========================

class SellScreenWeb extends StatelessWidget {
  const SellScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1300),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Sell Your Mobile for the Highest Price",
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              const Text(
                "Choose your mobile brand and get an instant best-price quote.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                childAspectRatio: 1.15,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                children: const [
                  BrandCardWeb(label: 'Apple', icon: Icons.apple),
                  BrandCardWeb(label: 'Samsung', icon: Icons.phone_android),
                  BrandCardWeb(label: 'OnePlus', icon: Icons.mobile_friendly),
                  BrandCardWeb(label: 'Google Pixel', icon: Icons.android),
                  BrandCardWeb(label: 'Oppo', icon: Icons.phone_iphone),
                  BrandCardWeb(label: 'Vivo', icon: Icons.phone_iphone),
                ],
              ),

              const SizedBox(height: 50),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ChooseBrandScreen()),
                  );
                },
                child: const Text(
                  "Sell All Brands",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}

/// WEB BRAND CARD WITH HOVER ANIMATION
class BrandCardWeb extends StatefulWidget {
  final String label;
  final IconData icon;

  const BrandCardWeb({super.key, required this.label, required this.icon});

  @override
  State<BrandCardWeb> createState() => _BrandCardWebState();
}

class _BrandCardWebState extends State<BrandCardWeb> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color:
                  hover ? Colors.black.withOpacity(0.18) : Colors.grey.shade200,
              blurRadius: hover ? 20 : 8,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChooseBrandScreen()),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 54, color: AppColors.primary),
              const SizedBox(height: 14),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return width > 900
        ? const SellScreenWeb()       // 🖥️ Web UI
        : const SellScreenMobile();   // 📱 Mobile UI
  }
}
