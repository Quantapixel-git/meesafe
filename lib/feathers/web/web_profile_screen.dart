import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';

class WebProfileScreen extends StatelessWidget {
  const WebProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const ProfileHeader(),
            WebHeaderNav(),
            const SizedBox(height: 20),

            // MAIN BODY WIDTH LIMITER
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileForm(),
                    SizedBox(height: 30),
                    SavedAddressSection(),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),

            const FooterSection(),
            const SizedBox(height: 20),

            const Text(
              "Copyrights © 2025 All rights reserved",
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------
    HEADER SECTION
-------------------------------------------------------- */

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                "Select your location",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------
    PROFILE FORM
-------------------------------------------------------- */

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  Widget buildField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              suffixIcon: Icon(Icons.edit, size: 18, color: AppColors.primary),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              "Profile",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const SizedBox(height: 25),

        LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;

            double boxWidth =
                width > 900 ? width * 0.23 : (width > 700 ? width * 0.45 : width);

            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                SizedBox(width: boxWidth, child: buildField("Name")),
                SizedBox(
                    width: boxWidth, child: buildField("Mobile Number")),
                SizedBox(
                    width: boxWidth,
                    child: buildField("Alternative Mobile Number")),
                SizedBox(width: boxWidth, child: buildField("Email ID")),
              ],
            );
          },
        ),
      ],
    );
  }
}

/* -------------------------------------------------------
    SAVED ADDRESS SECTION
-------------------------------------------------------- */

class SavedAddressSection extends StatelessWidget {
  const SavedAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "SAVED ADDRESS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.3),
            ),
            Text(
              "Add new address",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        const Text(
          "Please Click Add New Address To Add Address",
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------
    FOOTER SECTION
-------------------------------------------------------- */

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("MEESAFE",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                  SizedBox(height: 10),
                  Text(
                    "We promise our users the best price for their electronic devices,\n"
                    "ensuring transparent and secured transactions at their doorstep.",
                    style: TextStyle(color: Colors.black87, height: 1.3),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.facebook, size: 22),
                      SizedBox(width: 10),
                      Icon(Icons.camera_alt_outlined, size: 22),
                      SizedBox(width: 10),
                      Icon(Icons.link, size: 22),
                      SizedBox(width: 10),
                      Icon(Icons.play_circle_outline, size: 24),
                    ],
                  ),
                ],
              ),
            ),

            // CENTER
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Site Map",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 12),
                  Text("About Us"),
                  Text("FAQ"),
                  Text("Contact Us"),
                  Text("Find our stores"),
                  Text("Terms & Conditions"),
                  Text("Privacy Policy"),
                ],
              ),
            ),

            // RIGHT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Popular Categories",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 12),
                  Text("Phone"),
                  Text("Laptop"),
                  Text("Tablet"),
                  Text("SmartWatch"),
                  Text("Gaming Console"),
                  Text("Earbuds"),
                  Text("Camera"),
                  Text("Desktop"),
                  Text("TV"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
