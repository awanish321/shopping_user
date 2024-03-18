import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/address/add_new_address.dart';
import '../address/widgets/single_address.dart';
import '../orders/orders_screen.dart';
import '../product_detail/products.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final SelectedProductDetails selectedProduct;
  const CheckoutScreen({super.key, required this.selectedProduct,});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  List<String> stepTitles = ['Order Summary', 'Address', 'Payment'];
  late String selectedAddressId;
  static const double deliveryCharge = 50.00;
  late Razorpay _razorpay;
  int type = 1;

  String calculateDiscountPrice() {
    double originalPrice = double.parse(widget.selectedProduct.productPrice.replaceAll(',', ''));
    double discountedPrice = double.parse(widget.selectedProduct.salePrice.replaceAll(',', ''));
    double discount = originalPrice - discountedPrice;
    return NumberFormat('#,###.00').format(discount.floor());
  }

  String calculateTotalAmount() {
    double salePrice = double.parse(widget.selectedProduct.salePrice.replaceAll(',', ''));
    double totalAmount = (salePrice*widget.selectedProduct.quantity) + deliveryCharge;
    return NumberFormat.simpleCurrency(locale: 'hi-IN').format(totalAmount);
  }

  @override
  void initState() {
    super.initState();
    selectedAddressId = '';
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    createOrder();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful. Order placed.")),
    );

    // Navigate to the orders screen after payment success
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const OrdersScreen(),
      ),
    );
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Failed. Please try again.")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet response if needed
  }

  Future<void> createOrder() async {
    final user = FirebaseAuth.instance.currentUser;
    final orderId = FirebaseFirestore.instance.collection('Orders').doc(FirebaseAuth.instance.currentUser!.email);
    // Get the selected address details from FireStore
    DocumentSnapshot addressSnapshot = await FirebaseFirestore.instance.collection('Addresses').doc(user!.email).collection('addresses').doc(selectedAddressId).get();
    final addressData = addressSnapshot.data() as Map<String, dynamic>;

    await FirebaseFirestore.instance.collection('Orders').doc(FirebaseAuth.instance.currentUser!.email).collection("orders").add({
      'orderId': orderId,
      'userId': user.uid,
      'userEmail': user.email,
      'productName': widget.selectedProduct.productName,
      'productPrice': widget.selectedProduct.productPrice,
      'salePrice': widget.selectedProduct.salePrice,
      'quantity': widget.selectedProduct.quantity,
      'color': widget.selectedProduct.selectedColor,
      'imageUrl': widget.selectedProduct.imageUrl,
      'paymentMethod': 'Razorpay',
      'deliveryAddress': addressData, // Include selected address data
      'totalAmount': calculateTotalAmount(),
      'orderDate': DateTime.now(),
    });
  }

  void continueStep() {
    if (currentStep == 1) {
      // Check if an address is selected
      if (selectedAddressId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an address first.")),
        );
      } else {
        // Proceed to the next step if an address is selected
        setState(() {
          currentStep++;
        });
      }
    } else if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    } else {
      initiatePayment();
    }
  }


  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    if (value == 2 && selectedAddressId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an address first.")),
      );
    } else {
      setState(() {
        currentStep = value;
      });
    }
  }

  void setSelectedAddressId(String addressId) {
    setState(() {
      selectedAddressId = addressId;
    });
  }

  void handleRadio(Object? e) => setState(() {
    type = e as int;
  });

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (details.onStepCancel != null && currentStep > 0) // Render back button if onStepCancel is available and current step is not the first step
            SizedBox(
              height: 45,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                onPressed: details.onStepCancel,
                child: const Text(
                  'Back',
                  style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          if (details.onStepContinue != null && currentStep < 2) // Render continue button if onStepContinue is available and current step is not the last step
            const SizedBox(width: 20),
          if (currentStep < 2) // Render continue button only if current step is not the last step (payment step)
            SizedBox(
              height: 45,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                onPressed: details.onStepContinue,
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }



  void initiatePayment() async {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? '';
    final userPhone = user?.phoneNumber ?? '';

    final totalAmount = calculateTotalAmount().replaceAll('₹', '').replaceAll(',', '').trim(); // Remove commas from totalAmount
    final double totalAmountDouble = double.parse(totalAmount);
    final int totalAmountInPaise = (totalAmountDouble * 100).round();

    var options = {
      'key': 'rzp_test_vDbr0036XsVs1D', // Replace with your Razorpay key ID
      'amount': totalAmountInPaise,
      'name': 'AMart',
      'description': 'Payment for the order',
      'prefill': {
        'contact': userPhone, // User's phone number
        'email': userEmail, // User's email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    bool showFAB = currentStep == 1;

    return Scaffold(
      floatingActionButton: showFAB ? FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewAddressScreen()));
        },
        child: const Text("Add Address", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
      ) : null,
      appBar: AppBar(
        title: Text(stepTitles[currentStep],
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Stepper(
        controlsBuilder: controlBuilders,
        type: StepperType.horizontal,
        physics: const ScrollPhysics(),
        onStepTapped: onStepTapped,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
        currentStep: currentStep,
        connectorColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.deepOrange;
            }
            return Colors.deepOrange;
          },
        ),
        steps: [
          Step(
            title: const Text('Order',),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 85,
                          width: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Image.network(
                              widget.selectedProduct.imageUrl,
                              height: 90,
                              width: 90,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.selectedProduct.productName,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Color : ${widget.selectedProduct.selectedColor}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Product Price : ₹${widget.selectedProduct.productPrice}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Sale Price : ₹${widget.selectedProduct.salePrice}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Offer : ${widget.selectedProduct.offPercentage.floor()}% Off',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.deepOrange),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Quantity : ${widget.selectedProduct.quantity}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Price Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sale Price :',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '₹${widget.selectedProduct.salePrice}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Discount :',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '₹${calculateDiscountPrice()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Charges :',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '₹$deliveryCharge',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount :',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                    ),
                    Text(
                      calculateTotalAmount(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                    ),
                  ],
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
              ],
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: const Text('Address', style: TextStyle()),
            content: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Addresses').doc(user!.email).collection('addresses').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.hasData) {
                  final addresses = snapshot.data!.docs;
                  if (addresses.isEmpty) {
                    return Center(
                      child: Lottie.asset("assets/empty_address.json")
                    );
                  }
                  return Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Column(
                        children: addresses.map<Widget>((address) {
                          final data = address.data() as Map<String, dynamic>;
                          final addressId = address.id;
                          return RadioListTile<String>(
                            title: TSingleAddress(addressData: data),
                            value: addressId,
                            groupValue: selectedAddressId,
                            activeColor: Colors.redAccent,
                            onChanged: (value) {
                              setSelectedAddressId(value!);
                            },
                          );
                        }).toList(),
                      ),
                    ]
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: const Text('Payment', style: TextStyle()),
            content: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    initiatePayment();
                  },
                  child: const Text('Pay with Razorpay'),
                ),
              ],
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),
        ],
      ),
    );
  }
}
