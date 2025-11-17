import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/branches/branch_otp_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BranchLogin extends StatefulWidget {
  const BranchLogin({super.key});

  @override
  State<BranchLogin> createState() => BranchLoginState();
}

class BranchLoginState extends State<BranchLogin> {
  final TextEditingController _phoneController = TextEditingController();

  void _sendOtp() {
    final phone = _phoneController.text.trim();

    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid mobile number")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BranchOtpScreen(phoneNumber: phone),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 🔥 WEB TABLET DESKTOP – Center card
          bool isWide = constraints.maxWidth > 600;

          return Center(
            child: Container(
              width: isWide ? 450 : double.infinity, // <-- Responsive width
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),

                  Icon(Icons.storefront_rounded,
                      color: AppColors.primary, size: 90),

                  const SizedBox(height: 12),

                  Text(
                    "Branch Login",
                    style: TextStyle(
                        fontSize: isWide ? 32 : 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Access your agency dashboard securely",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),

                  const SizedBox(height: 50),

                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter mobile number",
                      prefixIcon: const Icon(Icons.phone_android),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

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
                      onPressed: _sendOtp,
                      child: const Text(
                        "Send OTP",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "You'll receive an SMS with a verification code",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
