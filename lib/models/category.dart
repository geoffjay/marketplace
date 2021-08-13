import 'package:meta/meta.dart';

@immutable
class CategoryModel {
  final int id;
  final String name;

  CategoryModel(this.id, this.name);

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
