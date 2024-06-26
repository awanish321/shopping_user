import 'package:flutter/material.dart';
import 'package:shopping_app/address/widgets/rounded_container.dart';

class TSingleAddress extends StatefulWidget {
  const TSingleAddress({Key? key, required this.addressData}) : super(key: key);

  final Map<String, dynamic> addressData;

  @override
  State<TSingleAddress> createState() => _TSingleAddressState();
}

class _TSingleAddressState extends State<TSingleAddress> {
  bool selectedAddress = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = !selectedAddress;
        });
      },
      child: TRoundedContainer(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        showBorder: true,
        // backgroundColor: selectedAddress ? const Color(0xFFE53935) : Colors.transparent,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.addressData['name'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4,),
                Text(
                  widget.addressData['phoneNumber'] ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4,),
                Text(
                  '${widget.addressData['street'] ?? ''}, ${widget.addressData['city'] ?? ''}, ${widget.addressData['postalCode'] ?? ''}, ${widget.addressData['state'] ?? ''}, ${widget.addressData['country'] ?? ''}',
                  softWrap: true,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


