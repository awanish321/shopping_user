// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shopping_app/screens/signin_screen.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final List<String> imageList = [
//     'assets/sammy-line-searching.gif',
//     'assets/sammy-line-shopping.gif',
//     'assets/sammy-line-delivery.gif',
//   ];
//
//   int _current = 0;
//
//   List<String> headerTextList = [
//     "Welcome to AMart. Let's shop!",
//     "We help people connect with stores\naround the India",
//     "We show the easy way to shop.\nJust stay at home with us",
//   ];
//
//   Widget buildDot(int index) {
//     return Container(
//       width: _current == index ? 25.0 : 10.0, // Adjust the width here
//       height: 6.0,
//       margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//       decoration: BoxDecoration(
//         borderRadius: _current == index
//             ? BorderRadius.circular(5)
//             : BorderRadius.circular(4),
//         color: _current == index ? Colors.deepOrange : Colors.grey,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "AMart",
//                     style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange))
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     headerTextList[_current],
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.grey))
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Column(
//               children: [
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 300.0,
//                     // autoPlay: true,
//                     enlargeCenterPage: true,
//                     aspectRatio: 16 / 9,
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enableInfiniteScroll: true,
//                     autoPlayAnimationDuration:
//                         const Duration(milliseconds: 800),
//                     viewportFraction: 1.0,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         _current = index;
//                       });
//                     },
//                   ),
//                   items: imageList.map((item) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return Container(
//                           width: MediaQuery.of(context).size.width,
//                           margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                           decoration: const BoxDecoration(),
//                           child:Image.asset(
//                             item,
//                             fit: BoxFit.cover,
//                           ),
//                         );
//                       },
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: imageList.asMap().entries.map((entry) {
//                     return buildDot(entry.key);
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.all(40.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SignInScreen()));
//                     },
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(Colors.deepOrange),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     child: Text(
//                       'CONTINUE',
//                       style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold))
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shopping_app/screens/signin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return buildOnboardingPage(onboardingData[index]);
              },
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.blue.withOpacity(0.5),
                ),
                child: TextButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      onboardingData.length - 1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear,
                    );
                  },
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 20,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: isDarkMode ? Colors.white : Colors.grey.withOpacity(0.3),
                  color: Colors.grey.withOpacity(0.3)
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    if (_currentPageIndex < onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(isDarkMode),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator(bool isDarkMode) {
    List<Widget> indicators = [];
    for (int i = 0; i < onboardingData.length; i++) {
      indicators.add(i == _currentPageIndex ? _indicator(true, isDarkMode) : _indicator(false, isDarkMode));
    }
    return indicators;
  }

  Widget _indicator(bool isActive, bool isDarkMode) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 6.0,
      width: isActive ? 40.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? (isDarkMode ? Colors.white : Colors.black) : (isDarkMode ? Colors.grey : Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }

  Widget buildOnboardingPage(OnboardingData data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(data.imagePath, height: 320, width: 320,),
        const SizedBox(height: 20),
        Text(
          data.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          data.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class OnboardingData {
  final String imagePath;
  final String title;
  final String description;

  OnboardingData({required this.imagePath, required this.title, required this.description});
}

List<OnboardingData> onboardingData = [
  OnboardingData(
    imagePath: 'assets/sammy-line-searching.gif',
    title: 'Choose Your Product',
    description: "Welcome to a World of Limitless Choices - Your Perfect Product Awaits!",
  ),
  OnboardingData(
    imagePath: 'assets/sammy-line-shopping.gif',
    title: 'Select Payment Method',
    description: "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!",
  ),
  OnboardingData(
    imagePath: 'assets/sammy-line-delivery.gif',
    title: 'Deliver At Your Door Step',
    description: "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!",
  ),
];
