import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/choose_variant_screen.dart';

class ChooseModelScreen extends StatelessWidget {
  const ChooseModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> models = [
      {
        'name': 'Samsung Galaxy F17 5G',
        'image': 'assets/images/samsung.jpg',
      },
      {
        'name': 'Samsung Galaxy A17 5G',
        'image': 'assets/images/samsung.jpg',
      },
      {
        'name': 'Samsung Galaxy F36 5G',
        'image': 'assets/images/samsung.jpg',
      },
      {
        'name': 'Samsung Galaxy M36 5G',
        'image': 'assets/images/samsung.jpg',
      },
    ];

    final List<String> series = [
      "All",
      "Galaxy S Series",
      "Galaxy M Series",
      "Galaxy A Series",
      "Galaxy F Series",
    ];

    int selectedSeries = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Device > Brand > Model",
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              "Search Samsung Model To Sell",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),

            // Search Box
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Color(0xFF0D47A1)),
                hintText: 'Search for model',
                filled: true,
                fillColor: const Color(0xFFF9F9F9),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF0D47A1)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "Choose by series",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Series Filter Buttons
            SizedBox(
              height: 40,
              child: StatefulBuilder(
                builder: (context, setState) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: series.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedSeries;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(
                          series[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF0D47A1),
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: const Color(0xFF0D47A1),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF0D47A1),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isSelected
                                ? const Color(0xFF0D47A1)
                                : Colors.grey.shade300,
                          ),
                        ),
                        onSelected: (_) {
                          setState(() => selectedSeries = index);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Choose Model",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D47A1),
              ),
            ),
            const SizedBox(height: 10),

            // Grid of Models
            Expanded(
              child: GridView.builder(
                itemCount: models.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final model = models[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseVariantScreen(
                            modelName: "Samsung Galaxy F17 5G",
                            imagePath: "assets/images/samsung.jpg",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFF0D47A1).withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0D47A1).withOpacity(0.08),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            model['image']!,
                            height: 90,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              model['name']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
