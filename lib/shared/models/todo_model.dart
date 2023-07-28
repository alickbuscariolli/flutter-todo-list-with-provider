import 'dart:convert';

import 'package:uuid/uuid.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  TodoModel({
    String? cId,
    required this.title,
    required this.description,
    DateTime? cDate,
  })  : id = cId ?? const Uuid().v4(),
        date = cDate ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      cId: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      cDate: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));
}
