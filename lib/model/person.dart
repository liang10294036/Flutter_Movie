import 'package:flutter_movie/model/image_three.dart';
import 'package:json_annotation/json_annotation.dart';


part 'person.g.dart';
@JsonSerializable()
class Person {
  final ImageThree avatars;
  final String name_en;
  final String name;
  final String alt;
  final String id;

  Person(this.avatars, this.name_en, this.name, this.alt, this.id);

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}