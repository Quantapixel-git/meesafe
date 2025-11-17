import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_otp_screen.dart';

class VendorLoginScreen extends StatefulWidget {
  const VendorLoginScreen({super.key});

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _sendOtp() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty || phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid mobile number")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorOtpScreen(phoneNumber: phone),
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
          bool isWide = constraints.maxWidth > 600;

          return Center(
            child: Container(
              width: isWide ? 450 : double.infinity, // center card for web
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: isWide ? 100 : 80),

                  Icon(
                    Icons.storefront_rounded,
                    color: AppColors.primary,
                    size: isWide ? 110 : 90,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Vendor Login",
                    style: TextStyle(
                      fontSize: isWide ? 32 : 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Access your vendor dashboard securely",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),

                  const SizedBox(height: 50),

                  // 🔹 Phone Field
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

                  // 🔹 Send OTP Button
                  SizedBox(
                    width: double.infinity,
                    height: isWide ? 55 : 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _sendOtp,
                      child: Text(
                        "Send OTP",
                        style: TextStyle(
                          fontSize: isWide ? 18 : 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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
                        fontStyle: FontStyle.italic,
                      ),
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
