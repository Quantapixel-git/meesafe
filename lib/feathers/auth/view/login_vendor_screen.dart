import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_otp_screen.dart';

class VendorLoginScreen extends StatefulWidget {
  final String? role;

  const VendorLoginScreen({super.key, this.role});

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  late String selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.role ?? "User";
  }

  @override
  Widget build(BuildContext context) {
    String roleMessage = "";
   
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
    title: const Text("Login"),
    backgroundColor: AppColors.primary,
    actions: [
      TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VendorLoginScreen())); // 👈 Navigate to user dashboard
        },
        child: const Text(
          "User",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ],
  ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              // App logo or icon
              Center(
                child: Column(
                  children:  [
                    Icon(Icons.security_rounded,
                        color: AppColors.primary, size: 80),
                    SizedBox(height: 10),
                    Text(
                      "MeeSafe",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Role-specific heading
              Text(
                "Login as $selectedRole",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                roleMessage,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 20),
              // Phone input
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
              const SizedBox(height: 20),

             
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  VendorOtpScreen(phoneNumber: _phoneController.text,),
                      ),
                    );
                  },
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  "You'll receive an SMS with a verification code",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget for role button
  Widget _buildRoleButton(String roleName) {
    final isSelected = selectedRole == roleName;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor:
                isSelected ? AppColors.primary : Colors.transparent,
            foregroundColor:
                isSelected ? Colors.white : AppColors.primary,
            side:  BorderSide(color: AppColors.primary),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            setState(() {
              selectedRole = roleName;
            });
          },
          child: Text(roleName),
        ),
      ),
    );
  }
}
