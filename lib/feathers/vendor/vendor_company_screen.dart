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
  String? existingLogo = "company_logo.png";

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  Widget _buildWebLayout(BoxConstraints constraints) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700), // Web max width
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // Company Logo
                Center(
                  child: _pickedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _pickedImage!,
                            height: 180,
                            width: 180,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.image, size: 70),
                        ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo),
                    label: const Text("Upload Logo"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ALL FIELDS
                _buildRoundedField(
                  controller: companyNameController,
                  icon: Icons.apartment,
                  hint: "Company Name",
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
                  controller: addressController,
                  icon: Icons.location_city,
                  hint: "Address",
                ),
                _buildRoundedField(
                  controller: aboutController,
                  icon: Icons.info_outline,
                  hint: "About Company",
                  maxLines: 3,
                ),

                const SizedBox(height: 30),

                // SAVE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text("Save Company Details"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VendorPlanScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    ),
  );
}

  // -------------------------------------------------------------
  // EXISTING MOBILE FIELD (NO CHANGE)
  // -------------------------------------------------------------
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

  // -------------------------------------------------------------
  // MAIN BUILD METHOD → AUTO SWITCH MOBILE / WEB
  // -------------------------------------------------------------
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // ✅ If width > 600 → Web UI
          if (constraints.maxWidth >= 600) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildWebLayout(constraints),
            );
          }

          // ✅ Otherwise → Mobile UI (your existing code untouched)
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildRoundedField(
                      controller: companyNameController,
                      icon: Icons.apartment,
                      hint: "ABC Company"),
                  _buildRoundedField(
                    controller: emailController,
                    hint: "Email",
                    icon: Icons.email,
                  ),
                  _buildRoundedField(
                    controller: phoneController,
                    hint: "Phone",
                    icon: Icons.phone,
                  ),
                  _buildRoundedField(
                    controller: aboutController,
                    hint: "About Company",
                    icon: Icons.info_outline,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 20),
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
                            child: const Icon(Icons.image, size: 50),
                          ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Pick Image"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text("Save Company Details"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const VendorPlanScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
