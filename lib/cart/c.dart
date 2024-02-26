// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   int _counter = 1;
//   double productPrice = 200;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   void _decrementCounter() {
//     setState(() {
//       if (_counter > 1) {
//         _counter--;
//       }
//     });
//   }
//
//   double calculateTotal() {
//     return productPrice * _counter;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold))),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 3,
//                     blurRadius: 10,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
//                 child: Row(
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       child: Image.asset(
//                         'assets/images/nike-shoes.png',
//                         height: 90,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Flexible(
//                             child: Text('Nike Sports Shoe',
//                                 style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
//                             )
//                         ),
//                         const SizedBox(height: 5),
//                         Flexible(
//                             child: Text('Size : 6 UK',
//                               style: GoogleFonts.nunitoSans(textStyle:const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold))
//                               )
//                         ),
//                         const SizedBox(height: 5),
//                         Flexible(
//                             child: Text('Color : Green',
//                                 style: GoogleFonts.nunitoSans(textStyle:const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold))
//                             )
//                         ),
//
//                         // const SizedBox(height: 20),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Price : ₹$productPrice', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
//                             const SizedBox(width: 4),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: _decrementCounter,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.black,
//                                     shape: const CircleBorder(),
//                                   ),
//                                   child: const Icon(
//                                     Icons.remove,
//                                     color: Colors.white,
//                                     size: 15,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$_counter',
//                                     style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: _incrementCounter,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.black,
//                                     shape: const CircleBorder(),
//                                   ),
//                                   child: const Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                     size: 15,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//             const Divider(thickness: 0.5),
//             const SizedBox(height: 20),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Delivery Charge', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
//                 ),
//                 Text('₹125', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Sub Total', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
//                 Text('₹${calculateTotal()}',style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Total', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
//                 Text('₹${calculateTotal() + 125}', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
//               ],
//             ),
//
//             const SizedBox(height: 25),
//             SizedBox(
//               height: 50,
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFE53935),
//                 ),
//                 onPressed: () {},
//                 child: Text('CHECKOUT', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
