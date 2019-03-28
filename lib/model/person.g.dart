// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
      json['avatars'] == null
          ? null
          : ImageThree.fromJson(json['avatars'] as Map<String, dynamic>),
      json['name_en'] as String,
      json['name'] as String,
      json['alt'] as String,
      json['id'] as String);
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'avatars': instance.avatars,
      'name_en': instance.name_en,
      'name': instance.name,
      'alt': instance.alt,
      'id': instance.id
    };
