import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shopping_app/cart/empty_cart.dart';
import 'package:shopping_app/checkout/checkout_screen.dart';

import '../product_detail/products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final SelectedProductDetails selectedProduct;
  double calculateTotal(List<DocumentSnapshot<Object?>> items) {
    double total = 0.0;

    for (var item in items) {
      double itemPrice = 0.0;
      try {
        itemPrice = double.parse(item['salePrice'].toString().replaceAll(',', ''));
      } catch (e) {
        if (kDebugMode) {
          print('Error parsing salePrice: $e');
        }
      }
      total += itemPrice * (item['quantity'] ?? 1);
    }
    return total;
  }

  void _incrementCounterForItem(DocumentSnapshot<Object?> item) {
    setState(() {
      int currentQuantity = item['quantity'] ?? 1;
      currentQuantity++;
      FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(item.id).update({
        'quantity': currentQuantity,
      });
    });
  }

  // void _decrementCounterForItem(DocumentSnapshot<Object?> item) {
  //   setState(() {
  //     int currentQuantity = item['quantity'] ?? 1;
  //     if (currentQuantity > 1) {
  //       currentQuantity--;
  //       FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(item.id).update({
  //         'quantity': currentQuantity,
  //       });
  //     }
  //   });
  // }
  void _decrementCounterForItem(DocumentSnapshot<Object?> item) {
    setState(() {
      int currentQuantity = item['quantity'] ?? 1;
      if (currentQuantity > 1) {
        currentQuantity--;
        FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(item.id).update({
          'quantity': currentQuantity,
        });
      } else {
        // If the quantity is zero, delete the item from the cart
        FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(item.id).delete();
        // Show snackbar message
        // AwesomeSnackBar(
        //   context: context,
        //   title: 'Removed from Cart',
        //   body: Text('${item['productName']} removed from the cart.'),
        //   type: AwesomeSnackBarType.success, // Use lowercase 'success'
        //   margin: const EdgeInsets.all(8),
        //   duration: const Duration(seconds: 3),
        // )..show();


        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Congratulations',
            message: ('${item['productName']} removed from the cart.'),
            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,

          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);


      }
    });
  }

  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const EmptyCartScreen(); // Show empty cart screen
              }

              var items = snapshot.data!.docs;

              return Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(height: 5, thickness: 1,),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var item = items[index];

                      return Container(
                        width: double.infinity,
                        height: 182,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 3,
                          //     blurRadius: 10,
                          //     offset: const Offset(0, 3),
                          //   ),
                          // ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 10.0,
                                  right: 10.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        FontAwesomeIcons.remove,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(item.id).delete();
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Image.network(
                                          item['image'],
                                          height: 90,
                                          width: 90,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                item['productName'],
                                                maxLines: 1 ,
                                                style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis) ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            if (item['size'] != null && item['size'].isNotEmpty)
                                              Flexible(
                                                child: Text(
                                                  'Size: ${item['size']}',
                                                  style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
                                                ),
                                              ),
                                            const SizedBox(height: 5),
                                            Flexible(
                                              child: Text(
                                                'Color: ${item['color']}',
                                                style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Price: ₹${item['salePrice']}',
                                              style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    _decrementCounterForItem(item);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: const Icon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                                Text(
                                                    '${item['quantity']}',
                                                    style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    _incrementCounterForItem(item);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: const Icon(
                                                    FontAwesomeIcons.plus,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]
                                ),
                              ],
                            )
                        ),
                      );
                    },
                  ),
                  // const Divider(thickness: 1),
                  // const SizedBox(height: 20),
                  // // Display Delivery Charge
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Delivery Charge', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                  //     Text('₹125', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                  //   ],
                  // ),
                  // const SizedBox(height: 10),
                  // // Display Sub Total
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Sub Total', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                  //     Text(NumberFormat.currency(locale: 'en_IN', decimalDigits: 2, symbol: '₹ ').format(calculateTotal(items)), style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                  //   ],
                  // ),
                  // const SizedBox(height: 10),
                  // // Display Total
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Total', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                  //     Text(NumberFormat.currency(locale: 'en_IN', decimalDigits: 2, symbol: '₹ ').format(calculateTotal(items) + 125), style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                  //   ],
                  // ),
                  // const SizedBox(height: 25),
                  // SizedBox(
                  //   height: 50,
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: const Color(0xFFE53935),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(selectedProduct: selectedProduct,)));
                  //     },
                  //     child: Text('CHECKOUT', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))),
                  //   ),
                  // ),
                  // const SizedBox(height: 60),

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
