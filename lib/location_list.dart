import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tourism_basic_app/location_detail.dart';
import './models/location.dart';
import './styles.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  // class LocationList extends StatelessWidget {
  // final List<Location> locations;

  // const LocationList({required this.locations, super.key}); // solve super key scenario with multiple params later
  // const LocationList(this.locations); // constructor

  // we don't need locations list as final, as we don't need constructor
  // as we instantiate it with empty list
  List<Location> locations = [];
  bool loading = false;

  // we have to call loadData() once
  @override
  void initState() {
    // super represents what we are extending
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Locations', style: Styles.navBarTitle)),
        body: RefreshIndicator(
            onRefresh: loadData,    //   <= This is of type Future<void>
            child: Column(children: [
              renderProgressBar(context),
              Expanded(child: renderListView(context)),
            ])));
  }

  // fetch data
  // loadData us used in RefreshIndicatior where onRefresh require return type to be Future
  // and loadData type is dynamic, so specify loadData type as Future<void>
  Future<void> loadData() async {
    if (mounted) {
      setState(() => loading = true);

      // Timer is used to slowdown api call in order to see Progress bar functionality
      Timer(const Duration(milliseconds: 3000), () async {
        final locations = await Location.fetchAll();
        setState(() {
          this.locations = locations;
          loading = false;
        });
      });
    }
  }

  Widget renderListView(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: _listviewItemBuilder, // passing callback function

      // (context, index) {
      //   return ListTile(
      //     leading: _itemThumbnail(locations[index]),
      //     title: _itemTitle(locations[index]),
      //     contentPadding: EdgeInsets.all(10.0),
      //     onTap: () => _navigateToLocationDetail(context, locations[index]),
      //   );
      // },
    );
  }

  Widget renderProgressBar(BuildContext context) {
    return (loading
        ? LinearProgressIndicator(
            value: null,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey))
        : Container());
  }

  Widget _listviewItemBuilder(BuildContext context, int index) {
    // get location by index
    final location = locations[index];

    return ListTile(
      leading: _itemThumbnail(location),
      title: _itemTitle(location),
      contentPadding: EdgeInsets.all(10.0),
      // onTap: () => _navigateToLocationDetail(context, location),
      // we pass id, as have id in location objet
      onTap: () => _navigateToLocationDetail(context, location.id),
    );
  }

  // navigation method
  // instead of passing whole location object, we pass index
  // void _navigateToLocationDetail(BuildContext context, Location location) {
  void _navigateToLocationDetail(BuildContext context, int locationID) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationDetail(locationID),
        ));
  }

  // Integration test, Load image using Image.network
  Widget _itemThumbnail(Location location) {
    late Image image; // late keyword not needed when using locally
    try {
      image = Image.network(location.url, fit: BoxFit.fitWidth);
    } catch (e) {
      print('could not load image ${location.url}');
    }

    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0),
      child: image,
    );
  }

  // Widget _itemThumbnail(Location location) {
  //   return Container(
  //     constraints: BoxConstraints.tightFor(width: 100.0),
  //     child: Image.network(location.url, fit: BoxFit.fitWidth),
  //   );
  // }

  Widget _itemTitle(Location location) {
    // return Text(location.name, style: Styles.textDefault);
    // or
    return Text('${location.name}', style: Styles.textDefault);
  }
}
