import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import './../../lib/models/location.dart';

// https://docs.flutter.dev/development/data-and-backend/json
void main() {
  
  // This is hardcoded json
  // test('Test location deserialization',() {

  //   const locationJSON = '{"name": "Arashiyama Bamboo Grove", "url": "https://cdn-images-1.medium.com/max/2000/1*vdJuSUKWl_SA9Lp-32ebnA.jpeg","facts": [{"title": "Summary", "text": "While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto."}, {"title": "How to Get There","text": "Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto."}] }';

  //   // convert string into map
  //   final locationMap = json.decode(locationJSON) as Map<String, dynamic>;
    
  //   expect('Arashiyama Bamboo Grove', equals(locationMap['name']));

  //   // location object test
  //   // get Location object from location model which is json serialized
  //   final location = Location.fromJson(locationMap);

  //   expect(location.name, equals(locationMap['name']));
  //   expect(location.url, equals(locationMap['url']));

  //   // check facts test
  //   expect(location.facts[0].title, matches(locationMap['facts'][0]['title']));
  //   expect(location.facts[0].text, matches(locationMap['facts'][0]['text']));
  // });

  // using web service 
  test('test /locations and /locations/:id', () async {
    final locations = await Location.fetchAll();
    for (var location in locations) {
      expect(location.id, greaterThan(0));
      expect(location.name, hasLength(greaterThan(0)));
      expect(location.url, hasLength(greaterThan(0)));

      final fetchedLocation = await Location.fetchByID(location.id);
      expect(fetchedLocation.name, equals(location.name));
      expect(fetchedLocation.url, equals(location.url));
      expect(fetchedLocation.facts, hasLength(greaterThan(0)));
    }
  });
}