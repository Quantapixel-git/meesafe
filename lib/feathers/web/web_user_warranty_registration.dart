import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/user_plan_screen.dart';
import 'package:mee_safe/feathers/web/web_evaluation_screen.dart';

class WebUserWarrantyRegistrationWeb extends StatefulWidget {
  const WebUserWarrantyRegistrationWeb({super.key});

  @override
  State<WebUserWarrantyRegistrationWeb> createState() =>
      _WebUserWarrantyRegistrationWebState();
}

class _WebUserWarrantyRegistrationWebState
    extends State<WebUserWarrantyRegistrationWeb> {
  final _formKey = GlobalKey<FormState>();

  String? selectedDevice, selectedBrand, selectedModel, purchasedFor;
  String imei1 = '', imei2 = '', year = '';
  String? purchasedFromName;
  bool imeiMismatch = false;
  bool documentUploaded = false;

  File? deviceImage;
  File? ownershipDocument;

  final ImagePicker _picker = ImagePicker();

  final registeredImeis = {"123456789012345", "999999999999999"};
  final devices = ["Mobile", "Laptop", "Tablet"];
  final brands = ["Apple", "Samsung", "OnePlus", "Dell", "HP"];
  final models = ["Samsung F55", "Samsung S24", "Samsung A33"];

  Future<void> _pickImage(bool isDeviceImage) async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery); // ✅ for web
    if (pickedFile != null) {
      setState(() {
        if (isDeviceImage) {
          deviceImage = File(pickedFile.path);
        } else {
          ownershipDocument = File(pickedFile.path);
        }
      });
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.primary),
    );
  }

  bool _simulateImeiMismatch() {
    return imei1.endsWith("5") || imei2.endsWith("9");
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final int? mfgYear = int.tryParse(year);
    if (mfgYear == null || mfgYear < 2020) {
      _showError("❌ Device not eligible. Year must be 2020 or newer.");
      return;
    }

    if (imei1.isEmpty || imei2.isEmpty) {
      _showError("❌ Both IMEI numbers required.");
      return;
    }

    if (registeredImeis.contains(imei1) || registeredImeis.contains(imei2)) {
      _showError("❌ One or both IMEI numbers already registered.");
      return;
    }


    if (purchasedFor == "Other Person" && ownershipDocument == null) {
      _showError("❌ Upload ownership/purchase document.");
      return;
    }

    if (_simulateImeiMismatch()) {
      imeiMismatch = true;
      _showDocumentUploadDialog(
        reason:
            "IMEI and user details do not match. Please upload proof of ownership.",
      );
      return;
    }

    _showConditionsPopup();
  }

  void _showDocumentUploadDialog({required String reason}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Upload Ownership Documents"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(reason),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                setState(() => documentUploaded = true);
                Navigator.pop(context);
                _showConditionsPopup();
              },
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload Documents"),
            ),
          ],
        ),
      ),
    );
  }

  void _showConditionsPopup() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Warranty Conditions"),
        content: const SingleChildScrollView(
          child: Text(
            """
• Warranty valid for 30 days from registration.
• Two valid IMEI numbers required.
• One claim allowed per device.
• No refund if claim rejected.
• Device must have verified ownership.
• Physical/water damage not covered.
• Uploaded documents will be reviewed by admin.
""",
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            onPressed: () {
              Navigator.pop(context);
              _finalizeRegistration();
            },
            child: const Text("Accept & Register",style: TextStyle(color :Colors.white),),
          ),
        ],
      ),
    );
  }

  void _finalizeRegistration() {
    registeredImeis.addAll({imei1, imei2});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          imeiMismatch
              ? "✅ Registration submitted for admin review."
              : "✅ Warranty registered successfully!",
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const  WebPlanScreen(
        ),),
    );

    setState(() {
      _formKey.currentState?.reset();
      deviceImage = null;
      ownershipDocument = null;
      imeiMismatch = false;
      documentUploaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Warranty Registration",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: const Color(0xfff8f8f8),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: const EdgeInsets.all(32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT PANEL
              Expanded(
                flex: 3,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          const Text(
                            "Register Device Warranty",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 24),

                          // ✅ Read-only 3 default fields
TextFormField(
  decoration: const InputDecoration(
    labelText: "Device",
    border: OutlineInputBorder(),
  ),
  initialValue: selectedDevice ?? "Mobile",
  enabled: false,
),
const SizedBox(height: 16),
TextFormField(
  decoration: const InputDecoration(
    labelText: "Brand / Model",
    border: OutlineInputBorder(),
  ),
  initialValue: selectedBrand != null && selectedModel != null
      ? "${selectedBrand!} ${selectedModel!}"
      : "Samsung S24",
  enabled: false,
),
const SizedBox(height: 16),
TextFormField(
  decoration: const InputDecoration(
    labelText: "Variant",
    border: OutlineInputBorder(),
  ),
  initialValue: purchasedFor ?? "4 GB / 128 GB",
  enabled: false,
),
const SizedBox(height: 24),

                          const SizedBox(height: 24),

                          const Text("Upload Device Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                          const SizedBox(height: 8),

                          InkWell(
                            onTap: () => _pickImage(true),
                            child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: deviceImage == null
                                  ? const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.upload, size: 50),
                                          SizedBox(height: 8),
                                          Text("Click to upload image"),
                                        ],
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        deviceImage!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          _buildTextField("IMEI Number 1",
                              onSaved: (val) => imei1 = val!),
                          const SizedBox(height: 16),
                          _buildTextField("IMEI Number 2",
                              onSaved: (val) => imei2 = val!),
                          const SizedBox(height: 16),
                          _buildTextField("Manufacturing Year",
                              onSaved: (val) => year = val!),
                          const SizedBox(height: 24),

                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: "Purchased For",
                              border: OutlineInputBorder(),
                            ),
                            items: ["Myself", "Other Person"]
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            value: purchasedFor,
                            onChanged: (val) {
                              setState(() {
                                purchasedFor = val;
                                purchasedFromName = null;
                                ownershipDocument = null;
                              });
                            },
                            validator: (val) =>
                                val == null ? "Select ownership type" : null,
                          ),

                          if (purchasedFor == "Other Person") ...[
                            const SizedBox(height: 16),
                            _buildTextField("Purchased From (Person Name)",
                                onSaved: (val) => purchasedFromName = val),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                border: Border.all(
                                    color: Colors.orangeAccent.shade100),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "⚠️ Please upload ownership/purchase proof document.",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () => _pickImage(false),
                              child: Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: ownershipDocument == null
                                    ? const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.upload_file,
                                                size: 45, color: Colors.grey),
                                            SizedBox(height: 8),
                                            Text("Upload ownership proof"),
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          ownershipDocument!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Register Warranty",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              if (isWide) const SizedBox(width: 32),

              // RIGHT PANEL (Instructions)
              if (isWide)
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "📋 Instructions:\n\n"
                      "• Fill all required details carefully.\n"
                      "• Ensure IMEI numbers are valid and unique.\n"
                      "• Upload clear images for both device and documents.\n"
                      "• Admin will review your registration before activation.\n\n"
                      "Once submitted, you’ll be redirected to the evaluation screen.",
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {required FormFieldSetter<String> onSaved}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      maxLength: label.contains("IMEI") ? 15 : null,
      validator: (val) => val == null || val.isEmpty ? "Enter $label" : null,
      onSaved: onSaved,
    );
  }
}
