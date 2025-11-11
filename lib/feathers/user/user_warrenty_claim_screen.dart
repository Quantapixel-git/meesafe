import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class UserWarrantyClaimScreen extends StatefulWidget {
  const UserWarrantyClaimScreen({super.key});

  @override
  State<UserWarrantyClaimScreen> createState() =>
      _UserWarrantyClaimScreenState();
}

class _UserWarrantyClaimScreenState extends State<UserWarrantyClaimScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedImei, issueDescription;
  File? issueImage;
  final ImagePicker _picker = ImagePicker();

  // In a real app, these IMEIs would come from the user’s registered warranties.
  final List<String> registeredImeis = [
    "123456789012345",
    "987654321098765",
  ];

  final List<Map<String, dynamic>> submittedClaims = [];

  Future<void> _captureIssueImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => issueImage = File(pickedFile.path));
    }
  }

  void _submitClaim() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (issueImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Please capture an image of the issue"),
              backgroundColor: AppColors.primary),
        );
        return;
      }

      setState(() {
        submittedClaims.add({
          "imei": selectedImei,
          "issue": issueDescription,
          "image": issueImage,
          "status": "Pending Admin Approval"
        });
        issueImage = null;
        _formKey.currentState?.reset();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Claim submitted successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Widget _buildClaimCard(Map<String, dynamic> claim) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.assignment_turned_in, color: Colors.blue),
        title: Text("IMEI: ${claim['imei']}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Issue: ${claim['issue']}"),
            Text("Status: ${claim['status']}"),
          ],
        ),
        trailing: claim['status'] == "Pending Admin Approval"
            ? const Icon(Icons.hourglass_empty, color: Colors.orange)
            : const Icon(Icons.verified, color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Claim Warranty"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Select Registered IMEI",
                      border: OutlineInputBorder(),
                    ),
                    items: registeredImeis
                        .map((imei) => DropdownMenuItem(
                            value: imei, child: Text(imei)))
                        .toList(),
                    onChanged: (val) => setState(() => selectedImei = val),
                    validator: (val) =>
                        val == null ? "Please select an IMEI" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Describe the Issue",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (val) => val == null || val.isEmpty
                        ? "Please describe your issue"
                        : null,
                    onSaved: (val) => issueDescription = val,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Capture Issue Image",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),

                  InkWell(
                    onTap: _captureIssueImage,
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: issueImage == null
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt,
                                      size: 50, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text("Tap to capture issue photo",
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(issueImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 180),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitClaim,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "Submit Claim",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            if (submittedClaims.isNotEmpty)
              const Text(
                "My Submitted Claims",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            const SizedBox(height: 8),
            ...submittedClaims.map(_buildClaimCard),
          ],
        ),
      ),
    );
  }
}
