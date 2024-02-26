import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/home/components/section_title.dart';
import '../../models/category_model.dart';
import '../../models/p_products.dart';
import '../../models/subcategory_model.dart';
import '../../product_detail/products.dart';

class SubCategoryScreen extends StatefulWidget {
  final CategoryModel selectedCategory;

  const SubCategoryScreen({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

bool _isFavorite = false;

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CollectionReference subCategoryRef =
  FirebaseFirestore.instance.collection("SubCategory");
  CollectionReference productRef =
  FirebaseFirestore.instance.collection("Products");

  Future<List<SubCategoryModel>> readSubCategory() async {
    try {
      QuerySnapshot response = await subCategoryRef
          .where('category', isEqualTo: widget.selectedCategory.category)
          .get();
      return response.docs.map((e) => SubCategoryModel.fromJson(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching subcategories: $e');
      }
      return [];
    }
  }

  Future<List<ProductModel>> readProducts(String subcategory) async {
    try {
      QuerySnapshot response = await productRef
          .where('subCategory', isEqualTo: subcategory)
          .get();
      return response.docs
          .map((e) => ProductModel.fromDocumentSnapshot(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
      return [];
    }
  }

  List<ProductModel> _displayedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F3),
      appBar: AppBar(
        title: Text(widget.selectedCategory.category, style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: FutureBuilder<List<SubCategoryModel>>(
          future: readSubCategory(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   // return const Center(child: CircularProgressIndicator());
            // } else
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text(''));
            } else {
              List<SubCategoryModel> subCategories = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display subcategories horizontally
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: subCategories.length,
                        itemBuilder: (context, index) {
                          final subCategory = subCategories[index];
                          return GestureDetector(
                            onTap: () async {
                              List<ProductModel> products =
                              await readProducts(subCategory.subcategory!);
                              if (kDebugMode) {
                                print(
                                    'Tapped on subcategory: ${subCategory.subcategory!}');
                              }
                              if (kDebugMode) {
                                print('Number of products: ${products.length}');
                              }
                              setState(() {
                                _displayedProducts = products;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        image: NetworkImage(subCategory.image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(subCategory.subcategory!, style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 13))),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Display products for the selected subcategory

                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text('Products', style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                    GridView.builder(
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = _displayedProducts[index];
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
                              color: Colors.white,
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
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
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
                                  const SizedBox(height: 4),
                                  Text(
                                    product.productName,
                                    maxLines: 1,
                                      style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.productTitle,
                                    maxLines: 2,
                                      style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 14))
                                  ),
                                  const SizedBox(height: 4),
                                  RatingBar.builder(
                                    initialRating: 4,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemSize: 16,
                                    itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4),
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
                      },
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2 / 3.4,
                        mainAxisSpacing: 15,
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
