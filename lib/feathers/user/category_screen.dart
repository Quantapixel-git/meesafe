// import 'package:flutter/material.dart';
// import 'package:mee_safe/feathers/constants/app_colors.dart';
// import 'package:mee_safe/feathers/user/sub_category.dart';

// class Category {
//   final int id;
//   final String name;

//   Category({required this.id, required this.name});
// }

// class CategoryScreen extends StatelessWidget {
//   final List<Category> categories = [
//     Category(id: 1, name: "Android"),
//     Category(id: 2, name: "iOS"),
//   ];

//   CategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Categories"),
//         backgroundColor: AppColors.primary,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: categories.length,
//         itemBuilder: (_, index) {
//           final cat = categories[index];
//           return Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 2,
//             margin: const EdgeInsets.symmetric(vertical: 6),
//             child: ListTile(
//               title: Text(
//                 cat.name,
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 // Navigate to SubCategoryScreen (static content)
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const SubCategoryScreen(),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
