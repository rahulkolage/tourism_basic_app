import 'package:flutter/material.dart';
import 'package:tourism_basic_app/location_list.dart';
// import './models/location.dart';
// import './location_detail.dart';
// import './mocks/mock_location.dart';
// import './location_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // final Location mockLocation = MockLocation.fetchAny();
    // return runApp(MaterialApp(home: LocationDetail(mockLocation)));

    // no longer needed
    // // using location list
    // final mockLocations = MockLocation.fetchAll();
    // return MaterialApp(home: LocationList(mockLocations));

    return MaterialApp(home: LocationList());
  }
}
