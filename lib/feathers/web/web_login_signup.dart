import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';
import 'package:pinput/pinput.dart';

bool isLoggedIn = false;
String userName = "User";

PreferredSizeWidget webAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    actions: [
      if (isLoggedIn) ...[
        TextButton(
          onPressed: () {},
          child: const Text("My Orders", style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {},
          child: Text("Hi, $userName", style: const TextStyle(color: Colors.black)),
        ),
      ] else ...[
        TextButton(
          onPressed: () => showWebPopup(context, LoginDialog()),
          child: const Text("Sign In", style: TextStyle(color: Colors.black)),
        ),
      ],
      const SizedBox(width: 14),
    ],
  );
}

class LoginDialog extends StatelessWidget {
  final TextEditingController mobileCtrl = TextEditingController();

  LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 300, vertical: 40),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Login", style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.close, size: 16),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text("Mobile Number",
                style: TextStyle(fontSize: 14, color: Colors.grey[800])),
            ),
            const SizedBox(height: 6),

            TextField(
              controller: mobileCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: "+91  ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Enter mobile number",
              ),
            ),

            const SizedBox(height: 20),

            // GET OTP Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OTPScreen(
                      mobile: mobileCtrl.text,
                    )));
                },
                child: const Text("Get OTP"),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => OTPScreen(isSignup: true)));
                  },
                  child: const Text("Sign Up",
                      style: TextStyle(color: Colors.redAccent)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPopup extends StatefulWidget {
  @override
  State<SignupPopup> createState() => _SignupPopupState();
}

class _SignupPopupState extends State<SignupPopup> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return popupCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context, "Sign Up"),
          const SizedBox(height: 12),

          inputField("Name", name),
          inputField("Mobile Number", phone),
          inputField("Email", email),

          Row(
            children: [
              Checkbox(value: agree, onChanged: (v) => setState(() => agree = v!)),
              const Text("I Agree to Terms", style: TextStyle(fontSize: 13)),
            ],
          ),

          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                showWebPopup(context, OTPScreen());
              },
              child: const Text("Submit"),
            ),
          ),

          const SizedBox(height: 10),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showWebPopup(context, LoginDialog());
              },
              child: const Text("Back to Login"),
            ),
          )
        ],
      ),
    );
  }
}

Widget popupCard({required Widget child}) {
  return Material(
    color: Colors.transparent,
    child: Container(
      width: 420,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    ),
  );
}


class OTPScreen extends StatelessWidget {
  final String? mobile;
  final bool isSignup;

  OTPScreen({super.key, this.mobile, this.isSignup = false});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      textStyle: const TextStyle(fontSize: 20),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isSignup ? "Sign Up" : "Verify OTP",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),

              const SizedBox(height: 8),
              Text("OTP sent to +91 $mobile",
                style: const TextStyle(color: Colors.black54)),

              const SizedBox(height: 30),

              // OTP BOXES
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                ),
                onCompleted: (value) {
                  print("OTP ENTERED = $value");
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                     Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebHomeScreen()),
            );
                  },
                  child: Text(isSignup ? "Create Account" : "Verify OTP"),
                ),
              ),

              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: const Text("Resend OTP"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget header(BuildContext context, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close)),
    ],
  );
}

Widget inputField(String label, TextEditingController c) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter $label",
          ),
        ),
      ],
    ),
  );
}
