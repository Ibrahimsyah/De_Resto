import 'package:de_resto/data/models/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'Should be able to parse json formatted restaurant data into given model',
      () {
    final id = "rqdv5juczeskfw1e867";
    final name = "Melting Pot";
    final description =
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor";
    final pictureId = "14";
    final city = "Medan";
    final rating = "4.2";

    final json = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    };

    Restaurant result = Restaurant.fromJson(json);
    expect(result.id, id);
    expect(result.name, name);
    expect(result.description, description);
    expect(result.pictureId, pictureId);
    expect(result.city, city);
    expect(result.rating, rating);
  });

  test('should be able to convert model to json', () {
    Restaurant test = Restaurant(
        id: 'id',
        name: 'name',
        description: 'description',
        pictureId: 'pictureid',
        city: 'city',
        rating: '10');
    var expected = {
      'id': 'id',
      'name': 'name',
      'description': 'description',
      'pictureId': 'pictureid',
      'city': 'city',
      'rating': '10'
    };
    var result = test.toJson();
    expect(result, expected);
  });
}
