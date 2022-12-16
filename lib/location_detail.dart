import 'package:flutter/material.dart';
//import 'package:tourism_basic_app/mocks/mock_location.dart';
import './models/location.dart';
import './styles.dart';

class LocationDetail extends StatefulWidget {
  final int locationID;

  LocationDetail(this.locationID);

  @override
  State<LocationDetail> createState() => _LocationDetailState(this.locationID);
}

class _LocationDetailState extends State<LocationDetail> {
  // using index/lcoationID instead of location object
  // final Location location;
  // LocationDetail(this.location);

  final int locationID;
  // LocationDetail(this.locationID);

  // retain loaded location, for this we will create CUSTOM named constructor
  Location location = Location.blank();

  // this class will have constructor, when state is first loaded / when class is instantiated, it needs to know
  // what location id it needs to load and we know upfront so "locationID" is final
  _LocationDetailState(this.locationID);

  // load data
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // fetch location object, this is mock data
    // in real scenario it will be api call
    // var location = MockLocation.fetch(locationID);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            (location.name).toString(),
            style: Styles.navBarTitle,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _renderBody(context, location)
              // [
              //   _section('Hello One', Colors.green),
              //   _section('Hello Two', Colors.redAccent),
              //   _section('Hello Three!', Colors.blue),
              // ],
              ),
        ));
  }

  // Widget _section(String title, Color color) {
  //   return Container(
  //     decoration: BoxDecoration(color: color),
  //     child: Text(title),
  //   );
  // }

  loadData() async {
    final location = await Location.fetchByID(locationID);
    
    // we have to adde mounted check as 
    // initState gets called before UI is ready that means
    // widget is might not mounted yet. It is phase when
    // widget first loads it not mounted into hierarchy of all widgets on screen
    // and if we call setState will trigger Build method, and we can't do it if widget is not mounted.
    if (mounted) {
      setState(() {
        this.location = location;
      });
    }
  }

  List<Widget> _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];

    // show image
    result.add(_bannerImage(location.url, 170.0));

    // redner text content
    result.addAll(_renderFacts(context, location));
    return result;
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    // var result = List<Widget>(); // it is deprecated
    var result = <Widget>[];

    for (int i = 0; i < (location.facts ?? []).length; i++) {
      result.add(_sectionTitle(location.facts![i].title));
      result.add(_sectionText(location.facts![i].text));
    }
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
      child: Text(text,
          textAlign: TextAlign.left,
          // style: TextStyle(fontSize: 24.0, color: Colors.black)),
          style: Styles.headerLarge),
    );
  }

  Widget _sectionText(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      child: Text(
        text,
        style: Styles.textDefault,
      ),
    );
  }

  // Adding Image
  Widget _bannerImage(String url, double height) {
    if (url.isEmpty) {
      return Container();
    }

    try {
      return Container(
        constraints: BoxConstraints.tightFor(height: height),
        child: Image.network(url, fit: BoxFit.fitWidth),
      );
    } catch (e) {
      print("could not load image $url");
      return Container();
    }

    // late Image image; // late keyword not needed when using locally

    // try {
    //   if (url.isNotEmpty) {
    //     image = Image.network(url, fit: BoxFit.fitWidth);
    //   }
    // } catch (e) {
    //   print('could not load image $url');
    // }

    // return Container(
    //   constraints: BoxConstraints.tightFor(height: height),
    //   child: image,
    // );
  }
}
