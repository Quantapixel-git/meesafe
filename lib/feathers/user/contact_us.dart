import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _queryController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here you can handle form submission (API call, email, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your query has been submitted!')),
      );

      // Clear the fields after submission
      _nameController.clear();
      _emailController.clear();
      _mobileController.clear();
      _subjectController.clear();
      _queryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double horizontalPadding = width * 0.06;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(controller: _nameController, label: 'Name', validatorMsg: 'Please enter your name'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validatorMsg: 'Please enter a valid email',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _mobileController,
                label: 'Mobile Number',
                keyboardType: TextInputType.phone,
                validatorMsg: 'Please enter a valid mobile number',
              ),
              const SizedBox(height: 16),
              _buildTextField(controller: _subjectController, label: 'Subject', validatorMsg: 'Please enter subject'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _queryController,
                label: 'Query',
                maxLines: 5,
                validatorMsg: 'Please enter your query',
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? validatorMsg,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validatorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }
}
