// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// void main() {
//   runApp(MaterialApp(home: HomeScreen()));
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int notificationCount = 3;
//   final List<String> imageList = [
//     'assets/images/Image Banner 2.png', // Replace with your image URLs
//     'assets/images/Image Banner 3.png', // Replace with your image URLs
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15.0),
//                           color: Colors.black12,
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 15.0, horizontal: 15),
//                               child: SvgPicture.asset(
//                                 'assets/icons/Search Icon.svg',
//                                 color: Color(0xFF757575),
//                               ),
//                             ),
//                             Expanded(
//                               child: TextFormField(
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                                 decoration: InputDecoration(
//                                   hintText: 'Search Product',
//                                   hintStyle: TextStyle(
//                                     color: Color(0xFF757575),
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.black12,
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         // Handle cart icon button press
//                       },
//                       icon: SvgPicture.asset(
//                         'assets/icons/Cart Icon.svg',
//                         color: Color(0xFF757575),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 7),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 18.0),
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black12,
//                             shape: BoxShape.circle,
//                           ),
//                           child: IconButton(
//                             onPressed: () {
//                               // Handle notification icon button press
//                             },
//                             icon: SvgPicture.asset(
//                               'assets/icons/Bell.svg',
//                               color: Color(0xFF757575),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           child: Container(
//                             padding: EdgeInsets.all(2),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                             constraints: BoxConstraints(
//                               minWidth: 16,
//                               minHeight: 16,
//                             ),
//                             child: Text(
//                               '$notificationCount',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 // Handle list tile tap
//               },
//               highlightColor: Colors.transparent,
//               splashColor: Colors.transparent,
//               child: Container(
//                 margin: EdgeInsets.all(20.0),
//                 padding: EdgeInsets.all(12.0),
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurple,
//                   borderRadius: BorderRadius.circular(15.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 3,
//                       blurRadius: 7,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: const ListTile(
//                   title: Text(
//                     'A Summer Surprise',
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                   subtitle: Text(
//                     'Cashback 20%',
//                     style: TextStyle(color: Colors.white, fontSize: 25),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   buildIconButton('assets/icons/Flash Icon.svg', 'DealS'),
//                   buildIconButton('assets/icons/Bill Icon.svg', 'Bill'),
//                   buildIconButton('assets/icons/Game Icon.svg', 'Game'),
//                   buildIconButton('assets/icons/Gift Icon.svg', 'Daily Gift'),
//                   buildIconButton('assets/icons/Discover.svg', 'More'),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(22, 10, 20, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Special for you",
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Add your onPressed function here
//                     },
//                     style: ButtonStyle(
//                       foregroundColor:
//                       MaterialStateProperty.all<Color>(Color(0xFF757575)),
//                       overlayColor:
//                       MaterialStateProperty.all<Color>(Colors.transparent),
//                     ),
//                     child: Text('See More'),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 15),
//             CarouselSlider(
//               items: imageList.map((item) {
//                 return Container(
//                   margin: const EdgeInsets.all(15.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Stack(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           image: DecorationImage(
//                             image: AssetImage(item),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: Colors.grey.withOpacity(0.5),
//                         ),
//                       ),
//                       Positioned(
//                         left: 20,
//                         bottom: 20,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TextFormField(
//                               style: TextStyle(color: Colors.white),
//                               decoration: InputDecoration(
//                                 hintText: 'Smartphone',
//                                 hintStyle: TextStyle(color: Colors.white),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             TextFormField(
//                               style: TextStyle(color: Colors.white),
//                               decoration: InputDecoration(
//                                 hintText: '18 Brands',
//                                 hintStyle: TextStyle(color: Colors.white),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               options: CarouselOptions(
//                 height: 150.0,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 aspectRatio: 16 / 9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                 viewportFraction: 0.9, // Adjust this value to control the visibility of the carousel images
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(22, 10, 20, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Popular Product",
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Add your onPressed function here
//                     },
//                     style: ButtonStyle(
//                       foregroundColor:
//                       MaterialStateProperty.all<Color>(Color(0xFF757575)),
//                       overlayColor:
//                       MaterialStateProperty.all<Color>(Colors.transparent),
//                     ),
//                     child: Text('See More'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildIconButton(String iconPath, String label) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15.0),
//             color: Color(0xFFFBE9E7),
//           ),
//           padding: EdgeInsets.all(18),
//           child: SvgPicture.asset(
//             iconPath,
//             height: 28.0,
//             width: 28.0,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.grey,
//             fontSize: 14,
//           ),
//         ),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int notificationCount = 3;
  final List<String> imageList = [
    'assets/images/Image Banner 2.png', // Replace with your image URLs
    'assets/images/Image Banner 3.png', // Replace with your image URLs
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.black12,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15),
                              child: SvgPicture.asset(
                                'assets/icons/Search Icon.svg',
                                color: const Color(0xFF757575),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Search Product',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF757575),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Handle cart icon button press
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/Cart Icon.svg',
                        color: const Color(0xFF757575),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Handle notification icon button press
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/Bell.svg',
                              color: const Color(0xFF757575),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$notificationCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Handle list tile tap
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const ListTile(
                  title: Text(
                    'A Summer Surprise',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  subtitle: Text(
                    'Cashback 20%',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildIconButton('assets/icons/Flash Icon.svg', 'DealS'),
                  buildIconButton('assets/icons/Bill Icon.svg', 'Bill'),
                  buildIconButton('assets/icons/Game Icon.svg', 'Game'),
                  buildIconButton('assets/icons/Gift Icon.svg', 'Daily Gift'),
                  buildIconButton('assets/icons/Discover.svg', 'More'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Special for you",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your onPressed function here
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF757575)),
                      overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                    ),
                    child: const Text('See More'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CarouselSlider(
              items: imageList.map((item) {
                return Container(
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(item),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      const Positioned(
                        left: 20,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Smartphone',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '18 Brands',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 150.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.9, // Adjust this value to control the visibility of the carousel images
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular Product",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your onPressed function here
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF757575)),
                      overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                    ),
                    child: const Text('See More'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconButton(String iconPath, String label) {
    return InkWell(
      onTap: () {
        // Handle your onTap functionality here
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0xFFFBE9E7),
            ),
            padding: const EdgeInsets.all(18),
            child: SvgPicture.asset(
              iconPath,
              height: 28.0,
              width: 28.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
