import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_warranty_condition_screen.dart';

class WebFunctionalAccessoriesScreen extends StatefulWidget {
  final String deviceName;
  final String imageUrl;

  const WebFunctionalAccessoriesScreen({
    super.key,
    required this.deviceName,
    required this.imageUrl,
  });

  @override
  State<WebFunctionalAccessoriesScreen> createState() =>
      _WebFunctionalAccessoriesScreenState();
}

class _WebFunctionalAccessoriesScreenState
    extends State<WebFunctionalAccessoriesScreen> {
      IconData _getIssueIcon(String title) {
  if (title.contains("Battery")) return Icons.battery_alert_rounded;
  if (title.contains("Front Camera")) return Icons.camera_front_rounded;
  if (title.contains("Back Camera")) return Icons.camera_rear_rounded;
  if (title.contains("Glass")) return Icons.broken_image_rounded;
  if (title.contains("Network")) return Icons.network_check_rounded;
  if (title.contains("Speaker")) return Icons.volume_up_rounded;
  if (title.contains("Mic")) return Icons.mic_off_rounded;
  if (title.contains("Touch")) return Icons.fingerprint_rounded;
  if (title.contains("Volume")) return Icons.volume_mute_rounded;
  if (title.contains("WiFi") || title.contains("Bluetooth"))
    return Icons.wifi_tethering_error_rounded;
  if (title.contains("Charging")) return Icons.usb_rounded;
  if (title.contains("Sensor")) return Icons.sensors_off_rounded;
  if (title.contains("Power")) return Icons.power_settings_new_rounded;
  if (title.contains("Ear")) return Icons.hearing_disabled_rounded;
  if (title.contains("Vibrator")) return Icons.vibration_outlined;

  return Icons.error_outline; // fallback
}

  final List<Map<String, String>> issues = [
    {"title": "Battery issue", "image": "assets/images/issue_battery.png"},
    {"title": "Front Camera not working", "image": "assets/images/issue_front_camera.png"},
    {"title": "Back Camera not working", "image": "assets/images/issue_back_camera.png"},
    {"title": "Camera Glass Broken", "image": "assets/images/issue_glass.png"},
    {"title": "Network problem", "image": "assets/images/issue_network.png"},
    {"title": "Speaker not working", "image": "assets/images/issue_speaker.png"},
    {"title": "Mic not working", "image": "assets/images/issue_mic.png"},
    {"title": "Touch Id or Face Id not working", "image": "assets/images/issue_touchid.png"},
    {"title": "Volume Button not working", "image": "assets/images/issue_volume.png"},
    {"title": "WiFi or Bluetooth not working", "image": "assets/images/issue_wifi.png"},
    {"title": "Charging Port not working", "image": "assets/images/issue_charging.png"},
    {"title": "Proximity Sensor not working", "image": "assets/images/issue_sensor.png"},
    {"title": "Power button not working", "image": "assets/images/issue_power.png"},
    {"title": "Ear Speaker not working or low", "image": "assets/images/issue_ear.png"},
    {"title": "Vibrator not working", "image": "assets/images/issue_vibrator.png"},
  ];

  final Set<String> selectedIssues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Evaluation",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Row(
            children: const [
              Text("My Orders", style: TextStyle(color: Colors.black)),
              SizedBox(width: 24),
              CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xfff0f0f0),
                child: Icon(Icons.person, color: Colors.black54),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT PANEL
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Let’s Evaluate your device",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Device Info
                      Row(
                        children: [
                          Image.asset(
                            widget.imageUrl,
                            width: 60,
                            height: 60,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Evaluating",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                widget.deviceName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(height: 32),
                      const Text(
                        "Overall Condition > Physical Condition > Functional & Accessories > Warranty Condition",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        "Select all issues identified in your Phone",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Issues grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: issues.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, index) {
                          final issue = issues[index];
                          final isSelected = selectedIssues.contains(issue["title"]);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedIssues.remove(issue["title"]);
                                } else {
                                  selectedIssues.add(issue["title"]!);
                                }
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
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                     Icon(
  _getIssueIcon(issue["title"]!),
  size: 40,
  color: isSelected ? AppColors.primary : Colors.black87,
),

                                      const SizedBox(height: 10),
                                      Text(
                                        issue["title"]!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: isSelected
                                              ? AppColors.primary
                                              : Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isSelected)
                                    const Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Icon(Icons.close_rounded,
                                          color: AppColors.primary, size: 20),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 42,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.primary),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Back",
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 140,
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WebWarrantyConditionScreen(
                                            deviceName: 'Samsung',
                                            imageUrl: 'assets/images/samsung.jpg',
                                          )
                                    ),
                                  );
                              },
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 32),

            // RIGHT PANEL
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Device Evaluation",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Summary",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Screening Question:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "• Yes, Is the phone in proper working condition?\n"
                      "• Yes, Is the touchscreen on your phone working properly?\n"
                      "• Yes, Is the phone’s display original?\n"
                      "• Yes, Is there a valid warranty for your phone?",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Selected Issues:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        children: selectedIssues.isEmpty
                            ? [
                                const Text(
                                  "No issues selected.",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 13),
                                )
                              ]
                            : selectedIssues
                                .map((e) => Text("• $e",
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 13)))
                                .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
