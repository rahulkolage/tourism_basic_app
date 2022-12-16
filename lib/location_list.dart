import 'dart:async';
import 'package:flutter/material.dart';
import './components/banner_image.dart';
import './components/location_tile.dart';
import './components/default_app_bar.dart';
import './models/location.dart';
import './location_detail.dart';
import './styles.dart';

const ListItemHeight = 245.0;

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
        // appBar: AppBar(title: Text('Locations', style: Styles.navBarTitle)),
        appBar: DefaultAppBar(),
        body: RefreshIndicator(
            onRefresh: loadData, //   <= This is of type Future<void>
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

    // we used media query to get width of screen
    return GestureDetector(
        onTap: () => _navigateToLocationDetail(context, location.id),
        child: Container(
          height: ListItemHeight,
          child: Stack(children: [
            // _tileImage(location.url, MediaQuery.of(context).size.width,ListItemHeight),
            BannerImage(url: location.url, height: ListItemHeight),
            _titleFooter(location),
          ]),
        ));

    // commenting for new UI
    // return ListTile(
    //   leading: _itemThumbnail(location),
    //   title: _itemTitle(location),
    //   contentPadding: EdgeInsets.all(10.0),
    //   // onTap: () => _navigateToLocationDetail(context, location),
    //   // we pass id, as have id in location objet
    //   onTap: () => _navigateToLocationDetail(context, location.id),
    // );
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

  // moving this code to custom component
  // Widget _tileImage(String url, double width, double height) {
  //   late Image image; // late keyword not needed when using locally
  //   try {
  //     image = Image.network(url, fit: BoxFit.cover);
  //   } catch (e) {
  //     print('could not load image $url');
  //   }

  //   return Container(
  //     constraints: BoxConstraints.expand(),
  //     child: image,
  //   );
  // }

  Widget _titleFooter(Location location) {
    final info = LocationTile(location: location, darkTheme: true);

    final overlay = Container(
      // height: 80.0, // static height, not needed as it gives pixel overlay
      padding: EdgeInsets.symmetric(
          vertical: 5.0, horizontal: Styles.horizontalPaddingDefault),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );

    // Column used to set Footer at bottom
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }

  // Commenting for UI modification, alternate to it is _tileImage
  // // Integration test, Load image using Image.network
  // Widget _itemThumbnail(Location location) {
  //   late Image image; // late keyword not needed when using locally
  //   try {
  //     image = Image.network(location.url, fit: BoxFit.fitWidth);
  //   } catch (e) {
  //     print('could not load image ${location.url}');
  //   }

  //   return Container(
  //     constraints: BoxConstraints.tightFor(width: 100.0),
  //     child: image,
  //   );
  // }

  // Widget _itemTitle(Location location) {
  //   // return Text(location.name, style: Styles.textDefault);
  //   // or
  //   return Text('${location.name}', style: Styles.textDefault);
  // }
}
