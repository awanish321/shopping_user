import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/Back ICon.svg",
                      height: 20,
                      width: 20,
                      color: const Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(width: 100),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
            const Text(
              "Complete Profile",
              style: TextStyle(
                  color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
              child: Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Color(0xFF757575)),
              ),
            ),

            // TextFormFields
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Enter your first name',
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  suffixIcon: const Icon(Icons.person_2_rounded, color: Color(0xFF757575),),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Enter your last name',
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  suffixIcon: const Icon(Icons.person_2_rounded, color: Color(0xFF757575),),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  suffixIcon: const Icon(Icons.phone_rounded, color: Color(0xFF757575),),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your address',
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  suffixIcon: const Icon(Icons.home_filled, color: Color(0xFF757575),),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  hintText: 'Enter your city',
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  suffixIcon: const Icon(Icons.location_city_rounded, color:Color(0xFF757575)),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: 'State',
                  hintText: 'Enter your state',
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  suffixIcon: const Icon(Icons.location_on, color: Color(0xFF757575),),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 150.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/icons/google-icon.svg",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/icons/facebook-2.svg",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/icons/twitter.svg",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
              child: Text(
                "By continuing you confirm that you agree \nwith our Terms and Conditions",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Color(0xFF757575)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
