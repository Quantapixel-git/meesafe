import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/admin/admin_login_screen.dart';
import 'package:mee_safe/feathers/branches/branch_login.dart';
import 'package:mee_safe/feathers/auth/view/otp_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_login_screen.dart';

class LoginScreen extends StatefulWidget {
  final String? role;

  const LoginScreen({super.key, this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String selectedRole = "";
  bool _showAdminButton = false;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.role ?? "User";
  }

  @override
  Widget build(BuildContext context) {
    String roleMessage = _getRoleMessage(selectedRole);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // App Logo + Long Press Gesture
              Center(
                child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _showAdminButton = !_showAdminButton;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.security_rounded,
                        color: AppColors.primary,
                        size: 80,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "MeeSafe",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Text(
                "Login as $selectedRole",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                roleMessage,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 20),

              // Phone Input
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter your mobile number",
                  prefixIcon: const Icon(Icons.phone_android),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Send OTP Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OtpScreen(phoneNumber: _phoneController.text),
                      ),
                       (route) => false,
                    );
                  },
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Other Roles Section
              Text(
                "Other Login Options",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.store_rounded, color: AppColors.primary),
                      label: const Text("Vendor"),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VendorLoginScreen(),
                          ),
                           (route) => false,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(
                        Icons.business_center_rounded,
                        color: AppColors.primary,
                      ),
                      label: const Text("Branches"),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BranchLogin(),
                          ),
                           (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
              // Hidden Admin Button (shows on long press)
              if (_showAdminButton) ...[
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.admin_panel_settings_rounded,
                      color: AppColors.primary,
                    ),
                    label: Text(
                      "Admin Login",
                      style: TextStyle(color: AppColors.primary),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedRole = "Admin";
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminLoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],

              const Spacer(),

              Center(
                child: Text(
                  "You'll receive an SMS with a verification code",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _getRoleMessage(String role) {
    switch (role.toLowerCase()) {
      case "admin":
        return "Admin access — manage system and users securely.";
      case "user":
        return "User access — track and secure your data easily.";
      case "vendor":
        return "Vendor access — manage your products and orders easily.";
      case "agency owner":
        return "Agency Owner access — manage teams and business operations.";
      default:
        return "Login securely using your registered number.";
    }
  }
}
