import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/choose_brand_screen.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Phone",
      "icon": Icons.phone_android,
      "color": AppColors.primary,
    },
    {
      "name": "Laptop",
      "icon": Icons.laptop_mac,
      "color": AppColors.primary,
    },
    {
      "name": "Television",
      "icon": Icons.tv_rounded,
      "color": AppColors.primary,
    },
    {
      "name": "Refrigerator",
      "icon": Icons.kitchen_rounded,
      "color": AppColors.primary,
    },
    {
      "name": "Washing Machine",
      "icon": Icons.local_laundry_service_rounded,
      "color": AppColors.primary,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter categories based on search query
    final filteredCategories = categories
        .where((category) =>
            category['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          "All Categories",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar below AppBar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                hintText: "Search category...",
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🟦 Category Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: filteredCategories.isEmpty
                  ? const Center(
                      child: Text(
                        "No categories found",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : GridView.builder(
                      itemCount: filteredCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (context, index) {
                        final category = filteredCategories[index];
                        return _buildCategoryCard(
                          name: category['name'],
                          icon: category['icon'],
                          color: category['color'],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required String name,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseBrandScreen(),
                      ),
                    );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 30),
            ),
          const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
