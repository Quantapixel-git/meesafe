import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/user_plan_screen.dart';
import 'package:mee_safe/feathers/user/variant_price_questionary_screen.dart';
class UserWarrantyRegistrationScreen extends StatefulWidget {
  final String? selectedDevice;
  final String? selectedBrand;
  final String? selectedModel;

  const UserWarrantyRegistrationScreen({
    super.key,
    this.selectedDevice,
    this.selectedBrand,
    this.selectedModel,
  });

  @override
  State<UserWarrantyRegistrationScreen> createState() =>
      _UserWarrantyRegistrationScreenState();
}


class _UserWarrantyRegistrationScreenState
    extends State<UserWarrantyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  

  String? selectedDevice, selectedBrand, selectedModel, purchasedFor;
  String imei1 = '', imei2 = '', year = '';
  bool isOldDevice = false;
  bool documentUploaded = false;
  bool imeiMismatch = false;
  String? purchasedFromName;
File? ownershipDocument;


  File? deviceImage;
  final ImagePicker _picker = ImagePicker();

  // ✅ Simulated IMEI database
  final registeredImeis = {"123456789012345", "999999999999999"};

  final devices = ["Mobile", "Laptop", "Tablet"];
  final brands = ["Apple", "Samsung", "OnePlus", "Dell", "HP"];
  final models = ["Samsung F55", "Samsung S24", "Samsung A33"];

  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => deviceImage = File(pickedFile.path));
    }
  }

  Future<void> _captureOwnershipDoc() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    setState(() => ownershipDocument = File(pickedFile.path));
  }
}


  // ✅ MAIN SUBMIT FUNCTION
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Manufacturing year check
      final int? mfgYear = int.tryParse(year);
      if (mfgYear == null || mfgYear < 2020) {
        _showError(
            "❌ Device not eligible. Manufacturing year must be 2020 or newer.");
        return;
      }

      // Require both IMEIs for device registration
      if (imei1.isEmpty || imei2.isEmpty) {
        _showError("❌ Both IMEI numbers are required for registration.");
        return;
      }

      // Already registered IMEI check
      if (registeredImeis.contains(imei1) || registeredImeis.contains(imei2)) {
        _showError("❌ One or both IMEI numbers are already registered.");
        return;
      }

      // Require captured photo
      if (deviceImage == null) {
        _showError("❌ Please capture a photo of your device.");
        return;
      }

      // Extra check for ownership document if purchased for other person
if (purchasedFor == "Other Person" && ownershipDocument == null) {
  _showError("❌ Please upload ownership/purchase document.");
  return;
}


      // Randomly simulate IMEI-user mismatch scenario
      // (In a real app, this would come from backend verification)
      if (_simulateImeiMismatch()) {
        imeiMismatch = true;
        _showDocumentUploadDialog(
            reason:
                "IMEI and user details do not match. Please upload proof of ownership.");
        return;
      }

      // All checks passed
      _showConditionsPopup();
    }
  }

  bool _simulateImeiMismatch() {
    // Randomly simulate 25% mismatch (for demo)
    return imei1.endsWith("5") || imei2.endsWith("9");
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.primary),
    );
  }

  // 📄 Document Upload Dialog
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
            )
          ],
        ),
      ),
    );
  }

  // 📜 Warranty Conditions Popup
  void _showConditionsPopup() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Warranty Conditions"),
        content: const SingleChildScrollView(
          child: Text(
            """
• Warranty valid for 30 days from registration.
• Two valid IMEI numbers must be provided.
• One claim allowed per device.
• No refund if the claim gets rejected.
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
            onPressed: () {
              Navigator.pop(context);
              _finalizeRegistration();
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text("Accept & Register",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  // ✅ Finalize Registration
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
          MaterialPageRoute(builder: (context) => const UserPlanScreen()),
        );

    setState(() {
      _formKey.currentState?.reset();
      deviceImage = null;
      documentUploaded = false;
      imeiMismatch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Warranty"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
         // --- DEVICE (READ ONLY) ---
TextFormField(
  initialValue: selectedDevice ?? "",
  enabled: false,
  decoration: InputDecoration(
    labelText: "Selected Device",
    border: OutlineInputBorder(),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.grey[200],
    filled: true,
  ),
),
const SizedBox(height: 16),

// --- BRAND (READ ONLY) ---
TextFormField(
  initialValue: selectedBrand ?? "",
  enabled: false,
  decoration: InputDecoration(
    labelText: "Selected Brand",
    border: OutlineInputBorder(),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.grey[200],
    filled: true,
  ),
),
const SizedBox(height: 16),

// --- MODEL (READ ONLY) ---
TextFormField(
  initialValue: selectedModel ?? "",
  enabled: false,
  decoration: InputDecoration(
    labelText: "Selected Model",
    border: OutlineInputBorder(),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.grey[200],
    filled: true,
  ),
),
const SizedBox(height: 16),

              const SizedBox(height: 16),

              Text("Capture Device Image",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700])),
              const SizedBox(height: 8),
              InkWell(
                onTap: _captureImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: deviceImage == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt,
                                  size: 50, color: Colors.grey),
                              SizedBox(height: 8),
                              Text("Tap to capture photo",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(deviceImage!,
                              fit: BoxFit.cover, width: double.infinity),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(
                    labelText: "IMEI Number 1", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                maxLength: 15,
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter IMEI 1" : null,
                onSaved: (val) => imei1 = val!,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                    labelText: "IMEI Number 2", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                maxLength: 15,
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter IMEI 2" : null,
                onSaved: (val) => imei2 = val!,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Manufacturing Year",
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter year" : null,
                onSaved: (val) => year = val!,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
  decoration: const InputDecoration(
      labelText: "Purchased For", border: OutlineInputBorder()),
  items: ["Myself", "Other Person"]
      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      .toList(),
  value: purchasedFor,
  onChanged: (val) {
    setState(() {
      purchasedFor = val;
      // Reset optional fields when switching
      purchasedFromName = null;
      ownershipDocument = null;
    });
  },
  validator: (val) =>
      val == null ? "Select ownership type" : null,
),
const SizedBox(height: 16),

// 🔹 Conditional Fields for "Other Person"
if (purchasedFor == "Other Person") ...[
  TextFormField(
    decoration: const InputDecoration(
      labelText: "Purchased From (Person Name)",
      border: OutlineInputBorder(),
    ),
    validator: (val) => val == null || val.isEmpty
        ? "Enter seller/person name"
        : null,
    onSaved: (val) => purchasedFromName = val,
  ),
  const SizedBox(height: 16),

  Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.orange[50],
      border: Border.all(color: Colors.orangeAccent),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      "⚠️ IMEI number and user details might not match.\nPlease upload ownership or purchase proof document.",
      style: TextStyle(fontSize: 13, color: Colors.black87),
    ),
  ),
  const SizedBox(height: 12),

  InkWell(
    onTap: _captureOwnershipDoc,
    child: Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: ownershipDocument == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 45, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Tap to upload ownership proof",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(ownershipDocument!,
                  fit: BoxFit.cover, width: double.infinity),
            ),
    ),
  ),
  const SizedBox(height: 16),
],

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Register Warranty",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
