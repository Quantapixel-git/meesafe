import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_plan_screen.dart';

class VendorCompanyScreen extends StatefulWidget {
  const VendorCompanyScreen({super.key});

  @override
  State<VendorCompanyScreen> createState() => _VendorCompanyScreenState();
}

class _VendorCompanyScreenState extends State<VendorCompanyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String? existingLogo = "company_logo.png"; // sample

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
      existingLogo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Details"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildRoundedField(
                controller: companyNameController,
                icon: Icons.apartment,
                hint: "ABC Company",
              ),
              _buildRoundedField(
                controller: emailController,
                icon: Icons.email,
                hint: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              _buildRoundedField(
                controller: phoneController,
                icon: Icons.phone,
                hint: "Phone",
                keyboardType: TextInputType.phone,
              ),
              _buildRoundedField(
                controller: aboutController,
                icon: Icons.info_outline,
                hint: "About Company",
                maxLines: 3,
              ),

              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Company Logo",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),

                    // ✅ Show picked image or placeholder
                    Center(
                      child: _pickedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _pickedImage!,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                                ),
                    ),

                    const SizedBox(height: 12),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.photo_library),
                        label: const Text("Pick Image"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white, // ✅ white text
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Save Company Details"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white, // ✅ white text
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Company details saved successfully")),
                      );

                      // ✅ Navigate to Vendor Dashboard
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VendorPlanScreen()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (val) =>
            val == null || val.isEmpty ? "Please enter $hint" : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class VendorCompanyDetailsScreen extends StatefulWidget {
  const VendorCompanyDetailsScreen({super.key});

  @override
  State<VendorCompanyDetailsScreen> createState() =>
      _VendorCompanyDetailsScreenState();
}

class _VendorCompanyDetailsScreenState
    extends State<VendorCompanyDetailsScreen> {
  bool _isEditing = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController companyNameController =
      TextEditingController(text: "ABC Electronics Pvt. Ltd.");
  final TextEditingController emailController =
      TextEditingController(text: "info@abcelectronics.com");
  final TextEditingController phoneController =
      TextEditingController(text: "+91 9876543210");
  final TextEditingController aboutController = TextEditingController(
      text: "ABC Electronics is a leading manufacturer of smart devices and gadgets.");
  final TextEditingController addressController =
      TextEditingController(text: "123 Tech Park, Bengaluru, India");

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String? existingLogo = "assets/images/google.jpeg";

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  Widget _buildRoundedField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        readOnly: !_isEditing,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (val) =>
            val == null || val.isEmpty ? "Please enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey),
          filled: true,
          fillColor: _isEditing ? Colors.white : Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:
                _isEditing ? const BorderSide(color: Colors.blueAccent) : BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _toggleEdit() {
    if (_isEditing) {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Vendor details updated successfully")),
        );
        setState(() => _isEditing = false);
      }
    } else {
      setState(() => _isEditing = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logoWidget = _pickedImage != null
        ? Image.file(_pickedImage!, height: 100, width: 100, fit: BoxFit.cover)
        : (existingLogo != null
            ? Image.asset(existingLogo!, height: 100, width: 100, fit: BoxFit.cover)
            : const Icon(Icons.image, size: 100, color: Colors.grey));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Details"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: logoWidget,
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Fields
              _buildRoundedField(
                  label: "Company Name",
                  controller: companyNameController,
                  icon: Icons.apartment),
              _buildRoundedField(
                  label: "Email",
                  controller: emailController,
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress),
              _buildRoundedField(
                  label: "Phone",
                  controller: phoneController,
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone),
              _buildRoundedField(
                  label: "Address",
                  controller: addressController,
                  icon: Icons.location_on),
              _buildRoundedField(
                  label: "About",
                  controller: aboutController,
                  icon: Icons.info_outline,
                  maxLines: 3),

              const SizedBox(height: 40),
              if (!_isEditing)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Details"),
                    onPressed: () => setState(() => _isEditing = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
