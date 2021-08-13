import 'package:meta/meta.dart';

import 'package:marketplace/models/category.dart';

@immutable
class AppModel {
  final int id;
  final String name;
  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CategoryModel>? categories;

  AppModel(
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.categories,
  );

  static List<CategoryModel>? _categoryListFromJson(List<dynamic>? json) {
    if (json == null || json.length == 0) {
      return null;
    }
    return json
        .map((node) => CategoryModel.fromJson(node['category']))
        .toList();
  }

  static DateTime? _dateTimeParse(String? dateTime) {
    if (dateTime == null) {
      return null;
    }
    return DateTime.parse(dateTime);
  }

  AppModel.fromJson(Map<String, dynamic> json)
      : id = json['id']!,
        name = json['name']!,
        description = json['description']!,
        createdAt = _dateTimeParse(json['created_at']),
        updatedAt = _dateTimeParse(json['updated_at']),
        categories = _categoryListFromJson(json['app_categories']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'name': name,
      'description': description,
    };
    if (createdAt != null) {
      json['created_at'] = createdAt?.toIso8601String();
    }
    if (updatedAt != null) {
      json['updated_at'] = createdAt?.toIso8601String();
    }
    return json;
  }
}
