import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../address/widgets/single_address.dart';
import '../product_detail/products.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  final SelectedProductDetails selectedProduct;
  const CheckoutScreen({super.key, required this.selectedProduct});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  List<String> stepTitles = ['Order Summary', 'Address', 'Payment'];
  late String selectedAddressId;
  static const double deliveryCharge = 50.00;

  String calculateDiscountPrice() {
    double originalPrice = double.parse(widget.selectedProduct.productPrice.replaceAll(',', ''));
    double discountedPrice = double.parse(widget.selectedProduct.salePrice.replaceAll(',', ''));
    double discount = originalPrice - discountedPrice;
    return NumberFormat('#,###.00').format(discount.floor());
    // return NumberFormat.simpleCurrency(locale: 'hi-IN').format(discount);

  }

  String calculateTotalAmount() {
    double salePrice = double.parse(widget.selectedProduct.salePrice.replaceAll(',', ''));
    double totalAmount = salePrice  + deliveryCharge;
    // return NumberFormat('#,####.00#').format(totalAmount.floor());
    return NumberFormat.simpleCurrency(locale: 'hi-IN').format(totalAmount);
  }

  @override
  void initState() {
    super.initState();
    selectedAddressId = '';
  }

  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1;
      });
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
    setState(() {
      currentStep = value;
    });
  }

  void setSelectedAddressId(String addressId) {
    setState(() {
      selectedAddressId = addressId;
    });
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   width: 150,
          //   child: OutlinedButton(
          //     onPressed: details.onStepCancel,
          //     child: Text('Back',
          //         style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
          //   ),
          // ),
          SizedBox(
            height: 45,
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              onPressed: details.onStepCancel,
              child: Text(
                'Back',
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            height: 45,
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              onPressed: details.onStepContinue,
              child: Text(
                'Continue',
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int type = 1;
  void handleRadio(Object? e) => setState(() {
        type = e as int;
      });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(stepTitles[currentStep],
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
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
              return Colors.deepOrange; // Color when pressed
            }
            return Colors.deepOrange; // Default color
          },
        ),
        steps: [
          Step(
            title: Text('Order', style: GoogleFonts.nunitoSans()),
            content: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey,
                      // width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 85,
                          width: 85,
                          decoration: BoxDecoration(
                              // color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Image.network(
                                widget.selectedProduct.imageUrl,
                                height: 90,
                                width: 90,
                                fit: BoxFit.contain,
                              ),
                          ),
                        ),
                        // const SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(widget.selectedProduct.productName, style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold,) ,overflow: TextOverflow.ellipsis,)),
                              Expanded(child: Text('Color : ${widget.selectedProduct.selectedColor}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                              Expanded(child: Text('Product Price : ₹${widget.selectedProduct.productPrice}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                              Expanded(child: Text('Sale Price : ₹${widget.selectedProduct.salePrice}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                              Expanded(child: Text('Offer : ${widget.selectedProduct.offPercentage.floor()}% Off', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.deepOrange),)),
                              Expanded(child: Text('Quantity : ${widget.selectedProduct.quantity}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Price Details', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepOrange),),
                const Divider(thickness: 1,),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sale Price :', style: GoogleFonts.nunitoSans(fontSize: 15, ),),
                    Text('₹${widget.selectedProduct.salePrice}', style: GoogleFonts.nunitoSans(fontSize: 15, ),),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount :', style: GoogleFonts.nunitoSans(fontSize: 15,),),
                    Text(
                      '₹${calculateDiscountPrice()}',
                      style: GoogleFonts.nunitoSans(fontSize: 15.0,),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charges :', style: GoogleFonts.nunitoSans(fontSize: 15,),),
                    Text('₹$deliveryCharge', style: GoogleFonts.nunitoSans(fontSize: 15, ),),
                  ],
                ),
                const SizedBox(height: 5,),
                const Divider(thickness: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Amount :', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepOrange),),
                    Text(calculateTotalAmount(), style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepOrange),),
                  ],
                ),
                const Divider(thickness: 1,),
                const SizedBox(height: 10,),
              ],
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text('Address', style: GoogleFonts.nunitoSans()),
            content: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Addresses').doc(user!.email).collection('addresses').snapshots(),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const Center(
                //       child: SizedBox(),
                //       );
                // }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.hasData) {
                  final addresses = snapshot.data!.docs;
                  if (addresses.isEmpty) {
                    return Center(
                      child: Text('No addresses found.', style: GoogleFonts.nunitoSans(),),
                    );
                  }
                  return Column(
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
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text('Payment', style: GoogleFonts.nunitoSans()),
            content: Column(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: type == 1
                          ? Border.all(width: 1, color: Colors.redAccent)
                          : Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Colors.redAccent,
                              ),
                              Text(
                                'Amazon Pay',
                                style: type == 1
                                    ? GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.redAccent)
                                    : GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset('assets/images/ap.jpeg', width: 70, height: 70, fit: BoxFit.cover, )

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: type == 2
                          ? Border.all(width: 1, color: Colors.redAccent)
                          : Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Colors.redAccent,
                              ),
                              Text(
                                'Googal Pay',
                                style: type == 2
                                    ? GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.redAccent)
                                    : GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset('assets/icons/google-pay.png', height: 50, width: 50, fit: BoxFit.contain, )

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: type == 3
                          ? Border.all(width: 1, color: Colors.redAccent)
                          : Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 3,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Colors.redAccent,
                              ),
                              Text(
                                'Paytm',
                                style: type == 3
                                    ? GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.redAccent)
                                    : GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset('assets/paytm.png', height: 50, width: 50, fit: BoxFit.contain, )

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: type == 4
                          ? Border.all(width: 1, color: Colors.redAccent)
                          : Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 4,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Colors.redAccent,
                              ),
                              Text(
                                'Credit Card',
                                style: type == 4
                                    ? GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.redAccent)
                                    : GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset('assets/credit-card.png', height: 40, width: 40, fit: BoxFit.contain, )

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      border: type == 5
                          ? Border.all(width: 1, color: Colors.redAccent)
                          : Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Radio(
                          value: 5,
                          groupValue: type,
                          onChanged: handleRadio,
                          activeColor: Colors.redAccent,
                        ),
                        Text(
                          'Cash on Delivery',
                          style: type == 5
                              ? GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.redAccent)
                              : GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),

                      ],
                    ),
                  ),
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
