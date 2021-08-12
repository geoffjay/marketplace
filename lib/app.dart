import 'package:flutter/material.dart';

@immutable
class AppModel {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppModel(
      this.id, this.name, this.description, this.createdAt, this.updatedAt);

  AppModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'created_at': updatedAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

class App extends StatefulWidget {
  App({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Text("test");
  }
}
