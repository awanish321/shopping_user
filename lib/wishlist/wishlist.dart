import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_app/shimmer/shimmer.dart';
import 'package:shopping_app/wishlist/empty_wishlist.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final bool _isFavorite = true;
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
        // backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomNavBar()));
        },
        ),
        title: const Text('Wishlist',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Wishlist').doc(FirebaseAuth.instance.currentUser!.email).collection('items').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const EmptyWishlistScreen(); // Show empty cart screen
              }

              if (snapshot.data?.docs.isEmpty ?? true) {
                return Center(
                  child: Text(
                    '',
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }

              var items = snapshot.data!.docs;

              return Column(
                children: [
                  _isLoading
                      ? GridView.builder(
                          shrinkWrap:  true,
                          itemCount: items.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            childAspectRatio: 2 / 3.4,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) {
                            return const ContainerShimmer(
                              height: 182,
                              width: double.infinity,
                              radius: 20,
                            );
                          },
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            var item =
                                items[index].data() as Map<String, dynamic>;

                            return Container(
                              width: double.infinity,
                              height: 170,
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: Image.network(
                                              item[
                                                  'image'], // Corrected image URL
                                              height: 140,
                                            ),
                                          ),
                                          Positioned(
                                            top: 5.0,
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  _isFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('Wishlist')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.email)
                                                      .collection('items')
                                                      .doc(items[index].id)
                                                      .delete();
                                      
                                                  final snackBar = SnackBar(
                                      
                                                    /// need to set following properties for best effect of awesome_snackbar_content
                                                    elevation: 0,
                                                    behavior: SnackBarBehavior.floating,
                                                    backgroundColor: Colors.transparent,
                                                    content: AwesomeSnackbarContent(
                                                      title: 'Congratulations',
                                                      message: ('${item['productName']} Removed from your wishlist.'),
                                      
                                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                      contentType: ContentType.success,
                                      
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                    ..hideCurrentSnackBar()
                                                    ..showSnackBar(snackBar);
                                      
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item[
                                          'productName'],
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item[
                                          'productTitle'],
                                      maxLines: 2,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 6),
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 16,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.red),
                                      onRatingUpdate: (index) {},
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '₹${item['productPrice']}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            childAspectRatio: 2 / 3.1,
                            mainAxisSpacing: 15,
                          ),
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
