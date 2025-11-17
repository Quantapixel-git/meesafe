import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/admin/admin_login_screen.dart';
import 'package:mee_safe/feathers/branches/branch_login.dart';
import 'package:mee_safe/feathers/vendor/vendor_login_screen.dart';

class ChooseRoleDialog extends StatelessWidget {
  const ChooseRoleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choose Your Role",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            _roleTile(context, Icons.admin_panel_settings, "Admin"),
            const SizedBox(height: 18),

            _roleTile(context, Icons.store, "Vendor"),
            const SizedBox(height: 18),

            _roleTile(context, Icons.account_tree, "Branch"),
          ],
        ),
      ),
    );
  }

 Widget _roleTile(BuildContext context, IconData icon, String title) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);

      // 🎯 Navigate based on role selected
      Widget screen;

      if (title == "Admin") {
        screen = const AdminLoginScreen();
      } else if (title == "Vendor") {
        screen = const VendorLoginScreen();
      } else {
        screen = const BranchLogin();
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 18),
        ],
      ),
    ),
  );
}

}


class RoleLoginScreen extends StatefulWidget {
  final String role;
  const RoleLoginScreen({super.key, required this.role});

  @override
  State<RoleLoginScreen> createState() => _RoleLoginScreenState();
}

class _RoleLoginScreenState extends State<RoleLoginScreen> {
  bool showOtp = false;

  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController otpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${widget.role} Login",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // Phone number input
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter Mobile Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              if (showOtp) ...[
                const SizedBox(height: 15),
                TextField(
                  controller: otpCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter OTP",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (!showOtp) {
                    // Send OTP
                    setState(() => showOtp = true);
                  } else {
                    // Verify OTP
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(showOtp ? "Verify OTP" : "Send OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
