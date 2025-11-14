import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';
import 'package:mee_safe/feathers/web/web_variant_selection_screen.dart';

class WebModelSelectorScreen extends StatefulWidget {
  final String brandName;
  const WebModelSelectorScreen({super.key, required this.brandName});

  @override
  State<WebModelSelectorScreen> createState() => _WebModelSelectorScreenState();
}

class _WebModelSelectorScreenState extends State<WebModelSelectorScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'All';

  final List<String> filters = ['All', '5G', 'Foldable', 'Flagship', 'Gaming'];

  final List<Map<String, String>> models = List.generate(
    60,
    (index) => {
      'name': 'Samsung Galaxy Model ${index + 1}',
      'image':  'assets/images/samsung.jpg',
    },
  );

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
             WebHeaderNav(),

            // 🔹 Breadcrumb
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Device",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.black54),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Brand",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.black54),
                  Text(
                    "Sell ${widget.brandName} Models",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Title
            Text(
              "Sell ${widget.brandName} Models to Sell",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Search Bar
            SizedBox(
              width: 500,
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: "Search for model",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔹 Filters
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: filters.map((f) {
                final isSelected = selectedFilter == f;
                return ChoiceChip(
                  label: Text(f),
                  selected: isSelected,
                  onSelected: (_) => setState(() => selectedFilter = f),
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.white,
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // 🔹 Models Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 100 : 40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = (constraints.maxWidth / 200).floor();
                  return GridView.builder(
                    itemCount: models.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount.clamp(2, 6),
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final model = models[index];
                      final query = _searchController.text.toLowerCase();
                      if (query.isNotEmpty &&
                          !model['name']!.toLowerCase().contains(query)) {
                        return const SizedBox.shrink();
                      }

                      return _modelCard(model['name']!, model['image']!);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 100),

            // 🔹 Footer
            Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: const Column(
                children: [
                  Text(
                    "© 2025 DOFY. All rights reserved.",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Model Card Widget
  Widget _modelCard(String name, String imagePath) {
    return InkWell(
      onTap: () {
         Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebVariantSelectionScreen(
            modelName: name,
            imagePath: imagePath,
          ),
        ),
      );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected $name")),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
