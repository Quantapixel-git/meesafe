import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_evaluation_screen.dart';
import 'package:mee_safe/feathers/web/web_user_warranty_registration.dart';

class WebLocationPopup extends StatefulWidget {
  const WebLocationPopup({super.key});

  @override
  State<WebLocationPopup> createState() => _WebLocationPopupState();
}

class _WebLocationPopupState extends State<WebLocationPopup> {
  final List<String> locations = [
    "Tamil Nadu",
    "Kerala",
    "Pondicherry",
    "Karnataka",
    "Andhra Pradesh",
    "Telangana",
    "Maharashtra",
    "Delhi",
    "West Bengal",
    "Madhya Pradesh",
    "Gujarat",
    "Andaman And Nicobar Islands",
    "Uttar Pradesh",
    "Goa"
  ];

  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                "Select your location",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),

            // Grid of locations
            SizedBox(
              height: 350, // fixed height for scrollable content
              child: GridView.builder(
                itemCount: locations.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final location = locations[index];
                  final isSelected = selectedLocation == location;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLocation = location;
                      });

                      // Simulate navigation after selection
                      Future.delayed(const Duration(milliseconds: 300), () {
    //                      Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => WebEvaluationScreen(
    //       deviceName: "Samsung Galaxy Z Flip 7 (12 GB/256 GB)",
    //       imageUrl:
    //           'assets/images/samsung.jpg',
    //     ),
    //   ),
    // );
     Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WebEvaluationScreen(
          deviceName: "Samsung Galaxy Z Flip 7 (12 GB/256 GB)",
          imageUrl:
              'assets/images/samsung.jpg',
        ),
      ),
    );
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_city,
                            color:
                                isSelected ? AppColors.primary : Colors.black54,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            location,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  isSelected ? AppColors.primary : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
            const Divider(),

            // Bottom search + request pickup row
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search your city or pincode",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Can't Find Your Area? ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    "Request a pickup",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
