import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_company_screen.dart';

class VendorOtpScreen extends StatefulWidget {
  final String phoneNumber;
  const VendorOtpScreen({super.key, required this.phoneNumber});

  @override
  State<VendorOtpScreen> createState() => _VendorOtpScreenState();
}

class _VendorOtpScreenState extends State<VendorOtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  void _verifyOtp() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a 6-digit OTP")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const VendorCompanyScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;
          final double containerWidth = isWide ? 450 : double.infinity;

          return Center(
            child: Container(
              width: containerWidth,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  Icon(Icons.lock_outline,
                      color: AppColors.primary, size: isWide ? 100 : 80),

                  const SizedBox(height: 20),

                  Text(
                    "Verify OTP",
                    style: TextStyle(
                      fontSize: isWide ? 30 : 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Enter the OTP sent to ${widget.phoneNumber}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: isWide ? 17 : 15, color: Colors.black54),
                  ),

                  const SizedBox(height: 40),

                  // 🔹 Responsive OTP Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: isWide ? 55 : 45,
                        height: isWide ? 65 : 55,
                        child: TextField(
                          controller: _otpControllers[index],
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: isWide ? 24 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 30),

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
                      onPressed: _verifyOtp,
                      child: const Text(
                        "Verify OTP",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Change number?", style: TextStyle(color: AppColors.primary)),
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
