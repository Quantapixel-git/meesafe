// import 'package:flutter/material.dart';
// import 'package:mee_safe/feathers/constants/app_colors.dart';

// class FinalSellScreen extends StatelessWidget {
//   const FinalSellScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           "Sell Now For Amazing Price",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // 🔹 Device Image Card
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade200,
//                     blurRadius: 6,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'assets/images/samsung.jpg',
//                     height: 150,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Samsung Galaxy A17 5G  (8 GB/128 GB)",
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "Instantly Sell And Get",
//                     style: TextStyle(fontSize: 14, color: Colors.black54),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "₹ 2,020",
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🔹 Price Breakdown Section
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "PRICE BREAKOUT",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),

//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade200,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _buildPriceRow("Get Value", "₹ 2,020"),
//                   const SizedBox(height: 6),
//                   _buildPriceRow("Promo Code", "Promo Code", greyed: true),
//                   const Divider(),
//                   _buildPriceRow("Get value", "₹ 2,020", isBold: true),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 16),

//             // 🔹 Evaluation Summary Button
//             OutlinedButton(
//               onPressed: () {},
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(color: Colors.grey),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 minimumSize: const Size(double.infinity, 48),
//               ),
//               child: const Text(
//                 "View Evaluation Summary  →",
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🔹 Assurance Section
//             const Text(
//               "Our assurance win your trust",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ✅ FIXED: Assurance items in clean grid layout
//             GridView.count(
//               crossAxisCount: 2,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               children: [
//                 _assuranceItem(
//                     Icons.delivery_dining, "Hassle-Less\nDoorstep Free Pickup"),
//                 _assuranceItem(
//                     Icons.settings_suggest, "Services offered\nacross India"),
//                 _assuranceItem(
//                     Icons.trending_up, "Unbeatable\nMarket Value"),
//                 _assuranceItem(
//                     Icons.currency_rupee, "Instant Cash in\nHand"),
//               ],
//             ),

//             const SizedBox(height: 80),
//           ],
//         ),
//       ),

//       // 🔹 Bottom “Sell Now” Button
//       bottomNavigationBar: Container(
//         color: Colors.transparent,
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primary,
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           onPressed: () {},
//           child: const Text(
//             "Sell Now",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // 🔹 Helper Widgets
//   Widget _buildPriceRow(String left, String right,
//       {bool isBold = false, bool greyed = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           left,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             color: greyed ? Colors.grey : Colors.black,
//           ),
//         ),
//         Text(
//           right,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             color: greyed ? Colors.grey : Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _assuranceItem(IconData icon, String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: AppColors.primary, size: 34),
//           const SizedBox(height: 10),
//           Text(
//             text,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 13),
//           ),
//         ],
//       ),
//     );
//   }
// }
