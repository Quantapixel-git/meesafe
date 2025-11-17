import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/web/web_model_selector_screen.dart';

class WebBrandSelectionScreen extends StatelessWidget {
  const WebBrandSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandData = [
      {"name": "Apple", "image": "assets/images/apple.png"},
      {"name": "Samsung", "image": "assets/images/samsung_logo.png"},
      {"name": "OnePlus", "image": "assets/images/oneplus.png"},
      {"name": "Google", "image": "assets/images/google.jpeg"},
      {"name": "Oppo", "image": "assets/images/apple.png"},
      {"name": "Vivo", "image": "assets/images/samsung_logo.png"},
      {"name": "Xiaomi", "image": "assets/images/oneplus.png"},
      {"name": "Motorola", "image": "assets/images/google.jpeg"},
      {"name": "Realme", "image": "assets/images/apple.png"},
      {"name": "POCO", "image": "assets/images/samsung_logo.png"},
      {"name": "iQOO", "image": "assets/images/oneplus.png"},
      {"name": "Nothing", "image": "assets/images/google.jpeg"},
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 160,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: const [
              Text(
                "Mee Safe",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Search Your Brand ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Search bar
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search for brand",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    const Text(
                      "Choose Brand",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Brand Grid with Images
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int count = constraints.maxWidth > 900
                            ? 6
                            : constraints.maxWidth > 600
                                ? 4
                                : 2;

                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: brandData.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: count,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1.1,
                          ),
                          itemBuilder: (context, index) {
                            final brand = brandData[index];

                            return BrandTile(
                              title: brand["name"]!,
                              imagePath: brand["image"]!,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WebModelSelectorScreen(
                                      brandName: brand["name"]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class BrandTile extends StatefulWidget {
  final String title, imagePath;
  final VoidCallback onTap;

  const BrandTile({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<BrandTile> createState() => _BrandTileState();
}

class _BrandTileState extends State<BrandTile> {
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
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hover ? Colors.blue.shade300 : Colors.grey.shade300,
          ),
          boxShadow: [
            BoxShadow(
              color: hover
                  ? Colors.black.withOpacity(0.12)
                  : Colors.grey.shade200,
              blurRadius: hover ? 12 : 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
