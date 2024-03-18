// import 'package:flutter/material.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
//
// void main() {
//   runApp(CountryPickerWidget());
// }
//
// class CountryPickerWidget extends StatelessWidget {
//   const CountryPickerWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Demo for country picker package',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Country? _selectedCountry;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(
//             'Country Picker',
//             style: GoogleFonts.nunitoSans(),
//           )),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 showCountryPicker(
//                   useSafeArea: true,
//                   countryListTheme: CountryListThemeData(
//                       flagSize: 20,
//                       bottomSheetWidth: 400,
//                       bottomSheetHeight: 600,
//                       searchTextStyle: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 15),
//                       borderRadius: BorderRadius.circular(20),
//                       textStyle: GoogleFonts.nunitoSans(),
//                       inputDecoration: InputDecoration(
//                           hintText: "Enter country name",
//                           hintStyle: GoogleFonts.nunitoSans(color: Colors.grey),
//                           labelText: "Search",
//                           labelStyle: GoogleFonts.nunitoSans(color: Colors.grey),
//                           prefixIcon: const Icon(Icons.search, color: Colors.grey,),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
//                       )
//
//                   ),
//                   context: context,
//                   onSelect: (Country country) {
//                     setState(() {
//                       _selectedCountry = country;
//                     });
//                   },
//                 );
//               },
//               child: Text(
//                 'Show country picker',
//                 style: GoogleFonts.nunitoSans(color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 20),
//             if (_selectedCountry != null)
//               Text(
//                 _selectedCountry!.displayNameNoCountryCode,
//                 style: GoogleFonts.nunitoSans(
//                     fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:mi_country_picker/mi_country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CountryPickerScreen extends StatefulWidget {
  const CountryPickerScreen({Key? key}) : super(key: key);

  @override
  CountryPickerScreenState createState() => CountryPickerScreenState();
}

class CountryPickerScreenState extends State<CountryPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          dividerColor: Colors.transparent,
          cardTheme: const CardTheme(color: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(color: Colors.black)))),
      supportedLocales: const [
        Locale("af"),
        Locale("am"),
        Locale("ar"),
        Locale("az"),
        Locale("be"),
        Locale("bg"),
        Locale("bn"),
        Locale("bs"),
        Locale("ca"),
        Locale("cs"),
        Locale("da"),
        Locale("de"),
        Locale("el"),
        Locale("en"),
        Locale("es"),
        Locale("et"),
        Locale("fa"),
        Locale("fi"),
        Locale("fr"),
        Locale("gl"),
        Locale("ha"),
        Locale("he"),
        Locale("hi"),
        Locale("hr"),
        Locale("hu"),
        Locale("hy"),
        Locale("id"),
        Locale("is"),
        Locale("it"),
        Locale("ja"),
        Locale("ka"),
        Locale("kk"),
        Locale("km"),
        Locale("ko"),
        Locale("ku"),
        Locale("ky"),
        Locale("lt"),
        Locale("lv"),
        Locale("mk"),
        Locale("ml"),
        Locale("mn"),
        Locale("ms"),
        Locale("nb"),
        Locale("nl"),
        Locale("nn"),
        Locale("no"),
        Locale("pl"),
        Locale("ps"),
        Locale("pt"),
        Locale("ro"),
        Locale("ru"),
        Locale("sd"),
        Locale("sk"),
        Locale("sl"),
        Locale("so"),
        Locale("sq"),
        Locale("sr"),
        Locale("sv"),
        Locale("ta"),
        Locale("tg"),
        Locale("th"),
        Locale("tk"),
        Locale("tr"),
        Locale("tt"),
        Locale("uk"),
        Locale("ug"),
        Locale("ur"),
        Locale("uz"),
        Locale("vi"),
        Locale("zh")
      ],
      localizationsDelegates: [
        CountryPickerLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle get _defaultTextStyle => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  Widget title({String? title}) {
    return Text(
      title ?? "",
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  CountryData? initialDialogDefaultValue;
  CountryData? initialDialogCustomValue;
  CountryData? initialBottomDefaultValue;
  CountryData? initialBottomCustomValue;
  CountryData? initialCupertinoBottomDefaultValue;
  CountryData? initialCupertinoBottomCustomValue;

  @override
  void didChangeDependencies() {
    initialDialogDefaultValue =
        CountryPicker.getCountryData(context: context, code: "IN");
    initialDialogCustomValue =
        CountryPicker.getCountryData(context: context, code: "ID");
    initialBottomDefaultValue =
        CountryPicker.getCountryData(context: context, code: "IN");
    initialBottomCustomValue =
        CountryPicker.getCountryData(context: context, code: "IS");
    initialCupertinoBottomDefaultValue =
        CountryPicker.getCountryData(context: context, code: "IN");
    initialCupertinoBottomCustomValue =
        CountryPicker.getCountryData(context: context, code: "UY");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Country Picker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 5),
                      child: TextButton(
                        onPressed: () => CountryPicker
                            .showCountryPickerBottomSheet(
                          favouriteCountries: ["India"],
                          layoutConfig: const LayoutConfig(
                              elementsSequence:
                              Sequence.flagCodeAndCountryName),
                          context: context,
                        ).then((value) {
                          if (value != null) {
                            initialBottomDefaultValue = value;
                            debugPrint(
                                'showCountryPickerBottom :: ${initialBottomDefaultValue?.name}');
                            setState(() {});
                          }
                        }),
                        child: ButtonRowWidget(
                          dialCode:
                          initialBottomDefaultValue?.name,
                          flagUri: initialBottomDefaultValue?.flagUri,
                          // name: initialBottomDefaultValue?.name,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// common elevated child widget...
class ButtonRowWidget extends StatelessWidget {
  const ButtonRowWidget({
    super.key,
    this.flagUri,
    this.dialCode,
    this.name,
  });

  final String? flagUri;
  final String? dialCode;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          width: 30,
          height: 30,
          flagUri ?? "",
          package: "mi_country_picker",
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            "${dialCode ?? ""} ${name ?? ""}",
            overflow: TextOverflow.visible,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}