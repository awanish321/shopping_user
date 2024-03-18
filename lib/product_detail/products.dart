import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shopping_app/checkout/checkout_screen.dart';
import '../models/p_products.dart';


class SelectedProductDetails {
  final String productName;
  final String productPrice;
  final String salePrice;
  final double offPercentage;
  final int quantity;
  final String selectedColor;
  final String selectedSize;
  final String imageUrl;
  final Timestamp deliveryDate;

  SelectedProductDetails({
    required this.productName,
    required this.salePrice,
    required this.productPrice,
    required this.offPercentage,
    required this.quantity,
    required this.selectedColor,
    required this.selectedSize,
    required this.imageUrl,
    required this.deliveryDate
  });
}

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  Future<void> addToCart(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('Cart');

    var product = widget.product;

    // Get the first image
    String firstImage = product.images.isNotEmpty ? product.images.first : '';

    // Select the first color if available
    String selectedColor = _selectedColors.isNotEmpty ? _selectedColors.first : '';
    if (_selectedColors.isEmpty && product.colors.isNotEmpty) {
      selectedColor = product.colors.first;
      _selectedColors.add(selectedColor);
    }

    // Get selected size
    String selectedSize = _selectedSizes.isNotEmpty ? _selectedSizes.first : '';

    // Include quantity
    int quantity = _counter;

    // Build the cart item data
    Map<String, dynamic> cartItemData = {
      'image': firstImage,
      'productName': product.productName,
      'salePrice': product.salePrice,
      'color': selectedColor,
      'size': selectedSize,
      'quantity': quantity,
    };

    // Check if all necessary fields are present
    if (firstImage.isNotEmpty && selectedColor.isNotEmpty) {
      // Add the cart item to the user's cart collection
      collectionRef.doc(currentUser!.email).collection('items').add(cartItemData)
          .then((value) {
        debugPrint('Added to cart');


        final snackBar = SnackBar(

          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Congratulations',
            message: ('${widget.product.productName} Added to the cart.'),

            // / change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,

          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
        )

          .catchError((error) {
        print('Error adding to cart: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding to cart: $error')),
        );
      });
    } else {
      // Handle the case where necessary fields are missing
      if (kDebugMode) {
        print('Error: Some necessary fields are missing.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Some necessary fields are missing.')),
        );
      }
    }
  }


  Future<void> showCustomSnackBar(BuildContext context, String message) async {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        message: message,
        contentType: ContentType.success, title: 'Success',
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<void> addToFavourite(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection('Wishlist');

    var product = widget.product;

    // Get the first image
    String firstImage = product.images.isNotEmpty ? product.images.first : '';

    // Build the cart item data
    Map<String, dynamic> favouriteItemData = {
      'image': firstImage,
      'productName': product.productName,
      'productTitle': product.productTitle,
      'productPrice': product.productPrice,
    };

    // Check if the product is already in the wishlist
    bool isAlreadyInWishlist = await collectionRef
        .doc(currentUser!.email)
        .collection('items')
        .where('productName', isEqualTo: product.productName)
        .get()
        .then((snapshot) => snapshot.docs.isNotEmpty);

    if (!isAlreadyInWishlist) {
      // Add to wishlist
      await collectionRef
          .doc(currentUser.email)
          .collection('items')
          .add(favouriteItemData)
          .then((value) {
        // Show snack-bar when item is added to wishlist
        showCustomSnackBar(context, '${widget.product.productName} added to the Wishlist.');
      }).catchError((error) => print('Error adding to wishlist: $error'));
    } else {
      // Remove from wishlist
      await collectionRef
          .doc(currentUser.email)
          .collection('items')
          .where('productName', isEqualTo: product.productName)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
        // Show snackbar when item is removed from wishlist
        showCustomSnackBar(context, '${widget.product.productName} removed from the Wishlist.');
      }).catchError((error) => debugPrint('Error removing from wishlist: $error'));
    }
  }

  int calculateDeliveryCharge() {
    double productPrice = double.parse(widget.product.salePrice.replaceAll(',', ''));
    if (productPrice >= 500) {
      return 50;
    } else {
      return 0;
    }
  }

  void _buyNow() {
    if (_selectedColors.isNotEmpty) {
      String selectedSize = _selectedSizes.isNotEmpty ? _selectedSizes.first : 'No size selected';

      final SelectedProductDetails selectedProduct = SelectedProductDetails(
        productName: widget.product.productName,
        deliveryDate: widget.product.deliveryDate,
        salePrice: widget.product.salePrice,
        productPrice: widget.product.productPrice,
        offPercentage: calculateOfferPercentage().floorToDouble(),
        quantity: _counter,
        selectedColor: _selectedColors.first,
        selectedSize: selectedSize,
        imageUrl: widget.product.images.isNotEmpty ? widget.product.images.first : '', // Pass image URL
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(selectedProduct: selectedProduct),
        ),
      );
    } else {
      // Handle the case where color is not selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold),),
            content: const Text('Please select color before proceeding.', style: TextStyle(fontSize: 15),),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          );
        },
      );
    }
  }

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Set<String> _selectedColors = {};
  final Set<String> _selectedSizes = {};

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  num calculateOfferPercentage() {
    String mrpString = widget.product.productPrice.replaceAll(',', '');
    String salePriceString = widget.product.salePrice.replaceAll(',', '');

    try {
      double mrp = double.parse(mrpString);
      double salePrice = double.parse(salePriceString);

      if (mrp > 0) {
        double offerPercentage = ((mrp - salePrice) / mrp) * 100;
        return offerPercentage.floor();
      } else {
        return 0.0;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing double: $e');
      }
      return 0.0;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, size: 20,),
            contentPadding: const EdgeInsets.all(8.0),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                widget.product.productName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 5),
              const Divider(thickness: 1),
              const SizedBox(height: 15),
              SizedBox(
                height: 400,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: widget.product.images.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.product.images[index],
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),

                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                ' ${calculateOfferPercentage().toStringAsFixed(0)}%   \n Off',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white)
                              ),
                            ),
                          ),
                        ),

                        // Positioned for Favorite icon
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('Wishlist').doc(FirebaseAuth.instance.currentUser!.email).collection('items').where('productName', isEqualTo: widget.product.productName).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.data == null){
                              return const Text('');
                            }

                            bool isFavorite = snapshot.data.docs.isNotEmpty;

                            return Positioned(
                              top: 10.0,
                              right: 10.0,
                              child: GestureDetector(
                                onTap: () => addToFavourite(context),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.deepOrangeAccent : Colors.red,
                                    size: 25,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        Positioned(
                          bottom: 10.0,
                          left: 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.share,
                                color: Colors.deepOrangeAccent,
                                size: 25,
                              ),
                              onPressed: () {
                                // Handle share button press
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    _buildDots(widget.product.images.length),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Divider(thickness: 1),
              const SizedBox(height: 5,),
              SizedBox(
                width: double.infinity,
                child: ReadMoreText(
                  widget.product.productTitle,
                  trimLines: 2,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show More',
                  trimExpandedText: '...Show Less',
                    style: const TextStyle(fontSize: 15,),
                  moreStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),
                  lessStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)
                ),
              ),
              const SizedBox(height: 5,),
              const Divider(thickness: 1),

              // Display color selection
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Colors',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 15,),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 10,
                    children: List.generate(widget.product.colors.length, (index) {
                      final color = widget.product.colors[index];
                      final isSelected = _selectedColors.contains(color);

                      return SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedColors.clear();
                              _selectedColors.add(color);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: isSelected ? Colors.red : Colors.white,
                            elevation: isSelected ? 4 : 0,
                            shadowColor: isSelected ? Colors.grey : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            color,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black

                              ))
                          ),
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Display size selection
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.product.sizes.isNotEmpty) ...[
                    const Text(
                      'Sizes',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 15,),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 10,
                      children: List.generate(widget.product.sizes.length, (index) {
                        final size = widget.product.sizes[index];
                        final isSelected = _selectedSizes.contains(size);

                        return SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedSizes.remove(size);
                                } else {
                                  _selectedSizes.clear();
                                  _selectedSizes.add(size);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black, backgroundColor: isSelected ? Colors.red : Colors.white,
                              elevation: isSelected ? 4 : 0,
                              shadowColor: isSelected ? Colors.grey : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              size,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black
                                ))
                            ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),

              const SizedBox(height: 15,),
              Text('Sale Price : ₹${widget.product.salePrice}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Text('M.R.P. : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                  Text('₹${widget.product.productPrice}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                  color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 2
                  ))
                ],
              ),
              const Text('Inclusive of all Taxes', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 5,),
              const Divider(thickness: 1),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Text(
                      'Delivery - ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)
                  ),
                  Text(
                      DateFormat('dd MMMM yyyy').format(widget.product.deliveryDate.toDate()),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                ],
              ),

              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                      'Delivery Charge : ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                  Text(
                    '₹${calculateDeliveryCharge()}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.black,
                        shape: const CircleBorder()
                    ),
                    child: const Icon(
                      FontAwesomeIcons.minus,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  // const SizedBox(width: 15),
                  Text(
                    '$_counter',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                  // const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.black,
                        shape: const CircleBorder()
                        // side: const BorderSide(color: Colors.grey, width: 1)
                    ),
                    child: const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: const Color(0xFFEEFF41),
                    backgroundColor: Colors.yellow
                  ),
                  onPressed: () => addToCart(context),
                  child: const Text('ADD TO CART', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent
                  ),
                  onPressed: () { _buyNow();  },
                  child: const Text('BUY NOW', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
                  ),
                ),
              ),

              const SizedBox(height: 15,),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.lock),
                    onPressed: () {},
                    iconSize: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Secure Transaction',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)
                  ),
                ],
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Sold by ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text('EMart ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),),
                  Text('and ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text('Fulfilled by EMart ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),),
                ],
              ),

              const SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots(int itemCount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(itemCount, (index) {
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? Colors.blue : Colors.grey,
            ),
          );
        }),
      ),
    );
  }
}
