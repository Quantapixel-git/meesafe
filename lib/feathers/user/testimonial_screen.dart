import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class TestimonialScreen extends StatelessWidget {
  const TestimonialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final testimonials = [
      {
        "name": "Ravi Sharma",
        "feedback":
            "Excellent service! The doorstep pickup was super convenient and I got a great price for my old phone.",
        "imagePath": "assets/images/male.jpeg",
        "rating": 5,
      },
      {
        "name": "Sneha Patel",
        "feedback":
            "Highly satisfied with the smooth process. The team was friendly and the pricing was truly the best!",
        "imagePath": "assets/images/female.jpeg",
        "rating": 4,
      },
      {
        "name": "Amit Kumar",
        "feedback":
            "Super easy and trustworthy service. I didn’t have to step out — they handled everything perfectly.",
        "imagePath": "assets/images/male.jpeg",
        "rating": 5,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What Our Customers Say",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),

          CarouselSlider(
            options: CarouselOptions(
              height: 230,
              enlargeCenterPage: true,
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 4),
              viewportFraction: 0.75,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
            items: testimonials.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return _buildTestimonialCard(
                    name: item["name"]!.toString(),
                    feedback: item["feedback"]!.toString(),
                    imagePath: item["imagePath"]!.toString(),
                    rating: item["rating"] as int,
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
  required String name,
  required String feedback,
  required String imagePath,
  required int rating,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ✅ Prevent height overflow
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar and name
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(imagePath),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ⭐ Rating stars
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                );
              }),
            ),
            const SizedBox(height: 10),

            // Feedback
            Flexible( // ✅ Allow text to adapt to card size
              child: Text(
                feedback,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    },
  );
}

}
