import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:intl/intl.dart';
import '../product_detail/products.dart';
import 'empty_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final SelectedProductDetails selectedProduct;
  final _indianCurrencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

  double calculateTotal(DocumentSnapshot<Object?> item) {
    double itemPrice = 0.0;
    try {
      itemPrice = double.parse(item['salePrice'].toString().replaceAll(',', ''));
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing salePrice: $e');
      }
    }

    // Calculate the increased price based on quantity
    double increasedPrice = itemPrice * (item['quantity'] ?? 1);
    return increasedPrice;
  }

  void _incrementCounterForItem(DocumentSnapshot<Object?> item) {
    if(mounted){
      setState(() {
        int currentQuantity = item['quantity'] ?? 1;
        currentQuantity++;
        FirebaseFirestore.instance.collection('Cart').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(item.id).update({
          'quantity': currentQuantity,
        });
      });
    }
  }

  void _decrementCounterForItem(DocumentSnapshot<Object?> item) {
    if(mounted){
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
  }

  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.deepOrangeAccent,
          title: const Text('Cart', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    separatorBuilder: (context, index) => const Gap(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var item = items[index];
                      double totalPrice = calculateTotal(item);

                      return Container(
                        width: double.infinity,
                        height: 182,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 10.0,
                                  right: 10.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete_forever_rounded,
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
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            if (item['size'] != null && item['size'].isNotEmpty)
                                              Flexible(
                                                child: Text(
                                                  'Size: ${item['size']}',
                                                  style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            const SizedBox(height: 5),
                                            Flexible(
                                              child: Text(
                                                'Color: ${item['color']}',
                                                style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Total Price: ${_indianCurrencyFormat.format(totalPrice)}', // Display formatted total price here
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
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
                                                    size: 12,
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
