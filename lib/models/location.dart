import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import './location_fact.dart';
import './../endpoint.dart';

/// This allows the `Location` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'location.g.dart';

// Creating model classes the json_serializable way

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
/// this class model is serializable.
@JsonSerializable()
class Location {
  final int id;
  final String name; // final String? name;
  final String url;
  final String userItinerarySummary;
  final String tourPackageName;
  final List<LocationFact>? facts;

  Location(
      {required this.id,
      required this.name,
      required this.url,
      required this.userItinerarySummary,
      required this.tourPackageName,
      required this.facts});

  // CUSTOM named constructor, which instantiate everything with default values
  // we usually set initial value at time of valriable declaration but variables
  // are declared final, as final makes eaiser to pass in variables.

  // this will be used in location_detail.dart to retain location state
  Location.blank()
      : id = 0,
        name = '',
        url = '',
        userItinerarySummary = '',
        tourPackageName = '',
        facts = [];

  // using special named constructor
  /// A necessary factory constructor for creating a new Location instance
  /// from a map. Pass the map to the generated `_$LocationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Location.
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  // fetchAll method for web service call
  static Future<List<Location>> fetchAll() async {
    var uri = Endpoint.uri('/locations');

    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }

    List<Location> list = <Location>[];

    for (var jsonItem in jsonDecode(resp.body)) {
      list.add(Location.fromJson(jsonItem));
    }
    return list;
  }

  // fetchAll method
  static Future<Location> fetchByID(int id) async {
    var uri = Endpoint.uri('/locations/$id');

    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }

    final Map<String, dynamic> itemMap = jsonDecode(resp.body);
    return Location.fromJson(itemMap);
  }
}
