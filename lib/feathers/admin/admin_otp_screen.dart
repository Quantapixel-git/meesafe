import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/admin/admin_dashboard.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminOtpScreen extends StatefulWidget {
  final String phoneNumber;
  const AdminOtpScreen({super.key, required this.phoneNumber});

  @override
  State<AdminOtpScreen> createState() => _AdminOtpScreenState();
}

class _AdminOtpScreenState extends State<AdminOtpScreen> {
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
      MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isWeb = constraints.maxWidth > 800;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: isWeb
            ? null
            : AppBar(
                title: const Text(
                  "OTP Verification",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
        body: Center(
          child: Container(
            width: isWeb ? 420 : double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            margin: EdgeInsets.only(top: isWeb ? 40 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Icon(Icons.lock_outline,
                    color: AppColors.primary, size: isWeb ? 90 : 80),
                const SizedBox(height: 16),

                Text(
                  "Verify OTP",
                  style: TextStyle(
                    fontSize: isWeb ? 30 : 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Enter the OTP sent to ${widget.phoneNumber}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),

                const SizedBox(height: 35),

                /// OTP BOXES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: isWeb ? 50 : 45,
                      height: isWeb ? 60 : 55,
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 30),

                /// VERIFY BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
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
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Change number?",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
