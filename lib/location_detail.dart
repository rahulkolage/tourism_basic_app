import 'package:flutter/material.dart';
//import 'package:tourism_basic_app/mocks/mock_location.dart';
import 'package:url_launcher/url_launcher.dart';
import './components/banner_image.dart';
import './components/location_tile.dart';
import './components/default_app_bar.dart';
import './models/location.dart';
import './styles.dart';

const BannerImageHeight = 300.0;
const BodyVerticalPadding = 20.0;
const FooterHeight = 100.0;

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
        // appBar: AppBar(title: Text((location.name).toString(),style: Styles.navBarTitle)),
        appBar: DefaultAppBar(),
        body: Stack(
          children: [
            _renderBody(context, location),
            _renderFooter(context, location)
          ],
        )
        // SingleChildScrollView(
        //     child: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: Stack(children: [
        //     _renderBody(context, location),
        //     _renderFooter(context, location)
        //   ])
        // ))
        );
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

  // List<Widget> _renderBody(BuildContext context, Location location) {
  Widget _renderBody(BuildContext context, Location location) {    
    var result = <Widget>[];

    // show image
    // result.add(_bannerImage(location.url, BannerImageHeight)); //170.0

    result.add(BannerImage(url: location.url, height: BannerImageHeight)); //170.0

    result.add(_renderHeader());

    // redner text content
    result.addAll(_renderFacts(context, location));

    result.add(_renderBottomSpacer());

    // result;
    // wrap result into SingleChildScrollView and _renderBody is no longer list of widget
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: result));        
  }

  Widget _renderHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: BodyVerticalPadding,
          horizontal: Styles.horizontalPaddingDefault),
      child: LocationTile(location: location, darkTheme: false),
    );
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
      // padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
      padding: EdgeInsets.fromLTRB(Styles.horizontalPaddingDefault, 25.0,
          Styles.horizontalPaddingDefault, 0.0),
      child: Text(text.toUpperCase(),
          textAlign: TextAlign.left, style: Styles.headerLarge),
    );
  }

  Widget _sectionText(String text) {
    return Container(
      // padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      padding: EdgeInsets.symmetric(
          vertical: 10.0, horizontal: Styles.horizontalPaddingDefault),
      child: Text(
        text,
        style: Styles.textDefault,
      ),
    );
  }

  Widget _renderFooter(BuildContext context, Location location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
          height: FooterHeight,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: _renderBookButton()),
        )
      ],
    );
  }

  Widget _renderBookButton() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Styles.accentColor,
        foregroundColor: Styles.textColorBright,
      ),
      onPressed: _handleBookPress,
      child: Text(
        'Book'.toUpperCase(), style: Styles.textCTAButton,
      ),
    );
  }

  // this may crash app as on some devices mailto may not work
  void _handleBookPress() async {
    const url = 'mailto:hello@tourism.co?subject=inquary';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not lauch $url';
    }
  }

  Widget _renderBottomSpacer() {
    return Container(height: FooterHeight);
  }

  // Adding Image
  // Widget _bannerImage(String url, double height) {
  //   if (url.isEmpty) {
  //     return Container();
  //   }

  //   try {
  //     return Container(
  //       constraints: BoxConstraints.tightFor(height: height),
  //       child: Image.network(url, fit: BoxFit.fitWidth),
  //     );
  //   } catch (e) {
  //     print("could not load image $url");
  //     return Container();
  //   }

  //   // late Image image; // late keyword not needed when using locally

  //   // try {
  //   //   if (url.isNotEmpty) {
  //   //     image = Image.network(url, fit: BoxFit.fitWidth);
  //   //   }
  //   // } catch (e) {
  //   //   print('could not load image $url');
  //   // }

  //   // return Container(
  //   //   constraints: BoxConstraints.tightFor(height: height),
  //   //   child: image,
  //   // );
  // }
}
