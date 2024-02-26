import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/p_products.dart';
import '../product_detail/products.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  bool _isFavorite = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F3),
      appBar: AppBar(
        title: Text('All Products', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold))),
      ),
    body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();  // Loading indicator
          }

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var document = snapshot.data!.docs[index];
              ProductModel product = ProductModel.fromDocumentSnapshot(document);
              return buildProductCard(product);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              childAspectRatio: 2/ 3.4,
              mainAxisSpacing: 15,
            ),
          );
        },
       )
      );
  }

  Widget buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product,),
        )
        );
      },
      child: Container(
        width: 200,
        height: 285,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     // spreadRadius: 1,
          //     blurRadius: 1,
          //     offset: const Offset(0, 1),
          //   ),
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.network(
                      product.images.isNotEmpty ? product.images[0] : '',
                      height: 140,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                product.productName,
                maxLines: 1,
                  style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ),
              const SizedBox(height: 6),
              Text(
                product.productTitle,
                maxLines: 2,
                  style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 14))
              ),
              const SizedBox(height: 6),
              RatingBar.builder(
                initialRating: 4,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 16,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.red),
                onRatingUpdate: (index) {},
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${product.productPrice}',
                      style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red))
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



