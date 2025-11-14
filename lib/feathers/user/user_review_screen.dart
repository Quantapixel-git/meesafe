import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class UserReviewScreen extends StatefulWidget {
  const UserReviewScreen({super.key});

  @override
  State<UserReviewScreen> createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
    final reviewText = _reviewController.text.trim();
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please give a rating before submitting.")),
      );
      return;
    }
    if (reviewText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please write a short review.")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Thank you for your feedback!")),
    );

    _reviewController.clear();
    setState(() => _rating = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write a Review"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // BREAKPOINTS
          final bool isMobile = constraints.maxWidth < 600;
          final bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          final bool isDesktop = constraints.maxWidth >= 1024;

          // WIDTH FOR DESKTOP/TABLET UI
          double contentWidth = constraints.maxWidth;

          if (isTablet) {
            contentWidth = 500; // medium width
          } else if (isDesktop) {
            contentWidth = 600; // large width and centered
          }

          return Center(
            child: SizedBox(
              width: contentWidth,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 18 : 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      "Share Your Experience",
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Your feedback helps us improve Mee Safe and serve you better.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),

                    const SizedBox(height: 30),

                    // ⭐ Star Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          iconSize: isMobile ? 36 : 40,
                          onPressed: () => setState(() => _rating = index + 1.0),
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: AppColors.primary,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    // ✏ Review TextField
                    TextField(
                      controller: _reviewController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Write your review here...",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: isMobile ? 50 : 55,
                      child: ElevatedButton(
                        onPressed: _submitReview,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Submit Review",
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
