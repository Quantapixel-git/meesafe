import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';

class WebBlogScreen extends StatelessWidget {
  const WebBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogs = [
      {
        "image": "assets/images/ad_1.jpeg",
        "date": "13 Nov 2025",
        "title": "Why is a Bill of Sale Important When You Sell Your Phone?",
        "desc":
            "Selling your old phone online or offline may seem simple, but sometimes it becomes a headache without giving any warning.",
      },
      {
        "image": "assets/images/ad_2.png",
        "date": "11 Nov 2025",
        "title": "How to Negotiate When Selling Your Gadget?",
        "desc":
            "Any activity online seems easy and welcoming, but one thing stands apart: selling your old phone or gadget online.",
      },
      {
        "image": "assets/images/ad_3.png",
        "date": "03 Nov 2025",
        "title": "How Battery Health Affects Your Phone's Resale Value?",
        "desc":
            "Have you ever wondered if battery health would be the primary factor that drives the phone’s price?",
      },
      {
        "image": "assets/images/ad_1.jpeg",
        "date": "30 Sept 2025",
        "title":
            "Is Amazon's Great Indian Sale a scam? – A Complete Analysis",
        "desc":
            "Every year, Amazon’s Great Indian Festival sale has never left the calendar unticked, creating a buzz among Indian buyers.",
      },
      {
        "image": "assets/images/ad_2.png",
        "date": "29 Sept 2025",
        "title":
            "Flipkart’s Big Billion Days Exchange vs. Selling Your Old Phone Online",
        "desc":
            "Many people often claim that exchange offers on big e-commerce platforms are nothing but a trap.",
      },
      {
        "image": "assets/images/ad_3.png",
        "date": "04 Sept 2025",
        "title":
            "What Is the Difference Between a Refurbished Phone and a Used Phone?",
        "desc":
            "When it comes to buying a phone at a lower price, most people compare refurbished and used phones.",
      },
      {
        "image": "assets/images/ad_2.png",
        "date": "04 Aug 2025",
        "title": "Are Refurbished Phones Good To Buy? – A Complete Guide",
        "desc":
            "Refurbished mobile phones are one of the best options to go with if you mind balancing cost and quality.",
      },
      {
        "image": "assets/images/ad_3.png",
        "date": "23 Jul 2025",
        "title":
            "Online vs. Offline: What's the Best Way to Sell Your Old Phone?",
        "desc":
            "Have you ever imagined that smartphones have become indispensable today?",
      },
      {
        "image": "assets/images/ad_1.jpeg",
        "date": "15 Jul 2025",
        "title": "5 Practical Tips To Boost Your Phone’s Battery Life",
        "desc":
            "Your phone doesn’t need a new battery, but it may need better habits to keep your screen powered longer.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final horizontalPadding = isMobile ? 16.0 : 80.0;

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const BlogHeader(),
              WebHeaderNav(),
              const SizedBox(height: 30),

              // Page Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "BLOGS",
                      style: TextStyle(
                          color:AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "The latest writings from our team",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Tools and strategies modern teams need to help their companies grow.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // BLOG GRID
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: LayoutBuilder(builder: (context, constraints) {
                  int crossAxisCount = 3;
                  if (constraints.maxWidth < 1200) crossAxisCount = 2;
                  if (constraints.maxWidth < 700) crossAxisCount = 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: blogs.length,
                    itemBuilder: (context, index) {
                      final blog = blogs[index];
                      return BlogCard(
                        image: blog["image"]!,
                        date: blog["date"]!,
                        title: blog["title"]!,
                        desc: blog["desc"]!,
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 40),

              const BlogFooter(),
            ],
          ),
        );
      }),
    );
  }
}

// ---------------- HEADER ----------------
class BlogHeader extends StatelessWidget {
  const BlogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          // Back Button
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          ),
          const SizedBox(width: 8),
          const Text(
            "Mee Safe",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
          const SizedBox(width: 40),

          // Navigation Menu
          Expanded(
            child: Row(
              children: const [
                Text("Select your location",
                    style: TextStyle(color: Colors.black54)),
                SizedBox(width: 30),
                Text("Home"),
                SizedBox(width: 30),
                Text("Corporate Trade-In"),
                SizedBox(width: 30),
                Text("Our Stores"),
                SizedBox(width: 30),
                Text("Blogs"),
                SizedBox(width: 30),
                Text("More"),
              ],
            ),
          ),

          // Support + Login
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.headphones, color: Colors.black54),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              side: const BorderSide(color: Colors.black54),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            ),
            onPressed: () {},
            child: const Text("Login / Sign up"),
          ),
        ],
      ),
    );
  }
}

// ---------------- BLOG CARD ----------------
class BlogCard extends StatelessWidget {
  final String image, date, title, desc;
  const BlogCard(
      {super.key,
      required this.image,
      required this.date,
      required this.title,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(image,
                height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date,
                    style: const TextStyle(
                        color: Colors.black54, fontSize: 12)),
                const SizedBox(height: 6),
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.black87, height: 1.4),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ---------------- FOOTER ----------------
class BlogFooter extends StatelessWidget {
  const BlogFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFFF8F8F8),
          padding:
              const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mee Safe",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)),
                    const SizedBox(height: 10),
                    const Text(
                      "We promise our users the best price for their electronic devices, ensuring transparent and secured transactions at their doorstep.",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Icon(Icons.facebook),
                        SizedBox(width: 10),
                        Icon(Icons.camera_alt),
                        SizedBox(width: 10),
                        Icon(Icons.play_circle_fill),
                        SizedBox(width: 10),
                        Icon(Icons.linked_camera),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Download the Mee Safe app and get the best deals for your device",
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset("assets/images/playstore.jpeg", height: 40),
                        const SizedBox(width: 10),
                        Image.asset("assets/images/apple.png", height: 40),
                      ],
                    ),
                  ],
                ),
              ),

              // Column 2
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Site Map",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 12),
                    Text("About Us"),
                    Text("FAQ"),
                    Text("Contact Us"),
                    Text("Find our stores"),
                    Text("Terms & Conditions"),
                    Text("Privacy Policy"),
                    Text("Blogs"),
                  ],
                ),
              ),

              // Column 3
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Popular Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 12),
                    Text("Sell Phone"),
                    Text("Sell Laptop"),
                    Text("Sell Tablet"),
                    Text("Sell SmartWatch"),
                    Text("Sell Gaming Console"),
                    Text("Sell Earbuds"),
                    Text("Sell Camera"),
                    Text("Sell Desktop"),
                    Text("Sell TV"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xFFF1F1F1),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Center(
            child: Text("Copyrights © 2025 All rights reserved",
                style: TextStyle(fontSize: 13, color: Colors.black54)),
          ),
        ),
      ],
    );
  }
}
