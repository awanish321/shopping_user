import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/screens/profile/components/notifications/empty_notifications_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Country? selectedCountry;
  String? selectedCountryEmoji;

  @override
  void initState() {
    super.initState();
    _loadSelectedCountryEmoji();
  }

  Future<void> _loadSelectedCountryEmoji() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmoji = prefs.getString('selectedCountryEmoji');
    if (storedEmoji != null) {
      setState(() {
        selectedCountryEmoji = storedEmoji;
      });
    }
  }

  Future<void> _saveSelectedCountryEmoji(String emoji) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCountryEmoji', emoji);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    showCountryPicker(
                      countryListTheme: CountryListThemeData(
                          flagSize: 30,
                          bottomSheetWidth: double.infinity,
                          bottomSheetHeight: 600,
                          searchTextStyle: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 15),
                          borderRadius: BorderRadius.circular(20),
                          textStyle: GoogleFonts.nunitoSans(),
                          inputDecoration: InputDecoration(
                              hintText: "Enter country name",
                              hintStyle: GoogleFonts.nunitoSans(color: Colors.grey),
                              labelText: "Search",
                              labelStyle: GoogleFonts.nunitoSans(color: Colors.grey),
                              prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                          )

                      ),
                      useSafeArea: true,
                      context: context,
                      onSelect: (Country country) async {
                        setState(() {
                          selectedCountry = country;
                          selectedCountryEmoji = country.flagEmoji;
                        });
                        await _saveSelectedCountryEmoji(country.flagEmoji);
                      },
                    );
                  },
                  child: const Text(
                    'Country & Language',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,),
                  ),
                ),
                const SizedBox(width: 10),
                if (selectedCountryEmoji != null)
                  Text(
                    selectedCountryEmoji!,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationScreen()),
                  );
                },
                child: const Text(
                  "Notifications",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "Permissions",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}