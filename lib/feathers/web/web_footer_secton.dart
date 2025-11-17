import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // -------- Top Footer Section --------
        Container(
          width: double.infinity,
          color: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAboutSection(),
                        const SizedBox(width: 40),
                        _buildSiteMap(),
                        const SizedBox(width: 40),
                        _buildCategories(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAboutSection(),
                        const SizedBox(height: 30),
                        _buildSiteMap(),
                        const SizedBox(height: 30),
                        _buildCategories(),
                      ],
                    );
            },
          ),
        ),

        // -------- Bottom Copyright Bar --------
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

  // -------- About Section --------
  Widget _buildAboutSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
Text("Me Safe",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
          const SizedBox(height: 10),
          const Text(
            "We promise our users the best price for their electronic devices, ensuring transparent and secured transactions at their doorstep.",
            style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Icon(Icons.facebook, color: Colors.black87),
              SizedBox(width: 10),
              Icon(Icons.camera_alt, color: Colors.black87),
              SizedBox(width: 10),
              Icon(Icons.linked_camera, color: Colors.black87),
            ],
          ),
        ],
      ),
    );
  }

  // -------- Site Map Section --------
  Widget _buildSiteMap() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Site Map",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
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
    );
  }

  // -------- Categories Section --------
  Widget _buildCategories() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Popular Categories",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(" Phone"),
          Text(" Laptop"),
          Text(" Tablet"),
          Text(" SmartWatch"),
          Text(" Gaming Console"),
          Text(" Earbuds"),
          Text(" Camera"),
          Text(" Desktop"),
          Text(" TV"),
        ],
      ),
    );
  }
}
