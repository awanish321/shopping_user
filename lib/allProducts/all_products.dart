import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/p_products.dart';
import '../product_detail/products.dart';
import '../shimmer/shimmer.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final bool _isFavorite = false;
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
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
          title: const Text('All Products',
              style:  TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Products').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox(); // Loading indicator
            }
            return _isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2 / 3.2,
                        mainAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        return const ContainerShimmer(
                          height: 182,
                          width: double.infinity,
                          radius: 20,
                        );
                      },
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var document = snapshot.data!.docs[index];
                      ProductModel product =
                          ProductModel.fromDocumentSnapshot(document);
                      return buildProductCard(product);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 3.1,
                      mainAxisSpacing: 15,
                    ),
                  );
          },
        ));
  }

  Widget buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                product: product,
              ),
            ));
      },
      child: Container(
        width: 200,
        height: 285,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.2))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
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
              ),
              const SizedBox(height: 6),
              Text(product.productName,
                  maxLines: 1,
                  style:  const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(product.productTitle,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
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
                  Text('₹${product.productPrice}',
                      style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
