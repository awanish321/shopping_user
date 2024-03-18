import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  Brightness? _currentBrightness;

  @override
  void initState() {
    super.initState();
    _getCurrentBrightness();
  }

  Future<void> _getCurrentBrightness() async {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    setState(() {
      _currentBrightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color searchFieldColor =
    _currentBrightness == Brightness.dark ? Colors.white : Colors.grey;

    return Form(
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: searchFieldColor.withOpacity(0.4),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          border: searchOutlineInputBorder,
          focusedBorder: searchOutlineInputBorder,
          enabledBorder: searchOutlineInputBorder,
          hintText: "Search product",
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          prefixIcon: const Icon(Icons.search, size: 25),
          suffixIcon: const Icon(Iconsax.microphone_2, size: 25),
        ),
      ),
    );
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(15)),
  borderSide: BorderSide.none,
);
