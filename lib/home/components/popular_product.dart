// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shopping_app/allProducts/all_products.dart';
// import 'package:shopping_app/home/components/section_title.dart';
// import 'package:shopping_app/product_detail/products.dart';
//
// import '../../models/p_products.dart';
//
// class PopularProducts extends StatefulWidget {
//   const PopularProducts({super.key});
//
//   @override
//   State<PopularProducts> createState() => _PopularProductsState();
// }
//
// class _PopularProductsState extends State<PopularProducts> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('Products').limit(4).snapshots(),
//         builder:  (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//             return const Text('No data available');
//           } else {
//             var products = snapshot.data!.docs.map((doc) {
//               return ProductModel.fromDocumentSnapshot(doc);
//             }).toList();
//
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: SectionTitle(title: "Popular Products",press: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProducts()));
//                   },
//                   ),
//                 ),
//
//                 GridView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     var product = products[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 ProductDetailsScreen(product: product),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: 200,
//                         height: 265,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: Colors.grey.withOpacity(0.2))
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.center,
//                                       child: Image.network(
//                                         product.images.isNotEmpty
//                                             ? product.images[0]
//                                             : '',
//                                         height: 150,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                   product.productName,
//                                   maxLines: 1,
//                                   style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                   product.productTitle,
//                                   maxLines: 2,
//                                   style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 14))
//                               ),
//                               const SizedBox(height: 4),
//                               RatingBar.builder(
//                                 initialRating: 4,
//                                 minRating: 1,
//                                 direction: Axis.horizontal,
//                                 itemCount: 5,
//                                 itemSize: 16,
//                                 itemPadding:
//                                 const EdgeInsets.symmetric(horizontal: 4),
//                                 itemBuilder: (context, _) => const Icon(
//                                     Icons.star,
//                                     color: Colors.red),
//                                 onRatingUpdate: (index) {},
//                               ),
//                               const SizedBox(height: 6),
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                       '₹${product.productPrice}',
//                                       style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red))
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   gridDelegate:
//                   const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 15,
//                     childAspectRatio: 2 / 3.2,
//                     mainAxisSpacing: 15,
//                   ),
//                 ),
//                 const Gap(40)
//               ],
//             );
//           }
//         }
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/allProducts/all_products.dart';
import 'package:shopping_app/home/components/section_title.dart';
import 'package:shopping_app/product_detail/products.dart';
import '../../models/p_products.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Products').limit(4).snapshots(),
        builder:  (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerEffect();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Text('No data available');
          } else {
            var products = snapshot.data!.docs.map((doc) {
              return ProductModel.fromDocumentSnapshot(doc);
            }).toList();

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SectionTitle(title: "Popular Products",press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProducts()));
                  },
                  ),
                ),

                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 265,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.withOpacity(0.2))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        product.images.isNotEmpty
                                            ? product.images[0]
                                            : '',
                                        height: 150,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                  product.productName,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                  product.productTitle,
                                  maxLines: 2,
                                  style:  const TextStyle(fontSize: 14)),
                              const SizedBox(height: 4),
                               RatingBar.builder(
                                  initialRating: 3,
                                  itemSize: 16,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.red,),
                                  onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '₹${product.productPrice}',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold ,color: Colors.red))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2 / 3.2,
                    mainAxisSpacing: 15,
                  ),
                ),
                const Gap(40)
              ],
            );
          }
        }
    );
  }

  Widget _buildShimmerEffect() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SectionTitle(title: "Popular Products", press: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProducts()));
          }),
        ),
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4, // Show 4 shimmer items
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              height: 265,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.2))
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 150,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 120,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 120,
                      height: 32,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 80,
                      height: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          height: 16,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            childAspectRatio: 2 / 3.2,
            mainAxisSpacing: 15,
          ),
        ),
        const Gap(40)
      ],
    );
  }
}
