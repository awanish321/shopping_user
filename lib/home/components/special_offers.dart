// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class SpecialOffers extends StatefulWidget {
//   const SpecialOffers({Key? key}) : super(key: key);
//
//   @override
//   State<SpecialOffers> createState() => _SpecialOffersState();
// }
//
// class _SpecialOffersState extends State<SpecialOffers> {
//   int _currentIndex = 0;
//
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
//     return FutureBuilder<QuerySnapshot>(
//       future: FirebaseFirestore.instance.collection('SliderBanner').get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting ||
//             snapshot.connectionState == ConnectionState.active) {
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Container(); // Empty container if no data or empty data
//           }
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//
//         List<DocumentSnapshot> documents = snapshot.data!.docs;
//
//         List<Widget> imageWidgets = documents.map((document) {
//           return Container(
//             margin: const EdgeInsets.all(6.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10.0),
//               child: CachedNetworkImage(
//                 imageUrl: document['image'],
//                 fit: BoxFit.cover,
//                 // placeholder: (context, url) => const CircularProgressIndicator(),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//           );
//         }).toList();
//
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('#SpecialForYou',style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold),),
//               const SizedBox(height: 8,),
//               CarouselSlider(
//                 items: imageWidgets,
//                 options: CarouselOptions(
//                   height: 210.0,
//                   enlargeCenterPage: true,
//                   autoPlay: true,
//                   aspectRatio: 16 / 9,
//                   autoPlayCurve: Curves.fastOutSlowIn,
//                   enableInfiniteScroll: true,
//                   autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                   viewportFraction: 0.8,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       _currentIndex = index;
//                     });
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   imageWidgets.length,
//                       (index) => buildDot(index: index),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildDot({required int index}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 2.0),
//       width: 8.0,
//       height: 8.0,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: _currentIndex == index ? Colors.blue : Colors.grey,
//       ),
//     );
//   }
// }
//


import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({Key? key}) : super(key: key);

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  int _currentIndex = 0;

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
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('SliderBanner').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildShimmerEffect(); // Show shimmer effect while loading
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<DocumentSnapshot> documents = snapshot.data!.docs;

        List<Widget> imageWidgets = documents.map((document) {
          return Container(
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: document['image'],
                fit: BoxFit.cover,
                // placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        }).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('#SpecialForYou',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              CarouselSlider(
                items: imageWidgets,
                options: CarouselOptions(
                  height: 210.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageWidgets.length,
                      (index) => buildDot(index: index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('#SpecialForYou',style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(height: 8,),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CarouselSlider.builder(
              itemCount: 5, // Change this according to your need
              itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                );
              },
              options: CarouselOptions(
                height: 210.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5, // Change this according to your need
                  (index) => buildDot(index: index),
            ),
          ),
        ],
      ),
    );
  }
}
