import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_place_picker/providers/place_provider.dart';

import 'bottom_button.dart';

// Your api key storage.
var apiKey = '';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Light Theme
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.grey,
    buttonTheme: const ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.yellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Place Picker Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickResult? selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google Map Place Picer Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text("Load Google Map"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlacePicker(
                          apiKey: apiKey,
                          initialPosition: HomePage.kInitialPosition,
                          useCurrentLocation: true,
                          selectInitialPosition: true,

                          //usePlaceDetailSearch: true,
                          onPlacePicked: (result) {
                            selectedPlace = result;
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          //forceSearchOnZoomChanged: true,
                          //automaticallyImplyAppBarLeading: false,
                          //autocompleteLanguage: "ko",
                          //region: 'au',
                          //selectInitialPosition: true,
                          selectedPlaceWidgetBuilder: (context,
                              selectedPlace,
                              state,
                              isSearchBarFocused,
                              saveLocation,
                              saveLocationName) {
                            debugPrint(
                                "state: $state, isSearchBarFocused: $isSearchBarFocused");
                            PlaceProvider provider =
                                PlaceProvider.of(context, listen: false);
                            return isSearchBarFocused
                                ? Container()
                                : FloatingCard(
                                    bottomPosition:
                                        0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                    leftPosition: 0.0,
                                    rightPosition: 0.0,
                                    width: double.infinity,
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: state == SearchingState.Searching
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 18,
                                            ),
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                SwitchListTile(
                                                  value: saveLocation,
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  onChanged: (bool value) {
                                                    provider.saveLocation =
                                                        value;
                                                  },
                                                  activeTrackColor:
                                                      const Color(0XFF4B6E82)
                                                          .withOpacity(0.7),
                                                  activeColor:
                                                      const Color(0XFF4B6E82),
                                                  inactiveTrackColor:
                                                      const Color(0XFF8CAEC5)
                                                          .withOpacity(0.3),
                                                  inactiveThumbColor:
                                                      const Color(0XFFF6F8FC),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: const Text(
                                                    'Save to my addresses',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0XFF4B6E82)),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: saveLocation,
                                                  child: TextField(
                                                    onChanged: (String val) {
                                                      provider.saveLocationName =
                                                          val;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color:
                                                            Color(0XFF8CAEC5),
                                                        size: 24,
                                                      ),
                                                      hintText:
                                                          "Type in your address here",
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Color(0XFF4B6E82),
                                                          fontSize: 15.0),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0XFFF6F8FC),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0XFFF6F8FC),
                                                            width: 1),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0XFFF6F8FC)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: BottomButton(
                                                      buttonName: "Save",
                                                      onPressed: !saveLocation
                                                          ? () {
                                                              print(
                                                                  "do something with [selectedPlace] data");
                                                              print(selectedPlace
                                                                  ?.formattedAddress);
                                                              print(
                                                                  saveLocationName);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          : saveLocationName
                                                                  .isNotEmpty
                                                              ? () {
                                                                  print(
                                                                      "do something with [selectedPlace] data");
                                                                  print(selectedPlace
                                                                      ?.formattedAddress);
                                                                  print(
                                                                      saveLocationName);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              : null),
                                                ),
                                              ],
                                            ),
                                          ),
                                  );
                          },
                          // pinBuilder: (context, state) {
                          //   if (state == PinState.Idle) {
                          //     return Icon(Icons.favorite_border);
                          //   } else {
                          //     return Icon(Icons.favorite);
                          //   }
                          // },
                        );
                      },
                    ),
                  );
                },
              ),
              selectedPlace == null
                  ? Container()
                  : Text(selectedPlace?.formattedAddress ?? ""),
            ],
          ),
        ));
  }
}
