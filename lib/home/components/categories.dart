// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shopping_app/home/components/sub_category.dart';
// import '../../models/category_model.dart';
//
// class Categories extends StatefulWidget {
//   const Categories({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<Categories> createState() => _CategoriesState();
// }
//
// class _CategoriesState extends State<Categories> {
//   int selectedIndex = 0;
//   late bool _isLoading;
//
//   @override
//   void initState() {
//     _isLoading = true;
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//
//         if (snapshot.hasError) {
//           debugPrint('Error: ${snapshot.error}');
//           return Text('Error: ${snapshot.error}');
//         }
//
//         final categoryDocs = snapshot.data?.docs ?? [];
//         List<CategoryModel> categories = [];
//
//         for (var doc in categoryDocs) {
//           final category =
//           CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
//           categories.add(category);
//         }
//
//         return Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Popular Categories',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // CategoriesShimmer(),
//               const SizedBox(height: 10,),
//               SizedBox(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: categories.length,
//                   itemBuilder: (context, index) {
//                     final category = categories[index];
//                     return SizedBox(
//                       width: 80,
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = index;
//                           });
//
//                           debugPrint(
//                             'Selected Category: ${category.category}',
//                           );
//
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => SubCategoryScreen(
//                                 selectedCategory: category,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 65,
//                               height: 65,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(100),
//                                 image: DecorationImage(
//                                   image: NetworkImage(category.image),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 5,),
//                             Flexible(
//                               child: Text(
//                                 category.category,
//                                 style: TextStyle(
//                                   textStyle: const TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               // CategoriesShimmer()
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/home/components/sub_category.dart';
import '../../models/category_model.dart';

class Categories extends StatefulWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || _isLoading) {
          return _buildShimmerEffect(); // Show shimmer effect while loading
        }

        if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        }

        final categoryDocs = snapshot.data?.docs ?? [];
        List<CategoryModel> categories = [];

        for (var doc in categoryDocs) {
          final category =
          CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
          categories.add(category);
        }

        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Popular Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return SizedBox(
                      width: 80,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          debugPrint('Selected Category: ${category.category}',);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCategoryScreen(
                                selectedCategory: category,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: NetworkImage(category.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Flexible(
                              child: Text(
                                category.category,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 100,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Change this according to your need
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          width: 50,
                          height: 10,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
