import 'package:flutter_test/flutter_test.dart'; // use this for widget testing
// import './../../lib/mocks/mock_location.dart';
// import './../../lib/app.dart';
import 'package:tourism_basic_app/mocks/mock_location.dart';
import 'package:tourism_basic_app/app.dart';
// import 'package:image_test_utils/image_test_utils.dart'; // not working with latest flutter version because of null safety
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Test app startup - Integration test', (WidgetTester tester) async {
    // image_test_utils method
    // provideMockedNetworkImages(() async {
    //   await tester.pumpWidget(App());
    //   final mocklocation = MockLocation.fetchAny();

    //   expect(find.text(mocklocation.name), findsOneWidget);
    //   expect(find.text('${mocklocation.name}sfd'), findsNothing);
    // });

    // network_image_mock method
    // mockNetworkImagesFor(() async {
    //   await tester.pumpWidget(App());
    //   final mocklocation = MockLocation.fetchAny();

    //   expect(find.text(mocklocation.name), findsOneWidget);
    //   expect(find.text('${mocklocation.name}sfd'), findsNothing);
    // });
  });
}
