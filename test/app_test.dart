import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:marketplace/models/app.dart';

void main() {
  group('AppModel', () {
    test('it constructs from JSON', () {
      final json = '''{
        "id": 1,
        "name": "foo",
        "description": "foo bar baz",
        "created_at": "2021-01-01T00:00:00",
        "updated_at": "2021-01-01T00:00:00"
      }''';
      final app = AppModel.fromJson(jsonDecode(json));

      expect(app.id, 1);
      expect(app.name, 'foo');
      expect(app.description, 'foo bar baz');
      expect(app.createdAt?.year, 2021);
      expect(app.createdAt?.month, 1);
      expect(app.createdAt?.day, 1);
      expect(app.updatedAt?.year, 2021);
      expect(app.updatedAt?.month, 1);
      expect(app.updatedAt?.day, 1);
    });

    test('it constructs from JSON without dates', () {
      final json = '''{
        "id": 1,
        "name": "foo",
        "description": "foo bar baz"
      }''';
      final app = AppModel.fromJson(jsonDecode(json));

      expect(app.id, 1);
      expect(app.name, 'foo');
      expect(app.description, 'foo bar baz');
      expect(app.createdAt, null);
      expect(app.updatedAt, null);
    });

    test('it constructs from JSON with categories', () {
      final json = '''{
        "id": 1,
        "name": "foo",
        "description": "foo bar baz",
        "app_categories": [
          {
            "category": {
              "id": 1,
              "name": "foo"
            }
          },
          {
            "category": {
              "id": 2,
              "name": "bar"
            }
          }
        ]
      }''';
      final app = AppModel.fromJson(jsonDecode(json));

      expect(app.categories?.length, 2);
      expect(app.categories?[0].id, 1);
      expect(app.categories?[0].name, 'foo');
      expect(app.categories?[1].id, 2);
      expect(app.categories?[1].name, 'bar');
    });

    test('it outputs to JSON', () {
      final app = AppModel(
        1,
        'foo',
        'foo bar baz',
        DateTime.parse('2021-01-01T00:00:00'),
        DateTime.parse('2021-01-01T00:00:00'),
        null,
      );
      final json = app.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'foo');
      expect(json['description'], 'foo bar baz');
      expect(json['created_at'], '2021-01-01T00:00:00.000');
      expect(json['updated_at'], '2021-01-01T00:00:00.000');
    });

    test('it outputs to JSON without dates', () {
      final app = AppModel(
        1,
        'foo',
        'foo bar baz',
        null,
        null,
        null,
      );
      final json = app.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'foo');
      expect(json['description'], 'foo bar baz');
      expect(json['created_at'], null);
      expect(json['updated_at'], null);
    });
  });
}
