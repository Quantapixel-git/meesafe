import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class WebStoreLocatorScreen extends StatelessWidget {
  const WebStoreLocatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stores = [
      {
        "image": "assets/images/ad_1.jpeg",
        "title": "Tambaram, Chennai",
        "address":
            "shop No:8 A, 45, Shanmugam Rd, West Tambaram, Chennai, Tamil Nadu - 600045",
        "time": "Sunday-Saturday 10 am - 9.30 pm"
      },
      {
        "image": "assets/images/ad_2.png",
        "title": "Nungambakkam, Chennai",
        "address":
            "No 112&B2, Dofy Electronics & Solutions Pvt Ltd, Eldorado Building, Nungambakkam High Rd, Thousand Lights West, Chennai, Tamil Nadu - 600034",
        "time": "Sunday-Saturday 10 am - 9 pm"
      },
      {
        "image": "assets/images/ad_3.png",
        "title": "Kodambakkam, Chennai",
        "address":
            "Old No#24, New No#41, Arcot Rd, Kodambakkam, Chennai, Tamil Nadu - 600024",
        "time": "Sunday-Saturday 10 am - 9.30 pm"
      },
      {
        "image": "assets/images/ad_1.jpeg",
        "title": "TNagar, Chennai",
        "address":
            "11/13, Ground Floor, S Usman Road, opposite Police Quarters Road, near Krishnaveni Theatre, T. Nagar, Chennai, Tamil Nadu - 600017",
        "time": "Sunday-Saturday 10 am - 10 pm"
      },
      {
        "image": "assets/images/ad_2.png",
        "title": "Kadayanallur, Tenkasi",
        "address":
            "Main Bazaar Rd, Ayyapuram, Kadayanallur, Tenkasi, Tamil Nadu - 627751",
        "time": "Sunday-Saturday 9 am - 10.30 pm"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;
          final isTablet = constraints.maxWidth < 1100 && constraints.maxWidth >= 700;

          final horizontalPadding = isMobile
              ? 16.0
              : isTablet
                  ? 40.0
                  : 80.0;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderSection(),
                const SizedBox(height: 20),

                // Page Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    "Locate our Store",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),

                const SizedBox(height: 20),

                // Store Cards
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: stores
                        .map((store) => StoreCard(
                              image: store["image"]!,
                              title: store["title"]!,
                              address: store["address"]!,
                              time: store["time"]!,
                              isMobile: isMobile,
                            ))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 40),
                const FooterSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ---------------- HEADER ----------------
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
           IconButton(
            onPressed: () {
              Navigator.pop(context); // goes back to previous page
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
            tooltip: 'Back',
          ),
          const SizedBox(width: 10),
          Text("Mee Safe",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30),),
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search mobile phones, laptops and more...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.headphones, color: Colors.black54),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Colors.black54),
              ),
            ),
            onPressed: () {},
            child: const Text("Login / Sign up"),
          ),
        ],
      ),
    );
  }
}

// ---------------- STORE CARD ----------------
class StoreCard extends StatelessWidget {
  final String image, title, address, time;
  final bool isMobile;

  const StoreCard({
    super.key,
    required this.image,
    required this.title,
    required this.address,
    required this.time,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(18),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                _detailsSection(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    height: 160,
                    width: 230,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(child: _detailsSection(context)),
              ],
            ),
    );
  }

  Widget _detailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          address,
          style: const TextStyle(color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 6),
        Text(
          time,
          style: const TextStyle(color: Colors.black87),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.directions, color:AppColors.primary),
              label: const Text("Get Direction",
                  style: TextStyle(color:AppColors.primary)),
            ),
            const SizedBox(width: 10),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.phone, color:AppColors.primary),
              label: const Text("Call Store",
                  style: TextStyle(color:AppColors.primary)),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------- FOOTER ----------------
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFF8F8F8),
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
          child: Wrap(
            spacing: 40,
            runSpacing: 20,
            alignment: WrapAlignment.spaceBetween,
            children: [
              _footerColumn(
                logo: true,
                children: [
                  const Text(
                    "We promise our users the best price for their electronic devices, ensuring transparent and secured transactions at their doorstep.",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Icon(Icons.facebook, color: Colors.black),
                      SizedBox(width: 10),
                      Icon(Icons.camera_alt, color: Colors.black),
                      SizedBox(width: 10),
                      Icon(Icons.play_circle_fill, color: Colors.black),
                      SizedBox(width: 10),
                      Icon(Icons.linked_camera, color: Colors.black),
                    ],
                  ),
                ],
              ),
              _footerColumn(
                title: "Site Map",
                items: [
                  "About Us",
                  "FAQ",
                  "Contact Us",
                  "Find our stores",
                  "Terms & Conditions",
                  "Privacy Policy",
                  "Blogs",
                ],
              ),
              _footerColumn(
                title: "Popular Categories",
                items: [
                  "Sell Phone",
                  "Sell Laptop",
                  "Sell Tablet",
                  "Sell SmartWatch",
                  "Sell Gaming Console",
                  "Sell Earbuds",
                  "Sell Camera",
                  "Sell Desktop",
                  "Sell TV",
                ],
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xFFF1F1F1),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Center(
            child: Text(
              "Copyrights © 2025 All rights reserved",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }

  Widget _footerColumn({
    bool logo = false,
    String? title,
    List<String>? items,
    List<Widget>? children,
  }) {
    return SizedBox(
      width: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (logo) ...[
            Text("Mee Safe",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30),),
            const SizedBox(height: 10),
            ...?children,
          ] else if (title != null && items != null) ...[
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(item),
              ),
          ],
        ],
      ),
    );
  }
}
