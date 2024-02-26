
// Display product details
// const SizedBox(height: 10),
// Text(
//   'Category: ${widget.product.category}',
//   style:
//   const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// ),
// Text('Delivery Date: ${widget.product.deliveryDate.toDate()}'),
// Text(
//   'Product Name: ${widget.product.productName}',
//   style:
//   const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// ),
// Text('Product Price: ${widget.product.productPrice}'),
// Text('Product Title: ${widget.product.productTitle}'),
// Text('Sub Category: ${widget.product.subCategory}'),
// Text('User ID: ${widget.product.userId}'),



// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:readmore/readmore.dart';
// // import '../models/p_products.dart';
// //
// // class ProductDetailsScreen extends StatefulWidget {
// //   final ProductModel product;
// //   const ProductDetailsScreen({Key? key, required this.product})
// //       : super(key: key);
// //
// //   @override
// //   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// // }
// //
// // class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
// //   final PageController _pageController = PageController();
// //   int _currentPage = 0;
// //   bool _isFavorite = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _pageController.addListener(() {
// //       setState(() {
// //         _currentPage = _pageController.page!.round();
// //       });
// //     });
// //   }
// //
// //   int _counter = 1;
// //
// //   void _incrementCounter() {
// //     setState(() {
// //       _counter++;
// //     });
// //   }
// //
// //   void _decrementCounter() {
// //     setState(() {
// //       if (_counter > 0) {
// //         _counter--;
// //       }
// //     });
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     int? countControllerValue;
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFF84FFFF),
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //         ),
// //         title: TextField(
// //           decoration: InputDecoration(
// //             hintText: 'Search...',
// //             border: InputBorder.none,
// //             prefixIcon: const Icon(Icons.search),
// //             contentPadding: const EdgeInsets.all(8.0),
// //             filled: true,
// //             fillColor: Colors.white,
// //             focusedBorder: OutlineInputBorder(
// //               borderSide: const BorderSide(color: Colors.blue),
// //               borderRadius: BorderRadius.circular(8.0),
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderSide: const BorderSide(color: Colors.grey),
// //               borderRadius: BorderRadius.circular(8.0),
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //
// //             Text(
// //               widget.product.productName,
// //               style: Theme.of(context).textTheme.titleLarge
// //             ),
// //               const SizedBox(height: 15,),
// //               SizedBox(
// //                 height: 400,
// //                 child: Stack(
// //                   alignment: Alignment.bottomCenter,
// //                   children: [
// //                     PageView.builder(
// //                       controller: _pageController,
// //                       itemCount: widget.product.images.length,
// //                       itemBuilder: (context, index) {
// //                         return Stack(
// //                           alignment: Alignment.topRight,
// //                           children: [
// //                             Image.network(
// //                               widget.product.images[index],
// //                               fit: BoxFit.cover,
// //                             ),
// //                             Padding(
// //                               padding: const EdgeInsets.all(10.0),
// //                               child: Container(
// //                                 decoration: BoxDecoration(
// //                                   shape: BoxShape.circle,
// //                                   color: Colors.white,
// //                                   boxShadow: [
// //                                     BoxShadow(
// //                                       color: Colors.grey.withOpacity(0.5),
// //                                       spreadRadius: 2,
// //                                       blurRadius: 5,
// //                                       offset: const Offset(0, 2),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 child: IconButton(
// //                                   icon: Icon(
// //                                     _isFavorite
// //                                         ? Icons.favorite
// //                                         : Icons.favorite_border,
// //                                     color: Colors.red,
// //                                     size: 30,
// //                                   ),
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _isFavorite = !_isFavorite;
// //                                     });
// //                                   },
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         );
// //                       },
// //                     ),
// //                     _buildDots(widget.product.images.length),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 10,),
// //               const Divider(thickness: 0.5,),
// //               const SizedBox(height: 5,),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ReadMoreText(
// //                   widget.product.productTitle,
// //                   trimLines: 2,
// //                   colorClickableText: Colors.blue,
// //                   trimMode: TrimMode.Line,
// //                   trimCollapsedText: 'Show More',
// //                   trimExpandedText: '...Show Less',
// //                   style: Theme.of(context).textTheme.titleMedium,
// //                   moreStyle: const TextStyle(
// //                       fontSize: 14,
// //                       color: Colors.blue,
// //                       fontWeight: FontWeight.bold),
// //                   lessStyle: const TextStyle(
// //                       fontSize: 14,
// //                       color: Colors.blue,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //               ),
// //               const SizedBox(height: 5,),
// //               const Divider(thickness: 0.5),
// //
// //
// //               // Display color selection
// //               const SizedBox(height: 10),
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Colors',
// //                     style: Theme.of(context).textTheme.titleMedium,
// //                   ),
// //
// //                   Text('${widget.product.colors}'),
// //
// //                   const SizedBox(height: 10),
// //                 ],
// //               ),
// //
// //               const SizedBox(height: 15,),
// //               Text('Sale Price : ₹${widget.product.productPrice}', style: Theme.of(context).textTheme.titleMedium,),
// //               const SizedBox(height: 2),
// //               Row(
// //                 children: [
// //                   Text('M.R.P. : ', style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.red) ),
// //                   Text('₹${widget.product.productPrice}', style: const TextStyle(fontSize: 15,
// //                       color: Colors.red,
// //                       fontWeight: FontWeight.w600,
// //                       decoration: TextDecoration.lineThrough,
// //                     decorationColor: Colors.red
// //                   ),),
// //
// //                 ],
// //
// //               ),
// //               Text('Inclusive of all Taxes', style: Theme.of(context).textTheme.labelLarge,),
// //               const SizedBox(height: 5,),
// //               const Divider(thickness: 0.5),
// //
// //               const SizedBox(height: 10),
// //
// //               Row(
// //                 children: [
// //                   Text(
// //                     'Delivery - ',
// //                     style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.grey)
// //                   ),
// //                   Text(
// //                       DateFormat('dd MMMM yyyy').format(widget.product.deliveryDate.toDate()),
// //                     style: Theme.of(context).textTheme.titleMedium
// //                   ),
// //                 ],
// //               ),
// //
// //               Row(
// //                 children: [
// //                   IconButton(
// //                     icon: const Icon(Icons.location_on_rounded),
// //                     onPressed: () {},
// //                     iconSize: 20,
// //                   ),
// //                   const SizedBox(height: 5.0),
// //                   Text(
// //                     'Dholka Ahmedabad, Gujarat 382225',
// //                     style: Theme.of(context).textTheme.titleMedium
// //                   ),
// //                 ],
// //               ),
// //
// //               Row(
// //                 children: [
// //                   Text(
// //                     'Delivery Charge : ',
// //                     style: Theme.of(context).textTheme.titleSmall
// //                   ),
// //                   Text(
// //                     '₹125',
// //                     style: Theme.of(context).textTheme.titleMedium
// //                   ),
// //                 ],
// //               ),
// //
// //
// //               const SizedBox(height: 10),
// //
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.start,
// //               children: [
// //                 ElevatedButton(
// //                   onPressed: _decrementCounter,
// //                   style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.white,
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(20)),
// //                       side: const BorderSide(color: Colors.grey, width: 1)),
// //                   child: const Icon(
// //                     Icons.remove,
// //                     color: Colors.black,
// //                     size: 20.0,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 15),
// //                 Text(
// //                   '$_counter',
// //                   style: const TextStyle(fontSize: 20),
// //                 ),
// //                 const SizedBox(width: 15),
// //                 ElevatedButton(
// //                   onPressed: _incrementCounter,
// //                   style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.white,
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(20)),
// //                       side: const BorderSide(color: Colors.grey, width: 1)),
// //                   child: const Icon(
// //                     Icons.add,
// //                     color: Colors.black,
// //                     size: 20.0,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //
// //
// //               const SizedBox(height: 20),
// //               SizedBox(
// //                 height: 50,
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFFEEFF41),
// //                   ),
// //                   onPressed: () {  },
// //                   child: const Text('ADD TO CART', style: TextStyle(color: Colors.white),),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               SizedBox(
// //                 height: 50,
// //
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.deepOrangeAccent
// //                   ),
// //                   onPressed: () {  },
// //                   child: const Text('BUY NOW', style: TextStyle(color: Colors.white)),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 15,),
// //
// //               Row(
// //                 children: [
// //                   IconButton(
// //                     icon: const Icon(Icons.lock),
// //                     onPressed: () {},
// //                     iconSize: 20,
// //                     color: Colors.grey,
// //                   ),
// //                   const SizedBox(height: 8.0),
// //                   const Text(
// //                     'Secure Transaction',
// //                     style: TextStyle(
// //                         color: Colors.grey,
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w500),
// //                   ),
// //                 ],
// //               ),
// //
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildDots(int itemCount) {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: List.generate(itemCount, (index) {
// //           return Container(
// //             width: 8.0,
// //             height: 8.0,
// //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: _currentPage == index ? Colors.blue : Colors.grey,
// //             ),
// //           );
// //         }),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// //
// //
// //
// //
//
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:readmore/readmore.dart';
// import '../models/p_products.dart';
//
// class ProductDetailsScreen extends StatefulWidget {
//   final ProductModel product;
//
//   const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);
//
//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   bool _isFavorite = false;
//   Set<String> _selectedColors = Set<String>();
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(() {
//       setState(() {
//         _currentPage = _pageController.page!.round();
//       });
//     });
//   }
//
//   int _counter = 1;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   void _decrementCounter() {
//     setState(() {
//       if (_counter > 0) {
//         _counter--;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF84FFFF),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: TextField(
//           decoration: InputDecoration(
//             hintText: 'Search...',
//             border: InputBorder.none,
//             prefixIcon: const Icon(Icons.search),
//             contentPadding: const EdgeInsets.all(8.0),
//             filled: true,
//             fillColor: Colors.white,
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.blue),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.product.productName,
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               const SizedBox(height: 15,),
//               SizedBox(
//                 height: 400,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     PageView.builder(
//                       controller: _pageController,
//                       itemCount: widget.product.images.length,
//                       itemBuilder: (context, index) {
//                         return Stack(
//                           alignment: Alignment.topRight,
//                           children: [
//                             Image.network(
//                               widget.product.images[index],
//                               fit: BoxFit.cover,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2,
//                                       blurRadius: 5,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: IconButton(
//                                   icon: Icon(
//                                     _isFavorite
//                                         ? Icons.favorite
//                                         : Icons.favorite_border,
//                                     color: Colors.red,
//                                     size: 30,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isFavorite = !_isFavorite;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                     _buildDots(widget.product.images.length),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               const Divider(thickness: 0.5,),
//               const SizedBox(height: 5,),
//               SizedBox(
//                 width: double.infinity,
//                 child: ReadMoreText(
//                   widget.product.productTitle,
//                   trimLines: 2,
//                   colorClickableText: Colors.blue,
//                   trimMode: TrimMode.Line,
//                   trimCollapsedText: 'Show More',
//                   trimExpandedText: '...Show Less',
//                   style: Theme.of(context).textTheme.titleMedium,
//                   moreStyle: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.bold),
//                   lessStyle: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 5,),
//               const Divider(thickness: 0.5),
//
//               // Display color selection
//               const SizedBox(height: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Colors',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   // Use a ListView.builder to create a list of ElevatedButtons for each color
//                   Wrap(
//                     spacing: 8.0,
//                     runSpacing: 8.0,
//                     children: List.generate(widget.product.colors.length, (index) {
//                       final color = widget.product.colors[index];
//                       final isSelected = _selectedColors.contains(color);
//
//                       return ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             if (isSelected) {
//                               _selectedColors.remove(color);
//                             } else {
//                               _selectedColors.add(color);
//                             }
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           primary: isSelected ? Colors.blue : Colors.white,
//                           onPrimary: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                             side: BorderSide(color: Colors.grey),
//                           ),
//                         ),
//                         child: Text(
//                           color,
//                           style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.black,
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//
//               const SizedBox(height: 15,),
//               Text('Sale Price : ₹${widget.product.productPrice}', style: Theme.of(context).textTheme.titleMedium,),
//               const SizedBox(height: 2),
//               Row(
//                 children: [
//                   Text('M.R.P. : ', style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.red) ),
//                   Text('₹${widget.product.productPrice}', style: const TextStyle(fontSize: 15,
//                       color: Colors.red,
//                       fontWeight: FontWeight.w600,
//                       decoration: TextDecoration.lineThrough,
//                       decorationColor: Colors.red
//                   ),),
//                 ],
//               ),
//               Text('Inclusive of all Taxes', style: Theme.of(context).textTheme.labelLarge,),
//               const SizedBox(height: 5,),
//               const Divider(thickness: 0.5),
//
//               const SizedBox(height: 10),
//
//               Row(
//                 children: [
//                   Text(
//                       'Delivery - ',
//                       style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.grey)
//                   ),
//                   Text(
//                       DateFormat('dd MMMM yyyy').format(widget.product.deliveryDate.toDate()),
//                       style: Theme.of(context).textTheme.titleMedium
//                   ),
//                 ],
//               ),
//
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.location_on_rounded),
//                     onPressed: () {},
//                     iconSize: 20,
//                   ),
//                   const SizedBox(height: 5.0),
//                   Text(
//                       'Dholka Ahmedabad, Gujarat 382225',
//                       style: Theme.of(context).textTheme.titleMedium
//                   ),
//                 ],
//               ),
//
//               Row(
//                 children: [
//                   Text(
//                       'Delivery Charge : ',
//                       style: Theme.of(context).textTheme.titleSmall
//                   ),
//                   Text(
//                       '₹125',
//                       style: Theme.of(context).textTheme.titleMedium
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 10),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _decrementCounter,
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         side: const BorderSide(color: Colors.grey, width: 1)),
//                     child: const Icon(
//                       Icons.remove,
//                       color: Colors.black,
//                       size: 20.0,
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Text(
//                     '$_counter',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(width: 15),
//                   ElevatedButton(
//                     onPressed: _incrementCounter,
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         side: const BorderSide(color: Colors.grey, width: 1)),
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.black,
//                       size: 20.0,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//               SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFEEFF41),
//                   ),
//                   onPressed: () {  },
//                   child: const Text('ADD TO CART', style: TextStyle(color: Colors.white),),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepOrangeAccent
//                   ),
//                   onPressed: () {  },
//                   child: const Text('BUY NOW', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//
//               const SizedBox(height: 15,),
//
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.lock),
//                     onPressed: () {},
//                     iconSize: 20,
//                     color: Colors.grey,
//                   ),
//                   const SizedBox(height: 8.0),
//                   const Text(
//                     'Secure Transaction',
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDots(int itemCount) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(itemCount, (index) {
//           return Container(
//             width: 8.0,
//             height: 8.0,
//             margin: const EdgeInsets.symmetric(horizontal: 4.0),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _currentPage == index ? Colors.blue : Colors.grey,
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }


// CUSTOM PRODUCT CARD
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   bool _isFavorite = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF5F5F3),
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: GridView.builder(
//           itemCount: 4,
//
//           itemBuilder: (BuildContext context, int index) {
//             return  Container(
//               width: 200,
//               height: 265,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 3,
//                       blurRadius: 10,
//                       offset: const Offset(0, 3)),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                           alignment: Alignment.center,
//                           child: Image.asset(
//                             'assets/images/nike-shoes.png',
//                             height: 150,
//                           ),
//                         ),
//
//                         Positioned(
//                           top: 10.0,
//                           right: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 2,
//                                   blurRadius: 5,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: IconButton(
//                               icon: Icon(
//                                 _isFavorite
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                                 color: Colors.red,
//                                 size: 20,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isFavorite = !_isFavorite;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//
//                       ],
//                     ),
//
//                     const Text(
//                       'Nike Sports Shoe',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 4),
//                     const Text(
//                       'Green Nike Sports Shoe',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: 6),
//                     RatingBar.builder(
//                       initialRating: 4,
//                       minRating: 1,
//                       direction: Axis.horizontal,
//                       itemCount: 5,
//                       itemSize: 16,
//                       itemPadding: const EdgeInsets.symmetric(horizontal: 4),
//                       itemBuilder: (context, _) =>
//                           const Icon(Icons.star, color: Colors.red),
//                       onRatingUpdate: (index) {},
//                     ),
//                     const SizedBox(height: 6),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '\$20',
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 15,
//           childAspectRatio: 2 / 3,
//           mainAxisSpacing: 15,
//
//         ),
//         ),
//       ),
//     );
//   }
// }
